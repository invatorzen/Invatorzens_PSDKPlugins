# Scene_Map Debug Hook
# Adds F8 hotkey to open debug menu from overworld
# Also provides open_debug_menu command for script calls

module DebugMenu
  # F8 key code (0x77 = 119)
  F8_KEYCODE = 0x77

  module SceneMapHook
    # Hook called when the scene logic updates calling requests.
    # Checks for debug menu hotkey trigger.
    def update_scene_calling
      # Check for debug menu trigger first
      if debug_menu_trigger?
        unless $game_system.map_interpreter.running? || $game_player.moving? || $game_player.sliding?
          call_scene(GamePlay::DebugMenu)
          return
        end
      end
      # Call original method
      super
    end

    private

    # Checks if the debug menu hotkey (F8) is triggered.
    # @return [Boolean] true if triggered, false otherwise.
    def debug_menu_trigger?
      return false unless debug?
      # Try using constant, fallback to raw keycode
      begin
        return Input::Keyboard.press?(Input::Keyboard::F8)
      rescue
        # F8 key code is 0x77 (119)
        return Input::Keyboard.press?(DebugMenu::F8_KEYCODE)
      end
    end
  end

  # Interpreter command to open debug menu from script calls
  module InterpreterCommand
    # Interpreter command to open the debug menu.
    # @return [Boolean, nil] true if opened, otherwise nil.
    def open_debug_menu
      return unless debug?
      GamePlay.current_scene.call_scene(GamePlay::DebugMenu)
      return true
    end
  end
end

# Apply the hooks
Scene_Map.prepend(DebugMenu::SceneMapHook)
Interpreter.include(DebugMenu::InterpreterCommand)

