# Debug Menu - UI Helpers
# Provides UI elements for debug menu interactions

module GamePlay
  class DebugMenu
    # Display a simple message box
    # @param text [String] the text to display
    def display_message(text)
      reset_input_states
      
      # Simple message display
      msg_sprite = Sprite.new(@viewport)
      msg_sprite.bitmap = Bitmap.new(300, 40)
      msg_sprite.bitmap.fill_rect(0, 0, 300, 40, Color.new(0, 0, 0, 200))
      msg_sprite.x = (Graphics.width - 300) / 2
      msg_sprite.y = Graphics.height - 60
      msg_sprite.z = 100

      msg_text = Text.new(0, @viewport, msg_sprite.x, msg_sprite.y + 10, 300, 20, text, 1, 1, 9)
      msg_text.z = 101

      # Wait for input
      loop do
        Graphics.update
        break if confirm_pressed? || cancel_pressed? || Mouse.trigger?(:LEFT)
      end

      msg_sprite.bitmap.dispose
      msg_sprite.dispose
      msg_text.dispose
    end

    # Display a list choice
    # @param title [String] the title of the choice box
    # @param options [Array<String>] the list of options
    # @return [Integer] the selected index or -1 for cancel
    # Display a list choice dialog.
    # @param title [String] the title of the choice box.
    # @param options [Array<String>] the list of options.
    # @return [Integer] the selected index or -1 for cancel.
    def display_list_choice(title, options)
      display_list_choice_paged(title, options, nil, nil)
    end

    # Display a list choice with page navigation support and persistent index
    # @param title [String] the title of the choice box
    # @param options [Array<String>] the list of options
    # @param current_page [Integer, nil] the current page index for pagination label
    # @param max_page [Integer, nil] the max page index for pagination label
    # @param default_index [Integer] the initial cursor position
    # @return [Integer, Symbol] index (Integer), :next_page, :prev_page, :first, :last, or -1 for cancel
    def display_list_choice_paged(title, options, current_page = nil, max_page = nil, default_index = 0)
      reset_input_states
      # Create choice window
      choice_sprite = Sprite.new(@viewport)
      choice_sprite.bitmap = Bitmap.new(300, 240)
      choice_sprite.bitmap.fill_rect(0, 0, 300, 240, Color.new(30, 30, 50, 240))
      choice_sprite.x = (Graphics.width - 300) / 2
      choice_sprite.y = 30
      choice_sprite.z = 50

      title_text = Text.new(0, @viewport, choice_sprite.x, choice_sprite.y + 5, 300, 20, title, 1, 1, 9)
      title_text.z = 51

      # Instructions for paged mode
      if current_page && max_page
        inst_text = Text.new(0, @viewport, choice_sprite.x, choice_sprite.y + 220, 300, 16, 
                             text_get(TEXT_FILE_ID, 33), 1, 1, 9)
        inst_text.z = 51
      else
        inst_text = nil
      end

      max_visible = 8
      index = [[default_index, 0].max, options.size - 1].min
      scroll = (index / max_visible) * max_visible
      scroll = [[scroll, 0].max, options.size - max_visible].min if options.size > max_visible

      option_texts = max_visible.times.map do |i|
        t = Text.new(0, @viewport, choice_sprite.x + 15, choice_sprite.y + 28 + (i * 22), 270, 20, '', 0, 1, 9)
        t.z = 51
        t
      end

      # We still need a cursor sprite for highlighting
      cursor = Sprite.new(@viewport)
      cursor.bitmap = Bitmap.new(280, 20)
      cursor.bitmap.fill_rect(0, 0, 280, 20, Color.new(100, 150, 255, 100))
      cursor.x = choice_sprite.x + 10
      cursor.z = 50

      update_choice_display = lambda do
        max_visible.times do |i|
          actual_idx = scroll + i
          option_texts[i].text = actual_idx < options.size ? options[actual_idx] : ''
        end
        visible_idx = index - scroll
        cursor.y = choice_sprite.y + 26 + (visible_idx * 22)
      end

      update_choice_display.call

      result = -1
      loop do
        Graphics.update

        if cancel_pressed?
          play_cursor_se
          result = -1
          break
        end

        if confirm_pressed?
          play_decision_se
          result = index
          break
        end

        if Mouse.trigger?(:LEFT)
          option_texts.each_with_index do |t, i|
            if t.text != '' && t.simple_mouse_in?
              play_decision_se
              result = scroll + i
              break
            end
          end
          break if result != -1
        end

        if Mouse.wheel_delta != 0
          if options.size > max_visible
            old_scroll = scroll
            scroll = (scroll - Mouse.wheel_delta).clamp(0, options.size - max_visible)
            if scroll != old_scroll
              # Try to keep the index in view if it was already in view
              index = index.clamp(scroll, scroll + max_visible - 1)
              play_cursor_se
              update_choice_display.call
            end
          end
        end

        if Mouse.moved
          option_texts.each_with_index do |t, i|
            if t.text != '' && t.simple_mouse_in?
              actual_idx = scroll + i
              if index != actual_idx
                index = actual_idx
                play_cursor_se
                update_choice_display.call
              end
              break
            end
          end
        end

        if Input.trigger?(:UP)
          # Check for shift to jump to top
          if Input::Keyboard.press?(Input::Keyboard::LShift) || Input::Keyboard.press?(Input::Keyboard::RShift)
            if current_page && max_page
              result = :first
              break
            else
              index = 0
              scroll = 0
            end
          else
            index = (index - 1) % options.size
            if index < scroll
              scroll = index
            elsif index >= scroll + max_visible
              scroll = index - max_visible + 1
            end
            scroll = [[scroll, 0].max, options.size - max_visible].min if options.size > max_visible
          end
          play_cursor_se
          update_choice_display.call
        end

        if Input.trigger?(:DOWN)
          # Check for shift to jump to bottom
          if Input::Keyboard.press?(Input::Keyboard::LShift) || Input::Keyboard.press?(Input::Keyboard::RShift)
            if current_page && max_page
              result = :last
              break
            else
              index = options.size - 1
              scroll = [[index - max_visible + 1, 0].max, options.size - max_visible].min if options.size > max_visible
            end
          else
            index = (index + 1) % options.size
            if index < scroll
              scroll = index
            elsif index >= scroll + max_visible
              scroll = index - max_visible + 1
            end
            scroll = [[scroll, 0].max, options.size - max_visible].min if options.size > max_visible
          end
          play_cursor_se
          update_choice_display.call
        end

        # Page navigation with L/R or Left/Right
        if current_page && max_page
          if Input.trigger?(:LEFT) || Input.trigger?(:L)
            play_cursor_se
            result = :prev_page
            break
          end

          if Input.trigger?(:RIGHT) || Input.trigger?(:R)
            play_cursor_se
            result = :next_page
            break
          end
        end
      end

      # Cleanup
      choice_sprite.bitmap.dispose
      choice_sprite.dispose
      title_text.dispose
      inst_text&.dispose
      cursor.bitmap.dispose
      cursor.dispose
      option_texts.each { |t| t.dispose }

      result
    end

    # Display numeric input box
    # @param prompt [String] the prompt to display
    # @param default [Integer] the default value
    # @return [Integer, nil] the value or nil for cancel
    # Display a numeric input dialog.
    # @param prompt [String] the prompt to display.
    # @param default [Integer] the initial value.
    # @return [Integer, nil] the value entered, or nil if canceled.
    def display_number_input(prompt, default = 0)
      value = default.to_i.abs.to_s
      max_digits = 10
      negative = default.to_i < 0

      input_sprite = Sprite.new(@viewport)
      input_sprite.bitmap = Bitmap.new(250, 100)
      input_sprite.bitmap.fill_rect(0, 0, 250, 100, Color.new(30, 30, 50, 240))
      input_sprite.x = (Graphics.width - 250) / 2
      input_sprite.y = (Graphics.height - 100) / 2
      input_sprite.z = 60

      prompt_text = Text.new(0, @viewport, input_sprite.x, input_sprite.y + 10, 250, 20, prompt, 1, 1, 9)
      prompt_text.z = 61

      value_text = Text.new(0, @viewport, input_sprite.x, input_sprite.y + 40, 250, 20, (negative ? '-' : '') + value, 1, 1, 9)
      value_text.z = 61

      inst_text = Text.new(0, @viewport, input_sprite.x, input_sprite.y + 70, 250, 16, text_get(TEXT_FILE_ID, 35), 1, 1, 9)
      inst_text.z = 61

      reset_input_states
      # Initialize key states to avoid carrying over presses
      key_states = {}
      [
        * (Input::Keyboard::Num0..Input::Keyboard::Num9),
        Input::Keyboard::Backspace,
        (Input::Keyboard::OemMinus rescue 189)
      ].each { |k| key_states[k] = (Input::Keyboard.press?(k) rescue false) }

      result = nil
      loop do
        Graphics.update

        # Confirm/Cancel using unified logic (prevents double trigger)
        if confirm_pressed? || Mouse.trigger?(:LEFT)
          play_decision_se
          result = (negative ? -1 : 1) * value.to_i
          break
        end

        if cancel_pressed? || Mouse.trigger?(:RIGHT)
          play_cursor_se
          break
        end

        # Handle text input via Input.get_text
        if (input_text = Input.get_text)
          input_text.chars.each do |char|
            if char.match?(/[0-9]/) && value.length < max_digits
              value = (value == '0' ? char : value + char)
              value_text.text = (negative ? '-' : '') + value
            elsif char == '-'
              negative = !negative
              value_text.text = (negative ? '-' : '') + value
            end
          end
        end

        # Backspace
        back_key = Input::Keyboard::Backspace
        bp = Input::Keyboard.press?(back_key)
        if bp && !key_states[back_key]
          value = value[0...-1]
          value = '0' if value.empty?
          value_text.text = (negative ? '-' : '') + value
        end
        key_states[back_key] = bp

        # Arrows
        if Input.trigger?(:UP) || Input.trigger?(:RIGHT)
          play_cursor_se
          current_val = (negative ? -1 : 1) * value.to_i + 1
          negative = current_val < 0
          value = current_val.abs.to_s
          value_text.text = (negative ? '-' : '') + value
        end

        if Input.trigger?(:DOWN) || Input.trigger?(:LEFT)
          play_cursor_se
          current_val = (negative ? -1 : 1) * value.to_i - 1
          negative = current_val < 0
          value = current_val.abs.to_s
          value_text.text = (negative ? '-' : '') + value
        end
      end

      input_sprite.bitmap.dispose
      input_sprite.dispose
      prompt_text.dispose
      value_text.dispose
      inst_text.dispose
      result
    end

    # Display text input box
    # @param prompt [String] the prompt to display
    # @param default [String] the default value
    # @return [String, nil] the value or nil for cancel
    # Display a text input dialog.
    # @param prompt [String] the prompt to display.
    # @param default [String] the initial text value.
    # @return [String, nil] the text entered, or nil if canceled.
    def display_text_input(prompt, default = '')
      text_value = default.to_s

      input_sprite = Sprite.new(@viewport)
      input_sprite.bitmap = Bitmap.new(300, 100)
      input_sprite.bitmap.fill_rect(0, 0, 300, 100, Color.new(30, 30, 50, 240))
      input_sprite.x = (Graphics.width - 300) / 2
      input_sprite.y = (Graphics.height - 100) / 2
      input_sprite.z = 60

      prompt_text = Text.new(0, @viewport, input_sprite.x, input_sprite.y + 10, 300, 20, prompt, 1, 1, 9)
      prompt_text.z = 61

      value_text = Text.new(0, @viewport, input_sprite.x, input_sprite.y + 40, 300, 20, text_value, 1, 1, 9)
      value_text.z = 61

      inst_text = Text.new(0, @viewport, input_sprite.x, input_sprite.y + 70, 300, 16, text_get(TEXT_FILE_ID, 34), 1, 1, 9)
      inst_text.z = 61

      reset_input_states
      key_states = {}
      keys_to_check = [
        * (Input::Keyboard::A..Input::Keyboard::Z),
        * (Input::Keyboard::Num0..Input::Keyboard::Num9),
        Input::Keyboard::Backspace,
        Input::Keyboard::Enter,
        Input::Keyboard::Escape,
        (Input::Keyboard::OemMinus rescue 189)
      ]
      keys_to_check.each { |k| key_states[k] = (Input::Keyboard.press?(k) rescue false) }


      result = nil
      loop do
        Graphics.update

        # Enter to confirm
        if (Input::Keyboard.press?(Input::Keyboard::Enter) rescue false)
          unless key_states[Input::Keyboard::Enter]
            play_decision_se
            result = text_value
            break
          end
        end
        key_states[Input::Keyboard::Enter] = (Input::Keyboard.press?(Input::Keyboard::Enter) rescue false)

        # Esc to cancel
        if (Input::Keyboard.press?(Input::Keyboard::Escape) rescue false)
          unless key_states[Input::Keyboard::Escape]
            play_cursor_se
            break
          end
        end
        key_states[Input::Keyboard::Escape] = (Input::Keyboard.press?(Input::Keyboard::Escape) rescue false)

        # Handle text input via Input.get_text
        if (input_text = Input.get_text)
          input_text.chars.each do |char|
            if char.match?(/[A-Za-z0-9_]/)
              text_value += char
              value_text.text = text_value
            end
          end
        end

        # Backspace
        back_key = Input::Keyboard::Backspace
        bp = Input::Keyboard.press?(back_key)
        if bp && !key_states[back_key]
          text_value = text_value[0...-1]
          value_text.text = text_value
        end
        key_states[back_key] = bp
      end

      input_sprite.bitmap.dispose
      input_sprite.dispose
      prompt_text.dispose
      value_text.dispose
      inst_text.dispose
      result
    end
  end
end
