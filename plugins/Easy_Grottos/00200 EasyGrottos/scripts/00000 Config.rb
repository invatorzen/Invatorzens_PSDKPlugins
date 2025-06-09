module Configs
  # Module holding all the project config
  module Project
    class HiddenGrottoConfig
      attr_accessor :visible_items, :hidden_items, :unique_items, :unique_pokemon
    end
  end
  register(:grotto_config, 'plugins/hidden_grotto', :json, false, Project::HiddenGrottoConfig)
end
