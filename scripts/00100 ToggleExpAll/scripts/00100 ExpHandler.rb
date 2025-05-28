# Modifies how the golabl EXP is checked, allowing you turn turn it on/off with a switch. 
# We will set this up with a key item that calls a common event.

module Battle
  class Logic
    # Class responsive of calculating experience & EV of Pokemon when a Pokemon faints
    class ExpHandler
      include Hooks
      # Get the logic object
      # @return [Battle::Logic]
      attr_reader :logic

      private

      # Tell if the exp factor is global or on pokemon that fought
      # @return [Boolean]
      def global_multi_exp_factor?
        $game_switches[Yuki::Sw::ExpAll] # If switch 127 is on, global exp is on
      end

      # Get the list of Pokemon that should receive the exp
      # @param enemy [PFM::PokemonBattler]
      # @return [Array<PFM::PokemonBattler>]
      def expable_pokemon(enemy)
        if !$game_switches[Yuki::Sw::BT_HardExp] || global_multi_exp_factor?
          return logic.trainer_battlers.reject { |receiver| receiver.max_level == receiver.level || receiver.dead? }
        else
          return logic.trainer_battlers.reject do |receiver|
            receiver.delete_battler_to_encounter_list(enemy) if (has_encountered = receiver.encountered?(enemy))
            next receiver.max_level == receiver.level || receiver.dead? || !(has_encountered || receiver.item_db_symbol == :exp_share)
          end
        end
      end

      # Exp distribution formula when exp all is on (including when EXP Share is held by a mon)
      # @param expable [Array<PFM::PokemonBattler>]
      # @param enemy [PFM::PokemonBattler]
      # @return [Array<[PFM::PokemonBattler, Integer]>]
      def distribute_global_exp_for(enemy, expable)
        base_exp = exp_base(enemy)
        
        # Check if we have someone holding EXP Share
        multi_exp_count = expable.count { |battler| battler.item_db_symbol == :exp_share && battler.alive? }
        multi_exp_factor = exp_multi_exp_factor(multi_exp_count)

        # Reward EXP
        return expable.map do |receiver|
          exp = (base_exp * level_multiplier(enemy.level, receiver.level) * exp_multipliers(receiver)).floor
          exp /= (receiver.last_battle_turn == $game_temp.battle_turn ? 1 : (receiver.item_db_symbol == :exp_share ? 1 : 2)) * ($game_switches[Yuki::Sw::BT_ScaledExp] ? 5 : 7)
          next [receiver, exp]
        end
      end
    end
  end
end