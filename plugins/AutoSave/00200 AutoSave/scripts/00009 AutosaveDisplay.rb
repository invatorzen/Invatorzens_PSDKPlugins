module GamePlay
  class Load
    # Function responsive of loading all the existing saves
    # @return [Array<Hash>]
    def load_all_saves
      save_index = Save.save_index
      game_state = PFM.game_state
      Save.save_index = 0
      base_filename = Save.save_filename

      # If in Save scene, return only normal saves
      if self.class == GamePlay::Save
         all_saves = Dir["#{base_filename}*"].reject { |i| i.end_with?('.bak') || i.include?('_auto') }.map { |i| i.sub(base_filename, '').gsub(/[^0-9]/, '').to_i }
         all_saves.reject! { |i| i > Configs.save_config.maximum_save_count } unless Configs.save_config.unlimited_saves?
         last_save = all_saves.max || 0
         
         return last_save.times.map do |i|
           Save.save_index = i + 1
           next { data: Save.load(no_load_parameter: true), kind: :normal, index: i + 1 }
         end
      end

      # Load normal saves indices
      normal_save_indices = Dir["#{base_filename}*"].reject { |i| i.end_with?('.bak') || i.include?('_auto') }.map { |i| i.sub(base_filename, '').gsub(/[^0-9]/, '').to_i }
      normal_save_indices.reject! { |i| i > Configs.save_config.maximum_save_count } unless Configs.save_config.unlimited_saves?

      # Load autosaves indices
      autosave_files = Dir["#{base_filename}*_auto"]
      autosave_indices = autosave_files.map { |f| f.sub(base_filename, '').scan(/\d+/).first.to_i }

      max_index = (normal_save_indices + autosave_indices).max || 0
      
      final_list = []
      max_index.times do |i|
        idx = i + 1
        
        # Load Normal
        Save.save_index = idx
        final_list << { data: Save.load(no_load_parameter: true), kind: :normal, index: idx }
        
        # Load Autosave
        auto_file = autosave_files.find { |f| f.include?("#{base_filename}#{idx}_auto") || f.include?("#{base_filename}#{idx}-_auto") || f.include?("#{base_filename}-#{idx}_auto") }

        auto_file = autosave_files.find { |f| f.sub(base_filename, '').scan(/\d+/).first.to_i == idx }
        
        if auto_file
          final_list << { data: Save.load(auto_file, no_load_parameter: true), kind: :autosave, index: idx }
        end
      end

      return final_list
    ensure
      Save.save_index = save_index
      $pokemon_party = PFM.game_state = game_state
    end

    def load_sign_data
      max_save = Configs.save_config.maximum_save_count
      unlimited = Configs.save_config.unlimited_saves?
      @signs.each_with_index do |sign, i|
        index = i + @index - 1
        next sign.data = :hidden if index < 0 || index > @all_saves.size || (index >= max_save && !unlimited)

        save_entry = @all_saves[index]
        next sign.data = index >= @all_saves.size ? :new : :corrupted unless save_entry && save_entry[:data]

        sign.save_index = save_entry[:index]
        sign.mode = save_entry[:kind]
        sign.data = save_entry[:data]
      end
    end

    # Load the current game
    def load_game
      @all_saves[@index][:data].expand_global_var
      Save.save_index = @all_saves[@index][:index] # Set the save index
      PFM.game_state.load_parameters
      $game_system.se_play($data_system.cursor_se)
      $game_map.setup($game_map.map_id)
      $game_player.moveto($game_player.x, $game_player.y) # center
      $game_party.refresh
      $game_system.bgm_play($game_system.playing_bgm)
      $game_system.bgs_play($game_system.playing_bgs)
      $game_map.update
      $game_temp.message_window_showing = false
      $trainer.load_time
      Pathfinding.load
      $trainer.redefine_var
      Yuki::FollowMe.set_battle_entry
      PFM.game_state.env.reset_zone
      $scene = Scene_Map.new
      Yuki::TJN.force_update_tone
      @running = false
    end
  end
end

module UI
  class SaveSign
    # Get the mode of the save (:normal or :autosave)
    # @return [Symbol]
    attr_accessor :mode

    alias original_show_data show_data
    def show_data(value)
      @swap_sprites.each { |sp| sp.visible = true }
      @background.load('load/box_main', :interface)
      @cursor.load('load/cursor_main', :interface)
      
      if @mode == :autosave
        @save_text.text = "Auto #{@save_index}"
      else
        @save_text.text = format(save_index_message, @save_index)
      end
      
      @new_corrupted_text.visible = false
      show_save_data(value)
    end
  end
end
