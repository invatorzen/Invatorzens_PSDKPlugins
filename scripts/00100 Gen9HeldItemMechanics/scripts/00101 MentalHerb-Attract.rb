module Battle
  class Move
    # Move that inflict attract effect to the ennemy
    class Attract < Move
      private
      USED_UP = 1311 # "[VAR PKNICK(0000)]'s Mental Herb was used up..." message
      def target_immune?(user, target)
        return true if target.effects.has?(:attract) || (user.gender * target.gender) != 2  
        ally = @logic.allies_of(target).find { |a| BLOCKING_ABILITY.include?(a.battle_ability_db_symbol) }
        if target.hold_item?(:mental_herb)
          # Adds the check if the switch is on to "use it" instead
          @scene.visual.show_item(target)
          @scene.display_message_and_wait(parse_text_with_pokemon(19, USED_UP-2, target)) if $game_switches[Yuki::Sw::Gen9HeldItems]
          $game_switches[Yuki::Sw::Gen9HeldItems] ? @logic.item_change_handler.change_item(:none, false, target) : @logic.item_change_handler.change_item(:none, true, target)
          return true
        elsif user.can_be_lowered_or_canceled?(BLOCKING_ABILITY.include?(target.battle_ability_db_symbol))
          @scene.visual.show_ability(target)
          return true
        elsif user.can_be_lowered_or_canceled? && ally
          @scene.visual.show_ability(ally)
        end
        return super
      end
    end
  end
end