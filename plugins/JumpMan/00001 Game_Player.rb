class Game_Player < Game_Character
  # Move or turn the player according to its input. The common event 2 can be triggered there
  # @author Nuri Yuri
  def player_update_move
    # mouse_input = Input.kpress?(1)
    # Turn on itself system
    return if @jump_count > 0

    @wturn = 10 - @move_speed if @lastdir4 == 0 && !(Input.repeat?(:UP) || Input.repeat?(:DOWN) ||
                                 Input.repeat?(:LEFT) || Input.repeat?(:RIGHT))

    @lastdir4 = Input.dir4 # (mouse_input ? mouse_dir4 : Input.dir4)
    swamp_detect = (@in_swamp and @in_swamp > 4)
    if bool = ((@wturn > 0) | swamp_detect)
      player_turn(swamp_detect)
    else
      Input.press?(:A) && @jump_count == 0 && !(surfing? || cycling?) ? player_move(true) : player_move
    end

    player_update_move_bump(bool)
    player_update_move_common_events(bool)
  end

  # Move the player. Does some calibration for the Acro Bike.
  # @author Nuri Yuri
  def player_move(jumping = false)
    # > gestion du vélo cross
    jumping_dist = 1
    if @acro_bike_bunny_hop
      return if (jumping = update_acro_bike(5, front_system_tag)) == false

      jumping_dist = 2 if JumpTags.include?(front_system_tag)
    end
    last_dir = @direction
    case @lastdir4
    when 2
      jumping ? jump(0, jumping_dist) : move_down
    when 4
      turn_left
      jumping ? jump(-jumping_dist, 0) : move_left
    when 6
      turn_right
      jumping ? jump(jumping_dist, 0) : move_right
    when 8
      jumping ? jump(0, -jumping_dist) : move_up
      # else
      # @cant_bump=true
    end
    calibrate_acro_direction(last_dir)
    update_cycling_state if @state == :cycle_stop && moving?
  end

  # Check the triggers during the update
  # @param last_moving [Boolean] if the player was moving before
  def update_check_trigger(last_moving)
    if last_moving && !check_event_trigger_here([1, 2]) && !(debug? && Input::Keyboard.press?(Input::Keyboard::LControl))
      $wild_battle.update_encounter_count
    end
    return unless Input.trigger?(:A)

    result = check_event_trigger_here([0])
    result |= check_event_trigger_there([0, 1, 2])
    return if result

    jump(0, 0) if Input.press?(:A) && @jump_count == 0 && !(surfing? || cycling?)

    check_diving_trigger_here
  end
end
