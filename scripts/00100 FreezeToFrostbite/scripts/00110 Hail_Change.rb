module Battle
  module Effects
    class Weather
      class Hail < Weather
        # Give the effect chance modifier given to the Pokémon with this effect
        # @param move [Battle::Move::Basic] the move the chance modifier will be applied to
        # @return [Float, Integer] multiplier
        def effect_chance_modifier(move)
          return 1 if move.status_effects.select { |e| e.status == :freeze }.none?
          
          return 3
        end
      end
    end
  end
end