#Adds 1 to a total NumCaught variable (491) every time the player catches a Pokémon
#Made by Invatorzen
module Battle
  class Scene
    def caught(item_wrapper)
      if (caught = logic.catch_handler.try_to_catch_pokemon(logic.alive_battlers(1)[0], logic.alive_battlers(0)[0], item_wrapper.item))
        logic.battle_info.caught_pokemon = logic.alive_battlers(1)[0]
        give_pokemon_procedure(logic.battle_info.caught_pokemon, item_wrapper.item)
        $game_variables[Yuki::Var::NumCaught] += 1
        @logic.battle_phase_end_caught
      end
      @next_update = caught ? :battle_end : :trigger_all_AI
    end
  end
end
