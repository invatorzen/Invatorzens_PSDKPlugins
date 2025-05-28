module Battle
  class Move
    PHYSICAL_TYPES = %i[normal fighting flying poison ground rock bug ghost steel]
    SPECIAL_TYPES = %i[fire water grass electric psychic ice dragon dark]

    # Is the skill physical ?
    # @return [Boolean]
    def physical?
      log_debug("Physical Special split is: #{$game_switches[Inva::Sw::PHY_SPE_SPLIT]}.") unless data.type == :status
      return PHYSICAL_TYPES.include?(data.type) unless $game_switches[Inva::Sw::PHY_SPE_SPLIT] && data.type == :status

      data.category == :physical
    end

    # Is the skill special ?
    # @return [Boolean]
    def special?
      log_debug("Physical Special split is: #{$game_switches[Inva::Sw::PHY_SPE_SPLIT]}.") unless data.type == :status
      return SPECIAL_TYPES.include?(data.type) unless $game_switches[Inva::Sw::PHY_SPE_SPLIT] && data.type == :status

      data.category == :special
    end
  end
end
