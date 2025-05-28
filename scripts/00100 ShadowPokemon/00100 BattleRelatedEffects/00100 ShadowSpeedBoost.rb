module Battle
  module Effects
    class ShadowSpeed < PokemonTiedEffectBase
      def initialize(logic, user)
        super(logic, user)
      end

      # Give the mon a speed boost
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @param move [Battle::Move] move
      # @return [Float, Integer] multiplier
      def spd_modifier
        return 1.5
        return 1
      end

      # Name of the effect
      # @return [Symbol]
      def name
        :shadow_speed
      end
    end
  end
end
