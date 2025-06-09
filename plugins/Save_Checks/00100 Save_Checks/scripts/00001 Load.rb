module GamePlay
  class Load < BaseCleanUpdate
    # @param save_slot [Integer] the 1-indexed save file number
    # @param switch_id [Integer] the ID of the switch to check
    # @return [Boolean, nil] true/false if successful, nil if missing or failed
    def check_switch(save_slot, switch_id)
      return log_error('Invalid save slot. Must be 1 or higher.') if save_slot < 1

      current_index = Save.save_index
      current_state = PFM.game_state

      Save.save_index = save_slot
      filename = Save.save_filename

      begin
        other_state = Save.load(filename, no_load_parameter: true)
        return other_state&.game_switches&.[](switch_id)
      rescue StandardError
        return log_error("Targeted save doesn't exist.")
      ensure
        Save.save_index = current_index
        PFM.game_state = current_state
      end
    end

    # @param save_slot [Integer] the 1-indexed save file number
    # @param var_id [Integer] the ID of the var to check
    # @return [Boolean, nil] true/false if successful, nil if missing or failed
    def check_var(save_slot, var_id)
      return log_error('Invalid save slot. Must be 1 or higher.') if save_slot < 1

      current_index = Save.save_index
      current_state = PFM.game_state

      Save.save_index = save_index
      filename = Save.save_filename

      begin
        other_state = Save.load(filename, no_load_parameter: true)
        return other_state&.game_variables&.[](var_id)
      rescue StandardError
        return log_error("Targeted save doesn't exist.")
      ensure
        Save.save_index = current_index
        PFM.game_state = current_state
      end
    end

    # Returns all or one actor from a specific save slot
    # @param save_slot [Integer] the save file slot (1-indexed)
    # @param index [Integer, nil] optional index of the actor
    # @return [Array<PFM::PokemonBattler>, PFM::PokemonBattler, nil]
    def check_actors(save_slot, index = nil)
      with_loaded_save(save_slot) do |state|
        actors = state.actors # same as $actors in-game
        return index ? actors[index] : actors
      end
    end

    alias check_actor check_actors

    # Get the game_map from a specific save
    # @param save_slot [Integer]
    # @return [Game_Map, nil]
    def check_map_id(save_slot)
      return with_loaded_save(save_slot) { |state| state.game_map.map_id }
    end
    alias check_map check_map_id

    # Get player position and direction from a specific save
    # @param save_slot [Integer]
    # @return [Hash, nil]
    def check_player_position(save_slot)
      with_loaded_save(save_slot) do |state|
        player = state.game_player
        {
          x: player.x,
          y: player.y,
          z: player.respond_to?(:z) ? player.z : 0,
          dir: player.direction
        }
      end
    end

    # Get whether Nuzlocke is enabled in a specific save
    # @param save_slot [Integer]
    # @return [Boolean, nil]
    def nuzlocke_enabled?(save_slot)
      with_loaded_save(save_slot) do |state|
        return state.game_switches[Yuki::Sw::Nuzlocke_ENA]
      end
    end

    # Get a value from $user_data in a specific save
    # @param save_slot [Integer]
    # @param key [Symbol, String]
    # @return [Object, nil]
    def check_user_data(save_slot, key)
      with_loaded_save(save_slot) do |state|
        return state.user_data[key.to_sym]
      end
    end

    private

    # Utility to temporarily load a save and yield the game_state
    def with_loaded_save(save_slot)
      return log_error('Invalid save slot. Must be 1 or higher.') if save_slot < 1

      current_index = Save.save_index
      current_state = PFM.game_state

      Save.save_index = save_slot
      filename = Save.save_filename

      begin
        other_state = Save.load(filename, no_load_parameter: true)
        return yield(other_state) if other_state
      rescue StandardError => e
        log_error("Failed to load save #{save_slot}: #{e.message}")
      ensure
        Save.save_index = current_index
        PFM.game_state = current_state
      end

      return nil
    end
  end
end
