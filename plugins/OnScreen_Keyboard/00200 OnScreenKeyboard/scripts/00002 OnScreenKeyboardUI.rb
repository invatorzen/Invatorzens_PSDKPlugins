module UI
  # On-screen keyboard for name input
  class OnScreenKeyboardUI < Window
    PADDING = 10

    # @param viewport [Viewport]
    # @param name_input_ui [UI::NameInputUI]
    def initialize(viewport, name_input_ui, scene, visible)
      super(viewport, base_x, base_y, width, height, skin: name_input_ui.send(:default_windowskin))
      @name_input_ui = name_input_ui
      @scene = scene
      @cursor_x = 0
      @cursor_y = 0
      @last_x = 0
      @mode = :upper
      self.visible = visible
      create_keys
      @buttons = OnScreenKeyboardButtons.new(viewport)
      select_key(0, 0)
    end

    # Update the keyboard input
    # @note this is being called in NameInput's update_graphics method
    def update
      update_inputs
    end

    # x Position of window
    def base_x
      return (Graphics.width - width) / 2
    end

    # y Position of window
    def base_y
      return 68
    end

    # Window width
    def width
      return Graphics.width - (PADDING * 2)
    end

    # Window height
    def height
      return 110
    end

    private

    # Create key UI text elements
    def create_keys
      @key_texts = current_key_rows.each_with_index.map do |row, y|
        row.each_with_index.map do |char, x|
          if %i[foreign foreign_upper].include?(@mode)
            y_offset = 0
          else
            y_offset = y == 2 ? 24 : 0
          end
          x_offset = get_offset(x, y)
          text = add_text(x * 20 + x_offset, (y * 24) + y_offset, 20, 20, char, 1)
          text.opacity = 128
          text
        end
      end
    end

    # Gives an offset for the bottom row of "special" keys
    # @return [Integer] the x offset for the special key
    def get_offset(x, y)
      return 0 if y == 2 && %i[foreign foreign_upper].include?(@mode)
      return 0 unless y >= 2

      return 0 if x == 1 # OK
      return 10 if x == 2 # Space
      return 20 if x == 3 # abc
      return 25 if x == 4 # ABC
      return 30 if x == 5 # aei
      return 35 if x == 6 # AEI
      return 40 if x == 7 # symbols
      return 45 if x == 8 # symbols

      return 0
    end

    # Handles if a shortcut covers multiple X positions
    def get_shortcut_position
      @cursor_y = %i[foreign foreign_upper].include?(@mode) ? 3 : 2
      return @cursor_x = case @cursor_x
                         when 0..1 then @cursor_x
                         when 2..3 then 2
                         when 4    then 3
                         when 5    then 4
                         when 6..7 then 5
                         when 8    then 6
                         when 9..10 then 7
                         else 8
                         end
    end

    # Updates the keys
    def current_key_rows
      case @mode
      when :upper
        [%w[A B C D E F G H I J K L M],
         %w[N O P Q R S T U V W X Y Z],
         ['←', text_get(400_001, 0), text_get(400_001, 1), 'abc', 'ABC', 'áéí', 'ÁÉÍ', '123', '♥♦♣']]
      when :lower
        [%w[a b c d e f g h i j k l m],
         %w[n o p q r s t u v w x y z],
         ['←', text_get(400_001, 0), text_get(400_001, 1), 'abc', 'ABC', 'áéí', 'ÁÉÍ', '123', '♥♦♣']]
      when :foreign
        [%w[á é í ó ú ü ñ ç æ ø å œ ß],
         %w[à è ì ò ù â ê î ô û ä ë],
         %w[ï ö ü],
         ['←', text_get(400_001, 0), text_get(400_001, 1), 'abc', 'ABC', 'áéí', 'ÁÉÍ', '123', '♥♦♣']]
      when :foreign_upper
        [%w[Á É Í Ó Ú Ü Ñ Ç Æ Ø Å Œ],
         %w[À È Ì Ò Ù Â Ê Î Ô Û Ä Ë],
         %w[Ï Ö Ü],
         ['←', text_get(400_001, 0), text_get(400_001, 1), 'abc', 'ABC', 'áéí', 'ÁÉÍ', '123', '♥♦♣']]
      when :symbol
        [%w[1 2 3 4 5 6 7 8 9 0 - _],
         %w[! ? @ # $ % & * ( ) ' "],
         ['←', text_get(400_001, 0), text_get(400_001, 1), 'abc', 'ABC', 'áéí', 'ÁÉÍ', '123', '♥♦♣']]
      when :symbol2
        [%w[♂ ♀ ♥ ♦ ♣ ♠ ° © ® ™ ¬ :],
         %w[§ £ ¥ ¢ + = / \\ ^ ~ | < >],
         ['←', text_get(400_001, 0), text_get(400_001, 1), 'abc', 'ABC', 'áéí', 'ÁÉÍ', '123', '♥♦♣']]
      end
    end
  end
end
