module Battle
  class Logic
    # Handler responsive of answering properly status changes requests
    class StatusChangeHandler < ChangeHandlerBase
      APPLY_MESSAGE_LINE = 2 # Line with "[VAR PKNICK(0000)] got frostbite!" in 100019.csv

      # List of message ID when applying a status
      STATUS_APPLY_MESSAGE[:freeze] = APPLY_MESSAGE_LINE - 2

      # Function that actually change the status
      # @param status [Symbol] :poison, :toxic, :confusion, :sleep, :freeze, :paralysis, :burn, :flinch, :cure, :confuse_cure
      # @param target [PFM::PokemonBattler]
      # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
      # @param skill [Battle::Move, nil] Potential move used
      # @param message_overwrite [Integer] Index of the message to use of file 19 to apply the status (if there's specific reason)
      def status_change(status, target, launcher = nil, skill = nil, message_overwrite: nil)
        log_data("# status_change(#{status}, #{target}, #{launcher}, #{skill})")
        case status
        when :cure
          @was_frozen = target.frozen?
          message_overwrite ||= cure_message_id(target)
          target.send(STATUS_APPLY_METHODS[status])
        when :confuse_cure
          target.effects.get(:confusion)&.kill
          target.effects.delete_specific_dead_effect(:confusion)
          message_overwrite = 351
        else
          message_overwrite ||= STATUS_APPLY_MESSAGE[status]
          target.send(STATUS_APPLY_METHODS[status], true)
          @scene.visual.show_rmxp_animation(target, STATUS_APPLY_ANIMATION[status])
        end
        @scene.display_message_and_wait(parse_text_with_pokemon(@was_frozen || status == :freeze ? 400000 : 19, message_overwrite, target)) if message_overwrite
      ensure
        @scene.visual.refresh_info_bar(target)
      end

      module Frostbite_StatusChangeHandler_Override
        # Get the message ID for the curing message
        # @param target [PFM::PokemonBattler]
        # @return [Integer]
        def cure_message_id(target)
          return APPLY_MESSAGE_LINE + 4 if target.frozen?
          return super
        end

        def check_status_prevention(status, target, launcher, skill)
          result = super
          return result if result == :prevent

          if status == :freeze && !target.can_be_frozen?(skill&.type || 0)
            return prevent_change do
              scene.display_message_and_wait(parse_text_with_pokemon(400000, APPLY_MESSAGE_LINE + 10, target)) if skill.nil? || skill.status?
            end
          end

          return nil
        end
      end
      prepend Frostbite_StatusChangeHandler_Override
    end
  end
end