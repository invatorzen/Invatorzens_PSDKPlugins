module PFM
  # AutoSave class, whole purpose is to tell if it should show animation after a battle
  class AutoSave
    attr_accessor :waiting_for_animation

    def initialize
      @waiting_for_animation = false
    end
  end

  class GameState
    attr_accessor :autosave

    # Sets up $autosave so I can check it after battles
    safe_code('Setup AutoSave in GameState') do
      on_player_initialize(:autosave) { @autosave = PFM::AutoSave.new }
      on_expand_global_variables(:autosave) do
        @autosave ||= PFM::AutoSave.new
        $autosave = @autosave
      end
    end
  end
end
