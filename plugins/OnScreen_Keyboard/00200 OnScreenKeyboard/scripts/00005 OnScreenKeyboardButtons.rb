module UI
  # Creates the keyboard icon when keyboard is invisible
  class OnScreenKeyboardButtons < SpriteStack
    def initialize(viewport)
      super(viewport, 0, 0)
      create_elements
    end

    def create_elements
      @keyboard_icon = add_sprite(base_x - 23, base_y - 20, 'keyboard')
      @key_sel = add_sprite(base_x, base_y, NO_INITIAL_IMAGE, :SELECT, type: KeyShortcut)
    end

    def base_x
      return 297
    end

    def base_y
      return 170
    end
  end
end
