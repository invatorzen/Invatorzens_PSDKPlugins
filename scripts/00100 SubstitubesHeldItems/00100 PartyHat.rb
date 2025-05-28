# Prevents mental moves and randomly boosts a stat
# Concept by Substitube
# Code by Invatorzen
module Battle
  module Effects
    class Item
      class PartyHat < Item
        RANDOM_STATS = %i[atk dfe spd ats dfs eva acc]
        def on_move_prevention_target(user, target, move)
          return false if target != @target
          return unless move.mental?

          play_party_hat_effect(user, target, move)
          return true
        end

        def play_party_hat_effect(user, target, move)
          randomStat = RANDOM_STATS.sample
          @logic.scene.visual.show_item(target)
          @logic.stat_change_handler.stat_change(randomStat, 1, target, user, self)
          # @logic.scene.display_message_and_wait(parse_text_with_pokemon(999, 27, target, PFM::Text::PKNICK[1] => randomStat.to_s))
        end
      end
      register(:party_hat, PartyHat)
    end
  end
end