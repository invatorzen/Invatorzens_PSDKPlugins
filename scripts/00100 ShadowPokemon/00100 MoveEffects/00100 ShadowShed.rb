module Battle
  class Move
    class ShadowShed < BasicWithSuccessfulEffect
      private

      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        logic.bank_effects.each_with_index do |bank_effect, bank_index|
          bank_effect.each do |e|
            e.kill if effects_to_kill.include?(e.name)
          end
        end
      end

      # List of the effects to kill on the enemy board
      # @return [Array<Symbol>]
      def effects_to_kill
        return %i[light_screen reflect safeguard mist aurora_veil]
      end
    end
    Move.register(:s_shadow_shed, ShadowShed)
  end
end