module Configs
  # Module holding all the project config
  module Project
    class OutfitConfig
      attr_accessor :outfit_bag_slot, :outfit_icon_slot, :outfits

      def outfits=(hash)
        @outfits = hash.transform_keys(&:to_sym)
      end
    end
  end
  # @!method self.outfit_config
  # @return [Project::OutfitConfig]
  register(:outfit_config, 'plugins/outfit_config', :json, false, Project::OutfitConfig)
end
