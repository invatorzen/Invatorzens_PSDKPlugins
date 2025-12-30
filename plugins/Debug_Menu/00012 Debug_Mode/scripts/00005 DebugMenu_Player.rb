# Debug Menu - Player Actions
# Contains actions related to the player character, progress, and movement

module GamePlay
  class DebugMenu
    # Warp to a specific map and coordinates.
    # Prompts for Map ID, X, and Y.
    def warp_to_map
      map_id = display_number_input(text_get(TEXT_FILE_ID, 80), $game_map.map_id)
      return if map_id.nil?

      x_pos = display_number_input(text_get(TEXT_FILE_ID, 81), $game_player.x)
      return if x_pos.nil?

      y_pos = display_number_input(text_get(TEXT_FILE_ID, 82), $game_player.y)
      return if y_pos.nil?

      @running = false
      Debugger.warp(map_id, x_pos, y_pos)
    end

    # Heal all Pokémon in the player's party.
    # Restores HP, status, and PP.
    def heal_party
      $pokemon_party.actors.each do |pokemon|
        pokemon.cure
        pokemon.hp = pokemon.max_hp
        pokemon.skills_set.each { |skill| skill.pp = skill.ppmax if skill }
      end
      display_message(text_get(TEXT_FILE_ID, 83))
    end

    # Set the player's money amount.
    # Prompts for a new numeric value.
    def set_money
      new_money = display_number_input(text_get(TEXT_FILE_ID, 25), PFM.game_state.money)
      return if new_money.nil?
      PFM.game_state.money = [new_money, 0].max
      display_message(format(text_get(TEXT_FILE_ID, 84), PFM.game_state.money))
    end

    # Open the badge management interface.
    # Allows toggling badges for any region.
    def set_gym_badges
      regions = []
      each_data_world_map do |wm|
        regions << { id: wm.id, name: format(text_get(TEXT_FILE_ID, 105), wm.id + 1) }
      end
      regions << { id: 0, name: text_get(TEXT_FILE_ID, 106) } if regions.empty?

      current_region_id = PFM.game_state.env.get_worldmap
      region_index = regions.index { |r| r[:id] == current_region_id } || 0
      last_badge_index = 0

      loop do
        region = regions[region_index] || regions[0]
        region_id = region[:id]
        
        badge_options = (1..8).map do |i|
          status = $trainer.badge_obtained?(i, region_id) ? text_get(TEXT_FILE_ID, 41) : text_get(TEXT_FILE_ID, 42)
          format(text_get(TEXT_FILE_ID, 40), i, status)
        end
        badge_options << text_get(TEXT_FILE_ID, 39)

        choice = display_list_choice_paged(format(text_get(TEXT_FILE_ID, 38), region[:name]), badge_options, region_index, [0, regions.size - 1].max, last_badge_index)
        
        case choice
        when :next_page, :last
          region_index = (region_index + 1) % regions.size
          last_badge_index = 0
        when :prev_page, :first
          region_index = (region_index - 1) % regions.size
          last_badge_index = 0
        when -1, nil
          break
        else
          break if badge_options[choice] == 'Exit'
          
          last_badge_index = choice
          badge_num = choice + 1
          new_state = !$trainer.badge_obtained?(badge_num, region_id)
          $trainer.set_badge(badge_num, region_id, new_state)
        end
      end
    end

    # Toggle running shoes availability.
    # Switches the state of game switch 57.
    def toggle_running_shoes
      $game_switches[57] = !$game_switches[57]
      display_message(text_get(TEXT_FILE_ID, $game_switches[57] ? 96 : 97))
    end

    # Toggle Pokédex availability.
    # Switches the pokedex-related game switch.
    def toggle_pokedex
      $game_switches[Yuki::Sw::Pokedex] = !$game_switches[Yuki::Sw::Pokedex]
      display_message(text_get(TEXT_FILE_ID, $game_switches[Yuki::Sw::Pokedex] ? 99 : 98))
    end

    # Change the player's name.
    # Prompts for a text string.
    def set_player_name
      new_name = display_text_input(text_get(TEXT_FILE_ID, 100), $trainer.name)
      return if new_name.nil? || new_name.empty?
      $trainer.name = new_name
      display_message(format(text_get(TEXT_FILE_ID, 85), $trainer.name))
    end

    # Randomize the player's trainer ID.
    def randomize_player_id
      new_id = rand(2**32)
      $trainer.instance_variable_set(:@id, new_id)
      display_message(format(text_get(TEXT_FILE_ID, 86), new_id))
    end

    # Open the Pokémon Storage System
    # @note same as other option, we will change it at some point
    def use_pc
      GamePlay.open_pokemon_storage_system
    end
  end
end
