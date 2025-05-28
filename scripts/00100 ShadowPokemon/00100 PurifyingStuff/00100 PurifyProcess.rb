# Adds purify_pokemon method
class Interpreter
  def purify_pokemon
    block = proc { |scene| $game_variables[::Yuki::Var::Party_Menu_Sel] = scene.return_data }
    GamePlay.open_party_menu_to_purify_pokemon($actors, &block)
    $game_variables[::Yuki::Var::Party_Menu_Sel] = -1
  end
end

# Calls the party menu scene
module GamePlay
  class << self
    # Open the party menu to purify a Pokemon
    # @param party [Array<PFM::Pokemon>] party that contains the Pokemon to separate
    # @param pokemon_db_symbol [Symbol] db_symbol of the Pokemon to separate
    def open_party_menu_to_purify_pokemon(party, &block)
      current_scene.call_scene(party_menu_class, party, :purify, &block)
    end
  end
end

# Purify process
module PFM
  class Pokemon
    def purify
      return unless shadow?
      @purified = true
      @shadow = false
    end
  end
end

module GamePlay
  class Party_Menu
    LEARNS_NEW_MOVE = {
      :pikachu => :refresh
    }
    #include Util::GiveTakeItem
    CHOICE_METHODS[:purify] = :purify_mode
    def purify_mode
      # @type [PFM::Pokemon]
      pokemon = @party[@index]
      return display_message(text_get(18, 70)) if pokemon.dead?
      return display_message(text_get(998, 2)) if pokemon.purified?
      return display_message(text_get(998, 0)) if !pokemon.shadow?
      pokemon.purify
      # TO DO
      # Show purification scene then next message
      display_message(parse_text_with_pokemon(998, 3, pokemon)) # Pokémon opened the door to its heart! message
      # Lose shadow moves, force learn latest 4 moves
      # Devs need to ensure that Shadow Pokémon only have 2 shadow moves for this to work properly. 
      # No new moves that they don't normally learn, or else they relearn moves they shouldn't know.
      pokemon.replace_skill_index(0, LEARNS_NEW_MOVE.key?(pokemon.db_symbol) ? pokemon.skill_learnt[-4] : pokemon.skill_learnt[-3])
      pokemon.replace_skill_index(1, LEARNS_NEW_MOVE.key?(pokemon.db_symbol) ? LEARNS_NEW_MOVE[pokemon.db_symbol] : pokemon.skill_learnt[-4])
      # Reward EXP
      #give_exp()
      # Evolve check
      pokemon.evolve_check
      @running = false
    end
  end
end