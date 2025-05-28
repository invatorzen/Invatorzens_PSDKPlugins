module Battle
  class Move  
    # Calc TypeN multiplier of the move
    # @param target [PFM::PokemonBattler] target of the move
    # @param type_to_check [Symbol] type to check on the target
    # @param types [Array<Integer>] list of types the move has
    # @return [Numeric]
    def calc_type_n_multiplier(target, type_to_check, types)
      target_type = target.send(type_to_check)
      result = types.inject(1) { |product, type| product * calc_single_type_multiplier(target, target_type, type) }
      @effectiveness = 0.5 if target.shadow? && types.any? {|type| type == data_type(:shadow).id}
      if @effectiveness >= 0
        @effectiveness *= result
        log_data("multiplier of #{type_to_check} (#{data_type(target_type).name}) = #{result} => new_eff = #{@effectiveness}")
      end
      return result
    end
  end
end