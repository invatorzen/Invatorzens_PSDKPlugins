module Battle
  class Move
    alias inva_physical? physical?
    # Is the skill physical ?
    # @return [Boolean]
    def physical?
      return inva_physical? unless $game_switches[Inva::Sw::PHY_SPE_SPLIT_DISABLED]
      return false if status?

      physical_type?
    end

    alias inva_special? special?
    # Is the skill special ?
    # @return [Boolean]
    def special?
      return inva_special? unless $game_switches[Inva::Sw::PHY_SPE_SPLIT_DISABLED]
      return false if status?

      special_type?
    end

    # Is the skill's type a physical type?
    def physical_type?
      Configs.physpec_split_config.physical_types.include?(data.type)
    end

    # Is the skill's type a special type?
    def special_type?
      Configs.physpec_split_config.special_types.include?(data.type)
    end
  end
end
