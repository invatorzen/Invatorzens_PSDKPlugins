# Debug Menu - Main Scene
# Comprehensive debug menu accessible via F8 or from the main menu in debug mode

module GamePlay
  class DebugMenu < BaseCleanUpdate
    # Constant for the text file ID used for localization
    TEXT_FILE_ID = 100101

    # Menu categories
    CATEGORIES = [
      { name: text_get(TEXT_FILE_ID, 1), symbol: :field },
      { name: text_get(TEXT_FILE_ID, 2), symbol: :battle },
      { name: text_get(TEXT_FILE_ID, 3), symbol: :pokemon },
      { name: text_get(TEXT_FILE_ID, 4), symbol: :item },
      { name: text_get(TEXT_FILE_ID, 5), symbol: :player }
    ]

    # Field options
    FIELD_OPTIONS = [
      { name: text_get(TEXT_FILE_ID, 6), method: :warp_to_map },
      { name: text_get(TEXT_FILE_ID, 7), method: :use_pc },
      { name: text_get(TEXT_FILE_ID, 8), method: :edit_switches },
      { name: text_get(TEXT_FILE_ID, 9), method: :edit_variables },
      { name: text_get(TEXT_FILE_ID, 10), method: :refresh_map },
      { name: text_get(TEXT_FILE_ID, 11), method: :day_care_manager }
    ]

    # Battle options
    BATTLE_OPTIONS = [
      { name: text_get(TEXT_FILE_ID, 12), method: :test_wild_battle },
      { name: text_get(TEXT_FILE_ID, 13), method: :test_trainer_battle },
      { name: text_get(TEXT_FILE_ID, 14), method: :manage_roaming },
      { name: text_get(TEXT_FILE_ID, 15), method: :reset_map_trainers }
    ]

    # Pokemon options
    POKEMON_OPTIONS = [
      { name: text_get(TEXT_FILE_ID, 16), method: :heal_party },
      { name: text_get(TEXT_FILE_ID, 17), method: :add_pokemon },
      { name: text_get(TEXT_FILE_ID, 18), method: :fill_storage },
      { name: text_get(TEXT_FILE_ID, 19), method: :clear_storage },
      { name: text_get(TEXT_FILE_ID, 20), method: :quick_hatch_eggs },
      { name: text_get(TEXT_FILE_ID, 21), method: :access_storage }
    ]

    # Item options
    ITEM_OPTIONS = [
      { name: text_get(TEXT_FILE_ID, 22), method: :add_item },
      { name: text_get(TEXT_FILE_ID, 23), method: :fill_bag },
      { name: text_get(TEXT_FILE_ID, 24), method: :empty_bag }
    ]

    # Player options
    PLAYER_OPTIONS = [
      { name: text_get(TEXT_FILE_ID, 25), method: :set_money },
      { name: text_get(TEXT_FILE_ID, 26), method: :set_gym_badges },
      { name: text_get(TEXT_FILE_ID, 27), method: :toggle_running_shoes },
      { name: text_get(TEXT_FILE_ID, 28), method: :toggle_pokedex },
      { name: text_get(TEXT_FILE_ID, 29), method: :set_player_name },
      { name: text_get(TEXT_FILE_ID, 30), method: :randomize_player_id }
    ]

    # Initialize the Debug Menu scene.
    def initialize
      super
      @category_index = 0
      @option_index = 0
      @mode = :categories  # :categories or :options
      @running = true
    end

    # Create the graphical elements for the scene.
    def create_graphics
      create_viewport
      create_background
      create_ui
    end

    # Create the main viewport for the menu.
    def create_viewport
      @viewport = Viewport.new(0, 0, Graphics.width, Graphics.height)
      @viewport.z = 10000
    end

    def create_background
      @background = UI::BlurScreenshot.new(@viewport, @__last_scene)
      @background.z = 0
    end

    def create_ui
      # Title
      @title_text = Text.new(0, @viewport, 0, 10, Graphics.width, 24, text_get(TEXT_FILE_ID, 0), 1, 1, 9)
      
      # Category/Option list window
      @window_sprite = Sprite.new(@viewport)
      @window_sprite.bitmap = Bitmap.new(280, 200)
      @window_sprite.bitmap.fill_rect(0, 0, 280, 200, Color.new(30, 30, 50, 230))
      @window_sprite.x = (Graphics.width - 280) / 2
      @window_sprite.y = 50
      @window_sprite.z = 1

      # Create text objects for menu items
      @menu_texts = []
      8.times do |i|
        text = Text.new(0, @viewport, @window_sprite.x + 20, @window_sprite.y + 10 + (i * 22), 240, 20, '', 0, 1, 9)
        text.z = 2
        @menu_texts << text
      end

      # Cursor
      @cursor = Sprite.new(@viewport)
      @cursor.bitmap = Bitmap.new(260, 20)
      @cursor.bitmap.fill_rect(0, 0, 260, 20, Color.new(100, 150, 255, 100))
      @cursor.x = @window_sprite.x + 10
      @cursor.z = 1

      # Instructions
      @instructions = Text.new(0, @viewport, 0, Graphics.height - 30, Graphics.width, 20, 
                               text_get(TEXT_FILE_ID, 31), 1, 1, 9)

      # Scroll tracking
      @scroll_offset = 0
      @max_visible = 8

      update_display
    end

    def update_inputs
      return false unless @running

      if cancel_pressed?
        if @mode == :options
          @mode = :categories
          @option_index = 0
          @scroll_offset = 0
          play_cursor_se
          update_display
        else
          play_cursor_se
          @running = false
        end
        return false
      end

      if confirm_pressed?
        play_decision_se
        if @mode == :categories
          @mode = :options
          @option_index = 0
          @scroll_offset = 0
          update_display
        else
          execute_option
        end
        return false
      end

      if Input.trigger?(:UP)
        play_cursor_se
        if @mode == :categories
          @category_index = (@category_index - 1) % CATEGORIES.size
        else
          current_options = get_current_options
          @option_index = (@option_index - 1) % current_options.size
          adjust_scroll
        end
        update_display
        return false
      end

      if Input.trigger?(:DOWN)
        play_cursor_se
        if @mode == :categories
          @category_index = (@category_index + 1) % CATEGORIES.size
        else
          current_options = get_current_options
          @option_index = (@option_index + 1) % current_options.size
          adjust_scroll
        end
        update_display
        return false
      end

      true
    end

    # Update the mouse state/hover/click interactions.
    # @param moved [Boolean] whether the mouse was moved since last frame.
    def update_mouse(moved)
      # Handle clicking
      if Mouse.trigger?(:LEFT)
        @menu_texts.each_with_index do |text, i|
          next if text.text.empty?
          if text.simple_mouse_in?
            play_decision_se
            if @mode == :categories
              @category_index = i
              @mode = :options
              @option_index = 0
              @scroll_offset = 0
            else
              @option_index = @scroll_offset + i
              execute_option
            end
            update_display
            return false
          end
        end
      end

      # Handle scrolling with wheel
      if Mouse.wheel_delta != 0 && @mode == :options
        options = get_current_options
        if options.size > @max_visible
          @scroll_offset = (@scroll_offset - Mouse.wheel_delta).clamp(0, options.size - @max_visible)
          update_display
        end
      end

      return unless moved

      # Handle hovering
      @menu_texts.each_with_index do |text, i|
        next if text.text.empty?
        if text.simple_mouse_in?
          if @mode == :categories
            if @category_index != i
              @category_index = i
              play_cursor_se
              update_display
            end
          else
            actual_index = @scroll_offset + i
            if @option_index != actual_index
              @option_index = actual_index
              play_cursor_se
              update_display
            end
          end
          break
        end
      end
    end

    def get_current_options
      case CATEGORIES[@category_index][:symbol]
      when :field then FIELD_OPTIONS
      when :battle then BATTLE_OPTIONS
      when :pokemon then POKEMON_OPTIONS
      when :item then ITEM_OPTIONS
      when :player then PLAYER_OPTIONS
      else []
      end
    end

    def adjust_scroll
      if @option_index < @scroll_offset
        @scroll_offset = @option_index
      elsif @option_index >= @scroll_offset + @max_visible
        @scroll_offset = @option_index - @max_visible + 1
      end
    end

    def update_display
      if @mode == :categories
        @title_text.text = 'DEBUG MENU'
        CATEGORIES.each_with_index do |cat, i|
          @menu_texts[i].text = i < @max_visible ? cat[:name] : ''
        end
        (@max_visible - CATEGORIES.size).times do |i|
          @menu_texts[CATEGORIES.size + i].text = ''
        end
        @cursor.y = @window_sprite.y + 8 + (@category_index * 22)
      else
        @title_text.text = "DEBUG MENU - #{CATEGORIES[@category_index][:name]}"
        options = get_current_options
        @max_visible.times do |i|
          actual_index = @scroll_offset + i
          if actual_index < options.size
            @menu_texts[i].text = options[actual_index][:name]
          else
            @menu_texts[i].text = ''
          end
        end
        visible_index = @option_index - @scroll_offset
        @cursor.y = @window_sprite.y + 8 + (visible_index * 22)
      end
    end

    def execute_option
      options = get_current_options
      method_name = options[@option_index][:method]
      send(method_name) if respond_to?(method_name, true)
    end

    def dispose
      @background&.dispose
      @window_sprite&.bitmap&.dispose
      @window_sprite&.dispose
      @cursor&.bitmap&.dispose
      @cursor&.dispose
      @title_text&.dispose
      @instructions&.dispose
      @menu_texts&.each { |t| t&.dispose }
      @viewport&.dispose
    end

    def day_care_manager
      display_message('Day Care management not yet implemented.')
    end

    private

    def play_cursor_se
      $game_system.se_play($data_system.cursor_se)
    end

    def play_decision_se
      $game_system.se_play($data_system.decision_se)
    end

    # ========== INPUT HELPERS ==========
    # These allow both gamepad/keyboard mapped inputs AND explicit Enter/Escape

    def confirm_pressed?
      return true if Input.trigger?(:A)
      # Also check Enter key directly
      enter_key = Input::Keyboard::Enter rescue 13
      @_enter_was_pressed ||= false
      enter_now = Input::Keyboard.press?(enter_key)
      triggered = enter_now && !@_enter_was_pressed
      @_enter_was_pressed = enter_now
      triggered
    end

    def cancel_pressed?
      return true if Input.trigger?(:B)
      # Also check Escape key directly
      escape_key = Input::Keyboard::Escape rescue 27
      esc_now = Input::Keyboard.press?(escape_key)
      triggered = esc_now && !@_escape_was_pressed
      @_escape_was_pressed = esc_now
      triggered
    end

    def reset_input_states
      # Mark keys as "pressed" if they are currently held to avoid instant trigger
      enter_key = Input::Keyboard::Enter rescue 13
      escape_key = Input::Keyboard::Escape rescue 27
      @_enter_was_pressed = Input::Keyboard.press?(enter_key)
      @_escape_was_pressed = Input::Keyboard.press?(escape_key)
    end
  end
end
