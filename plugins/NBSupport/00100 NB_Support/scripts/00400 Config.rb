module Configs
  module Project
    # Configuration class for the Non-Binary Support plugin
    class NBSupportConfig
      # ID of the game variable used to track the player's gender
      # @return [Integer]
      attr_accessor :gender_var

      def initialize
        @gender_var = 0
      end

      # @return [Hash]
      def to_h
        { klass: self.class.name, gender_var: @gender_var }
      end

      def to_json(*args)
        to_h.to_json(*args)
      end
    end
  end
  # @!method self.nb_support_config
  # @return [Project::NBSupportConfig]
  register(:nb_support_config, 'plugins/nb_support_config', :json, false, Project::NBSupportConfig)
end

module Inva
  # Non-Binary Support plugin namespace
  # Replaces PSDK's switch-based gender handling with a game variable so projects can
  # support more than two genders (default mapping: 0 = female, 1 = male, 2 = non-binary).
  module NBSupport
    class << self
      # Get the current value of the gender variable
      # @return [Integer]
      def gender
        $game_variables[Configs.nb_support_config.gender_var]
      end
    end
  end
end
