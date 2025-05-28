# Known PSDK bug with Eject Pack: When a mon gets switched out their move still proceeds as if they didn't. Not caused by this plugin.

module Battle
  module Effects
    class Item
      class EjectPack < Item
        USED_UP = 1305 # "The Eject Pack was used up..." message

        def on_stat_change_post(handler, stat, power, target, launcher, skill)
          return if power >= 0
          return unless handler.logic.can_battler_be_replaced?(target)
          return if handler.logic.switch_request.any? { |request| request[:who] == target }
          handler.scene.visual.show_item(target)
          # Shows the "Eject Pack was used up..." message before switching
          handler.scene.display_message_and_wait(parse_text_with_pokemon(19, USED_UP-2, target)) if $game_switches[Yuki::Sw::Gen9HeldItems]
          $game_switches[Yuki::Sw::Gen9HeldItems] ? handler.logic.item_change_handler.change_item(:none, false, target) : handler.logic.item_change_handler.change_item(:none, true, target)
          handler.logic.switch_request << { who: target }
        end
      end
      register(:eject_pack, EjectPack)
    end
  end
end