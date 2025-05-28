module Battle
    module Effects
      class Item
        class WhiteHerb < Item
          USED_UP = 1308 # "The White Herb was used up..." message
          
          def on_post_action_event(logic, scene, battlers)
            return unless battlers.include?(@target)
            return if @target.dead?
            return if @target.battle_stage.none?(&:negative?)
  
            scene.visual.show_item(@target)
            scene.display_message_and_wait(parse_text_with_pokemon(19, 1016, @target, PFM::Text::ITEM2[1] => @target.item_name))
            @target.battle_stage.map! { |stage| stage.negative? ? 0 : stage }
            # Shows the "White Herb was used up..." message before switching
            scene.display_message_and_wait(parse_text_with_pokemon(19, USED_UP-2, @target)) if $game_switches[Yuki::Sw::Gen9HeldItems]
            $game_switches[Yuki::Sw::Gen9HeldItems] ? logic.item_change_handler.change_item(:none, false, @target) : logic.item_change_handler.change_item(:none, true, @target)
          end
        end
        register(:white_herb, WhiteHerb)
      end
    end
  end
  