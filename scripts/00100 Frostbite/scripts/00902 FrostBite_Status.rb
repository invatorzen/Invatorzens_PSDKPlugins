module PFM
  class Pokemon
    # Is the Pokemon frostbitten?
    # @return [Boolean]
    def frostbite?
      @status == Configs.states.ids[:frostbite]
    end
    alias frostbitten? frostbite?
    alias frost? frostbite?

    # Apply frostbite on the Pokemon
    # @param forcing [Boolean] force the new status
    # @return [Boolean] if the pokemon has been frostbitten
    def status_frostbite(forcing = false)
      if (@status == 0 || forcing) && !dead?
        @status = Configs.states.ids[:frostbite]
        return true
      end
      false
    end

    # Can the Pokemon be frostbitten?
    # @return [Boolean]
    def can_be_frostbite?
      @status == 0 && !type_ice?
    end
  end
end