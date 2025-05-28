module GamePlay
  # Class that display the Party Menu interface and manage user inputs
  #
  # This class has several modes
  #   - :map => Used to select a Pokemon in order to perform stuff
  #   - :menu => The normal mode when opening this interface from the menu
  #   - :battle => Select a Pokemon to send to battle
  #   - :item => Select a Pokemon in order to use an item on it (require extend data : hash)
  #   - :hold => Give an item to the Pokemon (requires extend data : item_id)
  #   - :select => Select a number of Pokemon for a temporary team.
  #     (Number defined by $game_variables[6] and possible list of excluded Pokemon requires extend data : array)
  #
  # This class can also show an other party than the player party,
  # the party paramter is an array of Pokemon upto 6 Pokemon
  class Party_Menu < BaseCleanUpdate::FrameBalanced
	#private
    # Initialize the win_text according to the mode
    def init_win_text
      case @mode
      when :map, :battle, :absofusion, :separate
        return @base_ui.show_win_text(text_get(23, 17))
      when :hold
        return @base_ui.show_win_text(text_get(23, 23))
      when :item
        if @extend_data
          extend_data_button_update
          return @base_ui.show_win_text(text_get(23, 24))
        end
      when :select
        select_pokemon_button_update
        return @base_ui.show_win_text(text_get(23, 17))
      when :purify
        return @base_ui.show_win_text(text_get(998, 1))
      end
      @base_ui.hide_win_text
    end
  end
end