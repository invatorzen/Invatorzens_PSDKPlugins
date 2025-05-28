# Adds in a check to see if you have gen 9 held item mechanic on, changes how the item is consumed and the message displayed

module Battle
  module Effects
    class Item
      class FocusSash < Item
        USED_UP = 1293 # "[VAR PKNICK(0000)]'s Focus Sash was used up... message

        def on_post_damage(handler, hp, target, launcher, skill)
          return unless @show_message
          @show_message = false
          handler.scene.visual.show_item(target)
          handler.scene.display_message_and_wait(parse_text_with_pokemon(19, 514, target))
          handler.scene.display_message_and_wait(parse_text_with_pokemon(19, USED_UP-2, target)) if $game_switches[Yuki::Sw::Gen9HeldItems]
          $game_switches[Yuki::Sw::Gen9HeldItems] ? handler.logic.item_change_handler.change_item(:none, false, target) : handler.logic.item_change_handler.change_item(:none, true, target)
        end
      end
      register(:focus_sash, FocusSash)
    end
  end
end