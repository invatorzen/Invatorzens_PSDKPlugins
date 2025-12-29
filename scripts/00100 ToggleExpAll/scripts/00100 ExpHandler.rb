# Modifies how the golabl EXP is checked, allowing you turn turn it on/off with a switch. 
# We will set this up with a key item that calls a common event.

module Battle
  class Logic
    # Class responsive of calculating experience & EV of Pokemon when a Pokemon faints
    class ExpHandler
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

      # Exp distribution formulat when multi-exp is not in bag (thus calculated separately for all pokemon)
      # @param expable [Array<PFM::PokemonBattler>]
      # @param enemy [PFM::PokemonBattler]
      # @return [Array<[PFM::PokemonBattler, Integer]>]
      def distribute_separate_exp_for(enemy, expable)
        base_exp = exp_base(enemy)
        fought_count_during_this_turn = expable.count { |battler| battler.last_battle_turn == $game_temp.battle_turn && battler.alive? }.clamp(1, 6)
        
        # Choose who gets XP, checking if EXP all is one and if someone has XP share
        if global_multi_exp_factor?
          multi_exp_count = expable.count { |battler| battler.alive? }
        else
          multi_exp_count = expable.count { |battler| battler.item_db_symbol == :exp_share && battler.alive? }
        end
        
        multi_exp_factor = exp_multi_exp_factor(multi_exp_count)
        fought_exp_factor = exp_fought_factor(multi_exp_count, fought_count_during_this_turn)
        return expable.map do |receiver|
          exp = (base_exp * level_multiplier(enemy.level, receiver.level) * exp_multipliers(receiver)).floor
          if receiver.item_db_symbol == :exp_share && receiver.last_battle_turn != -1
            next [receiver, (exp / multi_exp_factor).to_i + (receiver.item_db_symbol == :exp_share ? exp / multi_exp_factor : 0).to_i]
          elsif receiver.last_battle_turn != $game_temp.battle_turn # Did not fight this turn
            next [receiver, (exp / multi_exp_factor).to_i]
          else
            next [receiver, (exp / fought_exp_factor).to_i + (receiver.item_db_symbol == :exp_share ? exp / multi_exp_factor : 0).to_i]
          end
        end
      end
    end
  end
end