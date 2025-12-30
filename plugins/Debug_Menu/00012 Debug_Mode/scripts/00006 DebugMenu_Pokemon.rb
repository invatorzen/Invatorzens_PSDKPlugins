# Debug Menu - Pokémon Actions
# Contains actions related to Pokémon management, storage, and hatching

module GamePlay
  class DebugMenu
    # Add a Pokémon to the party or storage.
    # Prompts for species name and level.
    def add_pokemon
      species_input = display_text_input(text_get(TEXT_FILE_ID, 48), 'pikachu')
      return if species_input.nil? || species_input.empty?

      species_sym = species_input.downcase.to_sym

      # Verify species exists
      begin
        creature = data_creature(species_sym)
        unless creature && creature.id > 0
          display_message(format(text_get(TEXT_FILE_ID, 87), species_sym))
          return
        end
      rescue
        display_message(format(text_get(TEXT_FILE_ID, 87), species_sym))
        return
      end

      level = display_number_input(text_get(TEXT_FILE_ID, 50), 50)
      return if level.nil?
      level = [[level, 1].max, 100].min

      pokemon = PFM::Pokemon.new(species_sym, level)
      
      if $actors.size < 6
        $actors << pokemon
        display_message(format(text_get(TEXT_FILE_ID, 88), pokemon.name))
      else
        $storage.store(pokemon)
        display_message(format(text_get(TEXT_FILE_ID, 89), pokemon.name))
      end
    end

    # Fill all storage boxes with one of every species.
    def fill_storage
      count = 0
      each_data_creature do |creature|
        next if creature.db_symbol == :__undef__ || creature.id == 0
        
        pokemon = PFM::Pokemon.new(creature.db_symbol, 50)
        $storage.store(pokemon)
        $pokedex.mark_seen(creature.id, pokemon.form)
        count += 1
      end
      display_message(format(text_get(TEXT_FILE_ID, 90), count))
    end

    # Clear all storage boxes.
    # Requires double confirmation via list choice.
    def clear_storage
      choice = display_list_choice(text_get(TEXT_FILE_ID, 54), [text_get(TEXT_FILE_ID, 55), text_get(TEXT_FILE_ID, 56)])
      return if choice != 0

      # Clear all boxes
      $storage.max_box.times do |box_idx|
        $storage.get_box_content(box_idx).map! { nil }
      end
      display_message(text_get(TEXT_FILE_ID, 57))
    end

    # Set all eggs in party to hatch after one more step.
    def quick_hatch_eggs
      count = 0
      $actors.each do |pokemon|
        if pokemon.egg?
          pokemon.step_remaining = 1
          count += 1
        end
      end
      msg = count > 0 ? format(text_get(TEXT_FILE_ID, 91), count) : text_get(TEXT_FILE_ID, 92)
      display_message(msg)
    end

    # Open the Pokémon Storage System interface.
    def access_storage
      GamePlay.open_pokemon_storage_system
    end
  end
end
