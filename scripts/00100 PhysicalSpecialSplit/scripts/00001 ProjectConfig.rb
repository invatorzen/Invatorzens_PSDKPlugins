module Configs
  module Project
    class PhysSpecSplitConfig
      attr_reader :physical_types, :special_types

      def physical_types=(array)
        @physical_types = array.map(&:to_sym)
      end

      def special_types=(array)
        @special_types = array.map(&:to_sym)
      end
    end
  end
  # @!method self.physpec_split_config
  # @return [Project::PhysSpecSplitConfig]
  register(:physpec_split_config, 'plugins/physpec_split_config', :json, false, Project::PhysSpecSplitConfig)
end
