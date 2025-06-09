module Battle
  class Logic
    # Handler responsive of answering properly status changes requests
    class StatusChangeHandler < ChangeHandlerBase
      APPLY_MESSAGE_LINE = 2 # Line with "[VAR PKNICK(0000)] got frostbite!" in 100019.csv

      # List of message ID when applying a status
      STATUS_APPLY_MESSAGE[:freeze] = APPLY_MESSAGE_LINE - 2

      alias default_status_change status_change
      def status_change(status, target, launcher = nil, skill = nil, message_overwrite: nil)
        log_data("# status_change(#{status}, #{target}, #{launcher}, #{skill})")
        case status
        when :freeze
          message_overwrite ||= STATUS_APPLY_MESSAGE[status]
          target.send(STATUS_APPLY_METHODS[status], true)
          @scene.visual.show_rmxp_animation(target, STATUS_APPLY_ANIMATION[status])
        end
        if target.frozen?
          @scene.display_message_and_wait(parse_text_with_pokemon(300_000, message_overwrite,
                                                                  target))
        end
        default_status_change(status, target, nil, nil, message_overwrite: nil) unless target.frozen?
      end

      # Get the message ID for the curing message
      # @param target [PFM::PokemonBattler]
      # @return [Integer]
      alias default_cure_messages cure_message_id
      def cure_message_id(target)
        return 16 if target.frozen?

        default_cure_messages(target)
      end

      # Cannot be frozen
      StatusChangeHandler.register_status_prevention_hook('PSDK status prev: can_be_frozen') do |handler, status, target, _, skill|
        next if status != :freeze || target.can_be_frozen?(skill&.type || 0)

        next handler.prevent_change do
          if skill.nil? || skill.status?
            handler.scene.display_message_and_wait(parse_text_with_pokemon(300_000, APPLY_MESSAGE_LINE + 10,
                                                                           target))
          end
        end
      end
    end
  end
end
