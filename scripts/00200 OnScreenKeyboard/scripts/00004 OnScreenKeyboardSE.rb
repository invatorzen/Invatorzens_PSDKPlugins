module UI
  class OnScreenKeyboardUI
    # Sound effect when the user switches modes
    def play_switch_mode_se
      return Audio.se_play('audio/se/se_gui_pokedex_select')
    end

    # Sound effect when the user moves cursor
    def play_cursor_se
      return $game_system.se_play($data_system.cursor_se)
    end

    # Sound effect when the user confirms an action
    def play_ok_se
      space_row_index = %i[foreign foreign_upper].include?(@mode) ? 3 : 2
      return $game_system.se_play($data_system.decision_se) unless @cursor_y == space_row_index

      case @cursor_x
      when 0
        return play_cancel_se
      when 1..2
        return $game_system.se_play($data_system.decision_se)
      else
        return play_switch_mode_se
      end
    end

    # Sound effect when user opens or closes keyboard
    def play_open_keyboard_se
      return Audio.se_play('audio/se/se_gui_pokedex_open')
    end

    # Sound effect when user cancel/deletes something
    def play_cancel_se
      return $game_system.se_play($data_system.cancel_se)
    end
  end
end
