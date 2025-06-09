module GamePlay
  class Save
    class << self
      # Can define if its :auto
      attr_accessor :save_type

      def initialize
        super
        @save_type = :normal
      end

      def autosave(filename = Save.save_filename + '_auto', no_file = false)
        return 'NONE' unless $game_temp

        Save.save_type = :auto
        clear_states
        update_save_info
        # Call the hooks that make the save data safer and lighter
        BEFORE_SAVE_HOOKS.each_value(&:call)
        # Build the save data
        save_data = Configs.save_config.save_header.dup.force_encoding(Encoding::ASCII_8BIT)
        save_data << encrypt(Marshal.dump(PFM.game_state))
        # Save the game
        save_file(filename || Save.save_filename, save_data) unless no_file
        # Call the hooks that restore all the data
        AFTER_SAVE_HOOKS.each_value(&:call)
        return save_data
      end
    end
  end
end
