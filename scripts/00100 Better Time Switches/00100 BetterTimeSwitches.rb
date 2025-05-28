module Yuki
  module TJN
    class << self
      private
      # Update the state of the switches and the tone variable
      # @param switch_id [Integer] ID of the switch that should be true (all the other will be false)
      # @param variable_value [Integer] new value of $game_variables[Var::TJN_Tone]
      alias old_update_switches_and_variables update_switches_and_variables
      def update_switches_and_variables(switch_id, variable_value)
        old_update_switches_and_variables(switch_id, variable_value)
        update_other_time_variables
      end

      def update_other_time_variables
        $game_switches[Yuki::Sw::DayMorning] = $game_switches[11] ||  $game_switches[13] ? true : false # if day/morning
        $game_switches[Yuki::Sw::NightSunset] = $game_switches[12] ||  $game_switches[14] ? true : false # if night/sunset
      end
    end
  end
end