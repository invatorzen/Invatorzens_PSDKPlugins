module Battle
    class Move
      class ShadowHalf < BasicWithSuccessfulEffect
        private
  
        # Function that deals the effect to the pokemon
        # @param user [PFM::PokemonBattler] user of the move
        # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
        def deal_effect(user, actual_targets)
          actual_targets.each do |target|
            if target.hp > 1
              hp = (target.hp / 2).floor
              scene.visual.show_hp_animations([target], [-hp])
            end
          end
          # scene.display_message_and_wait(parse_text(998, 0))
        end
      end
      Move.register(:s_shadow_half, ShadowHalf)
    end
  end