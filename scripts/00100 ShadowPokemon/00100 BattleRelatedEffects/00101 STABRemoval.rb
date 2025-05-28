module Battle
  class Move
    # STAB calculation
    # @param user [PFM::PokemonBattler] user of the move
    # @param types [Array<Integer>] list of definitive types of the move
    # @return [Numeric]
    def calc_stab(user, types)
      if types.any? { |type| (user.type1 == type || user.type2 == type || user.type3 == type) && type != data_type(:shadow).id }
        return 2 if user.has_ability?(:adaptability)
        return 1.5
      end
      return 1
    end
  end
end