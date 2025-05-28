# Known PSDK bug with Eject Button: When a mon gets switched out their move still proceeds as if they didn't. Not caused by this plugin.

module Battle
  module Effects
    class Item
      class EjectButton < Item
        USED_UP = 1302 # "The Eject Button was used up..." message

        def on_post_damage(handler, hp, target, launcher, skill)
          return if target != @target
          return unless skill && launcher != target && handler.logic.can_battler_be_replaced?(target)
          return if handler.logic.switch_request.any? { |request| request[:who] == target }
  
          handler.scene.visual.show_item(target)
          # Shows the "Eject Button was used up..." message before switching
          handler.scene.display_message_and_wait(parse_text_with_pokemon(19, USED_UP-2, target)) if $game_switches[Yuki::Sw::Gen9HeldItems]
          $game_switches[Yuki::Sw::Gen9HeldItems] ? handler.logic.item_change_handler.change_item(:none, false, target) : handler.logic.item_change_handler.change_item(:none, true, target)
          handler.logic.switch_request << { who: target }
        end
      end
      register(:eject_button, EjectButton)
    end
  end
end