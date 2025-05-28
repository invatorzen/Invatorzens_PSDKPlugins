module Battle
    module Effects
      class Item
        class RedCard < Item
          USED_UP = 1314 # "[VAR PKNICK(0000)]'s Red Card was used up..."
          def on_post_damage(handler, hp, target, launcher, skill)
            return if target != @target
            return unless skill && launcher != target && handler.logic.can_battler_be_replaced?(launcher)
            return if handler.logic.switch_request.any? { |request| request[:who] == launcher }
            handler.scene.visual.show_item(target)
            rand_pkmn = (@logic.alive_battlers_without_check(launcher.bank).select { |p| p if p.party_id == launcher.party_id && p.position == -1 }).compact
            logic.switch_request << { who: launcher, with: rand_pkmn.sample } unless rand_pkmn.empty?
            handler.scene.display_message_and_wait(parse_text_with_pokemon(19, USED_UP-2, target)) if $game_switches[Yuki::Sw::Gen9HeldItems]
            $game_switches[Yuki::Sw::Gen9HeldItems] ? handler.logic.item_change_handler.change_item(:none, false, target) : handler.logic.item_change_handler.change_item(:none, true, target)
          end
        end
        register(:red_card, RedCard)
      end
    end
  end