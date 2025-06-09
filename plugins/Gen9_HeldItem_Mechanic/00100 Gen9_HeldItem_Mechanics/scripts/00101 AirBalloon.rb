# Adds in a check to see if you have gen 9 held item mechanic on, changes how the item is consumed and the message displayed

module Battle
  module Effects
    class Item
      class AirBalloon < Item
        USED_UP = 1296 # "The Air Balloon was used up..." message

        def on_post_damage(handler, _hp, target, _launcher, skill)
          return if target != @target
          return unless skill
          return unless target.hold_item?(:air_balloon)

          if $game_switches[Yuki::Sw::Gen9HeldItems]
            handler.scene.display_message_and_wait(parse_text_with_pokemon(19,
                                                                           USED_UP - 2, target))
          else
            handler.scene.display_message_and_wait(parse_text_with_pokemon(
                                                     19, 411, target
                                                   ))
          end
          if $game_switches[Yuki::Sw::Gen9HeldItems]
            handler.logic.item_change_handler.change_item(:none, false,
                                                          target)
          else
            handler.logic.item_change_handler.change_item(
              :none, true, target
            )
          end
        end
        alias on_post_damage_death on_post_damage
      end
      register(:air_balloon, AirBalloon)
    end
  end
end
