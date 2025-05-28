module PFM
  class Skill
    alias og_atk_class atk_class
    # Get the ATK class for the UI
    # @return [Integer]
    def atk_class
      return check_new_type if $game_switches[Inva::Sw::PHY_SPE_SPLIT_DISABLED] && data.category != :status

      return og_atk_class
    end

    private

    # Checks the new type of moves if the split is disabled and returns icon for UI
    def check_new_type
      return 2 if Configs.physpec_split_config.special_types.include?(data.type)

      return 1
    end
  end
end
