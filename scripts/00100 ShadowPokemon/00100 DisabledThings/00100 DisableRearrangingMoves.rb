module GamePlay
  class Summary
    private
    # Update when we are in the move section
    def update_inputs_skill_ui
      return if update_inputs_basic(!@selecting_move)
      @running = true if @selecting_move && !@running
      update_inputs_move_index if @selecting_move
      if Input.trigger?(:A)
        $game_system.se_play($data_system.decision_se)
        update_input_a_skill_ui unless @pokemon.shadow? && @selecting_move
        update_ctrl_state
      elsif Input.trigger?(:B)
        $game_system.se_play($data_system.cancel_se)
        @skill_selected = -1
        if @skill_index >= 0
          @uis[2].skills[@skill_index].moving = false
          @skill_index = -1
        else
          @running = false unless @selecting_move
          @selecting_move = false
        end
        update_ctrl_state
      end
    end
  end
end