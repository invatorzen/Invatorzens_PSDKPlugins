# Adds the running choice to your options
# Make sure you edit your text files, default is file 100042.
# Made by Invatorzen
module GamePlay
  class Options < BaseCleanUpdate::FrameBalanced
    # Adds new options	
    PREDEFINED_OPTIONS[:toggled_running_choice] = [:toggled_running_choice, :choice, [true, false], [[:text_get, 42, 9], [:text_get, 42, 10]], [:text_get, 42, 66], [:text_get, 42, 67], :toggled_running_choice]
  end
end