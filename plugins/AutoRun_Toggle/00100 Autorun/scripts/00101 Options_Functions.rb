# Initializes the option to true
# Change @toggled_running_choice to false if you want it off by default
# Made by Invatorzen

module PFM
  class Options
    attr_accessor :toggled_running_choice
	  alias toggled_button_initialize initialize
	  def initialize(starting_language, game_state = PFM.game_state)
	    toggled_button_initialize(starting_language, game_state = PFM.game_state)
	    @toggled_running_choice = true #Default option
	  end
  end
end
