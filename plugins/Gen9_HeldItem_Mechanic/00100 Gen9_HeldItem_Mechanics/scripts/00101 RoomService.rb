module Battle
  module Effects
    class Item
      class RoomService < Item
        USED_UP = 1317 # "[VAR PKNICK(0000)]'s Room Service was used up..." message

        def on_end_turn_event(logic, scene, _battlers)
          return unless scene.logic.terrain_effects.has?(:trick_room)

          scene.visual.show_item(@target)
          if logic.stat_change_handler.stat_increasable?(
            :ats, @target
          )
            logic.stat_change_handler.stat_change_with_process(:spd, -2,
                                                               @target)
          end
          if $game_switches[Yuki::Sw::Gen9HeldItems]
            scene.display_message_and_wait(parse_text_with_pokemon(19, USED_UP - 2,
                                                                   @target))
          end
          if $game_switches[Yuki::Sw::Gen9HeldItems]
            logic.item_change_handler.change_item(:none, false,
                                                  @target)
          else
            logic.item_change_handler.change_item(
              :none, true, @target
            )
          end
        end
      end
      register(:room_service, RoomService)
    end
  end
end
