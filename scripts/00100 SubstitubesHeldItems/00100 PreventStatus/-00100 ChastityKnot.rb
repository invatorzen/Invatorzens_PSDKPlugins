# Modifies attract so that the chastity knot can prevent it
# Concept by Substitube
# Code by Invatorzen
module Battle
  class Move
    # Move that inflict attract effect to the ennemy
    class Attract < Move
      private
      # Method responsive testing accuracy and immunity.
      # It'll report the which pokemon evaded the move and which pokemon are immune to the move.
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @return [Array<PFM::PokemonBattler>]
      def accuracy_immunity_test(user, targets)
        return targets.select do |pokemon|
          if target_immune?(user, pokemon)
            scene.display_message_and_wait(parse_text_with_pokemon(19, 210, pokemon)) unless pokemon.hold_item?(:chastity_knot)
            next false
          elsif move_blocked_by_target?(user, pokemon)
            next false
          end
          next true
        end
      end
      
      # Test if the target is immune
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      # @return [Boolean]
      def target_immune?(user, target)
        return true if target.effects.has?(:attract) || (user.gender * target.gender) != 2

        ally = @logic.allies_of(target).find { |a| BLOCKING_ABILITY.include?(a.battle_ability_db_symbol) }
        if target.hold_item?(:mental_herb)
          @logic.scene.visual.show_item(target)
          @logic.item_change_handler.change_item(:none, true, target)
          return true
        elsif target.hold_item?(:chastity_knot)
          @logic.scene.visual.show_item(target)
          @logic.scene.display_message_and_wait(parse_text_with_2pokemon(999, 35, target, user))
          return true
        elsif user.can_be_lowered_or_canceled?(BLOCKING_ABILITY.include?(target.battle_ability_db_symbol))
          @scene.visual.show_ability(target)
          return true
        elsif user.can_be_lowered_or_canceled? && ally
          @scene.visual.show_ability(ally)
          return true
        end

        return super
      end
    end
  end
end