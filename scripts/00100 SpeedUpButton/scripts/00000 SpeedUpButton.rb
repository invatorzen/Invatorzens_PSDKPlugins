module NuriYuri
  class SpeedUpButton
    def initialize
      @config = Configs.speed_up_config
      @index = @config.initial_speed_index
      @time_cache = {}
      @base_repeat_cool_down = Input::REPEAT_COOLDOWN
      @base_repeat_space = Input::REPEAT_SPACE
      load_speed
    end

    def swap_speed
      @index = (@index + 1) % @config.speeds.size
      load_speed
    end

    # Get the new time based on the factor
    # @param time [Time]
    # @return [Time]
    def ajusted_time(time)
      return Time.at(time.to_f * @factor)
    end

    # Update the speed up button
    def update
      return unless Input.trigger?(:SPEED_UP)

      swap_speed
    end

    private

    def load_speed
      @factor = @config.speeds[@index] || 1
      Input.class_eval do
        remove_const :REPEAT_COOLDOWN
        remove_const :REPEAT_SPACE
      end
      Input.const_set(:REPEAT_COOLDOWN, @base_repeat_cool_down * @factor)
      Input.const_set(:REPEAT_SPACE, @base_repeat_space * @factor)
    end
  end

  class << self
    # Get the global speed up button
    # @return [SpeedUpButton]
    attr_accessor :global_speed_up_button
  end
end

module Input
  Keys[:SPEED_UP] = [Sf::Keyboard::F5, Sf::Keyboard::F5, Sf::Keyboard::F5, Sf::Keyboard::F5, -16]
end

module Graphics
  class Time < ::Time
    class << self
      alias old_new new
      def new
        return NuriYuri.global_speed_up_button.ajusted_time(old_new)
      end
    end
  end

  on_start do
    NuriYuri.global_speed_up_button = NuriYuri::SpeedUpButton.new
    Scheduler.add_proc(:on_update, :any, 'SpeedUpButon', 10_000) { NuriYuri.global_speed_up_button&.update }
  end
end

module Configs
  class SpeedUpConfig
    # Get the list of speed ups (in multiplier factor)
    # @return [Array<Float>]
    attr_accessor :speeds
    # Get the initial speed index
    # @return [Integer]
    attr_accessor :initial_speed_index

    # Create a new config
    def initialize
      @speeds = [1, 2, 3, 4, 0.5]
      @initial_speed_index = 0
    end
  end

  # @!method self.speed_up_config
  #   @return [SpeedUpConfig]
  register(:speed_up_config, 'speed_up_config', :yml, true, SpeedUpConfig)
end
