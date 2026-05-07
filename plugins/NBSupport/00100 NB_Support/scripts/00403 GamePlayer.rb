class Game_Player
  # Patch module that drops the hardcoded "_f"/"_m" gender suffix from the player's
  # overworld charset filename. The charset_base itself encodes the outfit/identity
  # (set via set_appearance_set), so no gender suffix is needed.
  module NBSupportAppearance
    # Override of {Game_Player#update_appearance} that builds the charset name from
    # charset_base + state suffix only
    # @param forced_pattern [Integer] pattern after update (default : 0)
    # @return [Boolean, nil]
    def update_appearance(forced_pattern = 0)
      return unless @charset_base

      set_appearance("#{@charset_base}#{chara_by_state}")
      @pattern = forced_pattern
      update_pattern_state
      return true
    end
  end
  prepend NBSupportAppearance
end
