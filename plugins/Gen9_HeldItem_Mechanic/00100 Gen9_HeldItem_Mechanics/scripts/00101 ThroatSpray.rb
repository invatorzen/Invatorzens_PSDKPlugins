# Adds in a new item effect for throat spray

module Battle
  module Effects
    class Item
      class ThroatSpray < Item
        USED_UP = 1299 # "[VAR PKNICK(0000)]'s Throat Spray was used up..." message

        def on_post_damage(handler, _hp, target, launcher, skill)
          return unless skill.sound_attack?

          handler.scene.visual.show_item(launcher)
          # Technically should show message saying Throat Spray boosted Mon's Special Attack, but this will do
          if handler.logic.stat_change_handler.stat_increasable?(
            :ats, launcher
          )
            handler.logic.stat_change_handler.stat_change_with_process(:ats, 1,
                                                                       launcher)
          end
          if $game_switches[Yuki::Sw::Gen9HeldItems]
            handler.scene.display_message_and_wait(parse_text_with_pokemon(19, USED_UP - 2,
                                                                           target))
          end
          if $game_switches[Yuki::Sw::Gen9HeldItems]
            handler.logic.item_change_handler.change_item(:none, false,
                                                          launcher)
          else
            handler.logic.item_change_handler.change_item(
              :none, true, launcher
            )
          end
        end
      end
      register(:throat_spray, ThroatSpray)
    end
  end
end
