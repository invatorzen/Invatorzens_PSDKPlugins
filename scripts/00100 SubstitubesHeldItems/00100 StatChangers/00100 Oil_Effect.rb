# If hit by a fire type move, increase speed
# Concept by Substitube
# Code by Invatorzen
module Battle
  module Effects
    class Item
      class Oil < LuminousMoss
        private
        
        # Get the stat the item should improve
        # @return [Symbol]
        def stat_improved
          return :spd
        end

        # Tell if the used skill triggers the effect
        # @param move [Battle::Move, nil] Potential move used
        # @return [Boolean]
        def expected_type?(move)
          return move&.type_fire?
        end
      end
      register(:oil, Oil)
    end
  end
end
