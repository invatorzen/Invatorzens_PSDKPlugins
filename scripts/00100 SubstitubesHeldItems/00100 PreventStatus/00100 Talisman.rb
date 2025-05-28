module Battle
  module Effects
    class Item
      class Talisman < Item

        BLOCKED_MOVES = %i[perish_song curse destiny_bond]

        # Function called when we try to check if the target evades the move
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler] expected target
        # @param move [Battle::Move]
        # @return [Boolean] if the target is evading the move
        def on_move_prevention_target(user, target, move)
          return false if target != @target
          return false unless BLOCKED_MOVES.include?(move.db_symbol)
          play_talisman_effect(user, target, move)
          return true
        end

        def play_talisman_effect(user, target, move)
          @logic.scene.visual.show_item(target)
          move.scene.display_message_and_wait(parse_text_with_pokemon(999, 39, target))
        end
      end
      register(:talisman, Talisman)
    end
  end
end