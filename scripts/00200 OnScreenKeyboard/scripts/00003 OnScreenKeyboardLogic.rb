module UI
  class OnScreenKeyboardUI
    # Handles the input for the keyboard
    def update_inputs
      change_visibility if Input.trigger?(:SELECT)
      return unless visible

      if Input.trigger?(:L)
        switch_mode(-1)
        return
      elsif Input.trigger?(:R)
        switch_mode(1)
        return
      elsif Input.trigger?(:UP)
        move_cursor(0, -1)
      elsif Input.trigger?(:DOWN)
        move_cursor(0, 1)
      elsif Input.trigger?(:LEFT)
        move_cursor(-1, 0)
      elsif Input.trigger?(:RIGHT)
        move_cursor(1, 0)
      elsif Input.trigger?(:B)
        play_cancel_se
        @name_input_ui.remove_char
      elsif Input.trigger?(:START)
        play_ok_se
        @scene.send(:confirm_name)
      elsif Input.trigger?(:A)
        handle_selection
      end
    end

    private

    # Changes the visibility of the scene
    def change_visibility
      play_open_keyboard_se
      @buttons.visible = !@buttons.visible
      return self.visible = !visible
    end

    # Handles moving the cursor
    # @param dx [Integer] the x offset we move
    # @param dy [Integer] the y offset we move
    def move_cursor(dx, dy)
      play_cursor_se
      @key_texts[@cursor_y][@cursor_x].opacity = 128

      is_foreign = %i[foreign foreign_upper].include?(@mode)
      space_row_index = is_foreign ? 3 : 2
      @key_texts.size

      # Always update last_x when not on the space row
      @last_x = @cursor_x unless @cursor_y == space_row_index

      # If above space row, and going down
      if @cursor_y == space_row_index - 1 && dy == 1
        get_shortcut_position
      elsif @cursor_y == 0 && dy == -1
        get_shortcut_position
      elsif is_foreign && @cursor_x >= 3 && @cursor_y == 1 && dy == 1
        @cursor_y = 2
        @cursor_x = @key_texts[2].size - 1 # Foreign and foreign upper are same size on this row, so should be fine
      else
        # Regular move within the grid
        new_y = (@cursor_y + dy) % @key_texts.size
        new_x = (@cursor_x + dx) % @key_texts[new_y].size
        @cursor_y = new_y
        @cursor_x = new_x
      end

      return select_key(@cursor_x, @cursor_y)
    end

    # Handles the input of a character
    def handle_selection
      play_ok_se
      key = current_key_rows[@cursor_y][@cursor_x]
      case key
      when '←'
        @name_input_ui.remove_char
      when 'OK'
        play_ok_se
        return @scene.send(:confirm_name)
      when 'Space'
        return @name_input_ui.add_char(' ')
      when 'abc'
        @mode = :lower
        return refresh_keys
      when 'ABC'
        @mode = :upper
        return refresh_keys
      when 'áéí'
        @mode = :foreign
        return refresh_keys
      when 'ÁÉÍ'
        @mode = :foreign_upper
        return refresh_keys
      when '123'
        @mode = :symbol
        return refresh_keys
      when '♥♦♣'
        @mode = :symbol2
        return refresh_keys
      else
        return @name_input_ui.add_char(key)
      end
    end

    # Updates the keys when changing modes
    def refresh_keys
      @key_texts.flatten.each(&:dispose)
      previous_row_count = @key_texts&.size || 3
      create_keys
      new_row_count = @key_texts.size
      @cursor_y = new_row_count - 1 if new_row_count > previous_row_count

      # Clamp cursor to fit the new layout if necessary
      @cursor_y = [@cursor_y, @key_texts.size - 1].min
      @cursor_x = [@cursor_x, @key_texts[@cursor_y].size - 1].min

      select_key(@cursor_x, @cursor_y)
    end

    # Switches between the modes
    # @param dir [Integer] direction to switch (-1 = left, 1 = right)
    def switch_mode(dir)
      play_switch_mode_se
      modes = %i[upper lower foreign foreign_upper symbol symbol2]
      index = modes.index(@mode)
      @mode = modes[(index + dir) % modes.size]

      # Store current cursor position
      prev_x = @cursor_x
      prev_y = @cursor_y

      refresh_keys

      # Clamp to new valid Y range
      @cursor_y = [prev_y, @key_texts.size - 1].min

      # Clamp X using the new row’s length
      @cursor_x = [prev_x, @key_texts[@cursor_y].size - 1].min

      select_key(@cursor_x, @cursor_y)
    end

    # Changes the opacity of the selected key (and all other keys)
    def select_key(x, y)
      @key_texts.flatten.each { |text| text.opacity = 128 }
      @cursor_x = x
      @cursor_y = y
      @key_texts[y][x].opacity = 255
    end
  end
end
