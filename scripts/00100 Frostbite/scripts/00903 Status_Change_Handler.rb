module Battle
  class Logic
    # Handler responsive of answering properly status changes requests
    class StatusChangeHandler < ChangeHandlerBase
      include Hooks

      # List of method to call in order to apply the status on the Pokemon
      STATUS_APPLY_METHODS[:frostbite] = :status_frostbite
      # List of message ID when applying a status
      STATUS_APPLY_MESSAGE[:frostbite] = 1257
      # List of animation ID when applying a status
      STATUS_APPLY_ANIMATION[:frostbite] = 474

      # Get the message ID for the curing message
      # @param target [PFM::PokemonBattler]
      # @return [Integer]
      alias default_cure_messages cure_message_id 
      def cure_message_id(target)
        return 294 if target.frostbitten?
        return default_cure_messages(target)
      end

      # Cannot be frozen
      StatusChangeHandler.register_status_prevention_hook('PSDK status prev: can_be_frozen') do |handler, status, target, _, skill|
        next if status != :frostbite || target.can_be_frostbite?(skill&.type || 0)

        next handler.prevent_change do
          handler.scene.display_message_and_wait(parse_text_with_pokemon(19, 300, target)) if skill.nil? || skill.status?
        end
      end
    end
  end
end