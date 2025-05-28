module PFM
  class Pokemon
    # Is the type Shadow?
    # @return [Boolean]
    def type_shadow?
      return type?(data_type(:shadow).id)
    end
    alias shadow_type? type_shadow?

    # Get shadow attribute
    # @return [Boolean]
    def shadow?
      return @shadow
    end

    # Sets shadow
    # @param shadow [Boolean]
    def shadow=(shadow)
      @shadow = shadow
    end

    def purified?
      return @purified
    end

    def purified=(purified)
      @purified = purified
    end

    def reverse_mode?
      return @reverse_mode
    end

    def reverse_mode=(reverse_mode)
      @reverse_mode = reverse_mode
    end

    def banked_exp
      return @banked_exp
    end

    # Lets you set the EXP bank for when mon is purified
    def banked_exp=(banked_exp)
      @banked_exp = banked_exp
    end

    alias default_initialize initialize
    def initialize(id, level, force_shiny = false, no_shiny = false, form = -1, opts = {})
      default_initialize(id, level, force_shiny, no_shiny, form, opts)
      shadow_initialize(opts)
    end
    
    private

    # Method assigning the ID, level, shiny property
    # @param id [Integer, Symbol] ID of the Pokemon in the database
    # @param level [Integer] level of the Pokemon
    # @param force_shiny [Boolean] if the Pokemon have 100% chance to be shiny
    # @param no_shiny [Boolean] if the Pokemon have 0% chance to be shiny (override force_shiny)
    alias default_stuff primary_data_initialize
    def primary_data_initialize(id, level, force_shiny, no_shiny)
      default_stuff(id, level, force_shiny, no_shiny)
      @shadow = false
      @purified = false
      @reverse_mode = false
      @banked_exp = 0
    end

    def shadow_initialize(opts)
      @shadow = opts[:shadow] || @shadow
      @purified = opts[:purified] || @purified
	  @reverse_mode = @reverse_mode
	  @banked_exp = @banked_exp
    end
  end
end

# Adds the properties to pokebattler
module PFM
  # Class defining a Pokemon during a battle, it aim to copy its properties but also to have the methods related to the battle.
  class PokemonBattler < Pokemon
    COPIED_PROPERTIES.push(:@shadow, :@purified, :@reverse_mode, :@banked_exp)
  end
end