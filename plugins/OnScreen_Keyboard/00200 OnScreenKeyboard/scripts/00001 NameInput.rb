module GamePlay
  class NameInput < GamePlay::BaseCleanUpdate::FrameBalanced
    include NameInputMixin
    # Update the inputs of the scene
    # @return [Boolean] if the other "input" related updates can be called
    def update_inputs
      if (text = Input.get_text)
        return if @keyboard_ui.visible

        update_name(text.chars)
        return false
      end
      return joypad_update_inputs && true
    end

    # Update the graphics of the scene
    alias og_update_graphics update_graphics
    def update_graphics
      og_update_graphics
      @keyboard_ui&.update
    end

    alias og_create_graphics create_graphics
    def create_graphics
      og_create_graphics
      create_keyboard_ui
    end

    def create_keyboard_ui
      @keyboard_ui = UI::OnScreenKeyboardUI.new(@viewport, @name_input_ui, self, false)
    end
  end
end
