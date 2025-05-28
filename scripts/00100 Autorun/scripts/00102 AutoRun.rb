# The actual function. Kind of documented the idea how it works.
# Made by Invatorzen

class Game_Player
  def player_update_move_running_state(bool)
    # Make the player run
    # If you can run (have shoes) & (autorun ON and not pressing B OR autorun off and pressing B) & not in step animation
    if !bool && @lastdir4 != 0 && $game_switches[::Yuki::Sw::EV_CanRun] &&
      !$game_switches[::Yuki::Sw::EV_Run] && (($options.toggled_running_choice && !Input.press?(:B)) || (!$options.toggled_running_choice && Input.press?(:B))) && !@step_anime # Test avec bump
      enter_in_running_state unless @state == :sinking # $game_temp.common_event_id = Game_CommonEvent::APPEARANCE
    # Stop to run
    # If you can run (have shoes) & (you have autorun OFF & aren't pressing B OR autorun is on & you are pressing B)
    elsif $game_switches[::Yuki::Sw::EV_Run] && (@lastdir4 == 0 || $game_system.map_interpreter.running? || @step_anime || ((!$options.toggled_running_choice && !Input.press?(:B)) || ($options.toggled_running_choice && Input.press?(:B))))
      enter_in_walking_state unless @state == :sinking # $game_temp.common_event_id = Game_CommonEvent::APPEARANCE
    end
  end
end