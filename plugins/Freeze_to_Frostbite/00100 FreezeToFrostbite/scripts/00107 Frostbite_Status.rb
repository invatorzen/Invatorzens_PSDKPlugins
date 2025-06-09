module PFM
  class Pokemon
    # Is the Pokemon frozen?
    # @return [Boolean]
    def frozen?
      @status == Configs.states.ids[:freeze]
    end
    alias frostbite? frozen?
    alias frostbitten? frozen?

    # Freeze the Pokemon
    # @param forcing [Boolean] force the new status
    # @return [Boolean] if the pokemon has been frozen
    def status_frozen(forcing = false)
      if (@status == 0 || forcing) && !dead?
        @status = Configs.states.ids[:freeze]
        return true
      end
      false
    end
    alias status_frostbite status_frozen

    # Can the Pokemon be frozen?
    # @return [Boolean]
    def can_be_frozen?(skill_type = 0)
      return false if @status != 0 || (skill_type == 6 && type_ice?)

      true
    end
    alias can_be_frostbitten? can_be_frozen?
    alias can_be_frostbite? can_be_frozen?
  end
end
