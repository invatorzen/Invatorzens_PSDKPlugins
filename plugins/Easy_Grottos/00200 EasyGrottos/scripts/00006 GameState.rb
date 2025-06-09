module PFM
  class GameState
    attr_accessor :hidden_grottos

    safe_code('Setup HiddenGrottos') do
      on_player_initialize(:hidden_grottos) { @hidden_grottos = HiddenGrottos.new }
      on_expand_global_variables(:hidden_grottos) do
        @hidden_grottos ||= HiddenGrottos.new
        $hidden_grottos = @hidden_grottos
      end
    end

    alias og_increase_steps increase_steps
    def increase_steps
      og_increase_steps
      $hidden_grottos.increase_step_count
    end
  end
end
