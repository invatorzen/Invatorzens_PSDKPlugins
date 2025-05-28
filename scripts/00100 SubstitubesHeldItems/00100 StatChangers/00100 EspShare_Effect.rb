# If hit by a psychic type move, increase special attack
# Concept by Substitube
# Code by Invatorzen
module Battle
  module Effects
    class Item
      class EspShare < LuminousMoss
        private
        
        # Get the stat the item should improve
        # @return [Symbol]
        def stat_improved
          return :ats
        end

        # Tell if the used skill triggers the effect
        # @param move [Battle::Move, nil] Potential move used
        # @return [Boolean]
        def expected_type?(move)
          return move&.type_psychic?
        end
      end
      register(:esp_share, EspShare)
    end
  end
end
