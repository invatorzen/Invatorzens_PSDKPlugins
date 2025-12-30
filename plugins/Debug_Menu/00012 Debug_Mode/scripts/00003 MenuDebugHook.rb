# Menu Debug Hook
# Adds Debug option to the main menu when in debug mode

module DebugMenu
  module MenuHook
    # Initializes the conditions for menu entries.
    # Appends debug access condition if in debug mode.
    def init_conditions
      super
      # Add debug condition at the end (only visible in debug mode)
      @conditions << debug? if debug?
    end

    # Initializes the indexes for menu entries.
    # Handles adding the debug index to visible entries.
    def init_indexes
      super
      # Add debug action index if in debug mode and not already present
      if debug?
        debug_index = GamePlay::Menu::ACTION_LIST.index(:open_debug)
        if debug_index && !@image_indexes.include?(debug_index)
          @image_indexes << debug_index
        end
      end
    end

    # Action method to open the debug menu.
    def open_debug
      call_scene(GamePlay::DebugMenu)
      Graphics.transition
    end

    # Returns the description text for the debug menu entry.
    # @return [String] the description string.
    def debug_menu_desc
      return text_get(GamePlay::DebugMenu::TEXT_FILE_ID, 108)
    end
  end
end

# Custom button for the Debug entry
module UI
  class DebugMenuButton < PSDKMenuButtonBase
    # Returns the button text for the debug menu entry.
    # @return [String] the name.
    def text
      return text_get(GamePlay::DebugMenu::TEXT_FILE_ID, 107)
    end
    
    # Creates the icon sprite for the debug menu button.
    def create_icon
      # @type [SpriteSheet]
      @icon = add_sprite(12, 0, 'debug/menu_icon', 2, 1, type: SpriteSheet)
      @icon.select(0, 0)
      @icon.set_origin(@icon.width / 2, @icon.height / 2)
      @icon.set_position(@icon.x + @icon.ox, @icon.y + @icon.oy)
    end

    def icon_index
      0
    end
  end
end

# Extend ACTION_LIST with debug option (if not already present)
unless GamePlay::Menu::ACTION_LIST.include?(:open_debug)
  GamePlay::Menu::ACTION_LIST << :open_debug
  # Register the custom button class
  idx = GamePlay::Menu::ACTION_LIST.size - 1
  GamePlay::Menu.register_button_overwrite(idx) { UI::DebugMenuButton }
end

# Apply the hook
GamePlay::Menu.prepend(DebugMenu::MenuHook)
