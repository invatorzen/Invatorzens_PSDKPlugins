module Battle
  class Move
    # Is the skill type shadow ?
    # @return [Boolean]
    def type_shadow?
      return type?(data_type(:shadow).id)
    end
    alias shadow_type? type_shadow?

    # STAB calculation
    # @param user [PFM::PokemonBattler] user of the move
    # @param types [Array<Integer>] list of definitive types of the move
    # @return [Numeric]
    alias old_stabber calc_stab
    def calc_stab(user, types)
      return 1 if types.any? {|type| type == data_type(:shadow).id}

      old_stabber(user, types)
    end

    # Return the text of the PP of the skill
    # @return [String]
    def pp_text
      type == data_type(:shadow).id ? "--/--" : "#{@pp} / #{@ppmax}"
    end

    # Decrease the PP of the move
    # @param user [PFM::PokemonBattler]
    # @param targets [Array<PFM::PokemonBattler>] expected targets
    alias old_pp decrease_pp
    def decrease_pp(user, targets)
      return if user.type_shadow?

      old_pp(user, targets)
    end

  end
end
