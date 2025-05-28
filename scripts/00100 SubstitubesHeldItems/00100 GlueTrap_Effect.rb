# Traps attacker and holder on contact.
# Item gets consumed
# Concept by: Substitube
# Code by: Invatorzen
module Battle
  module Effects
    class Item
      class GlueTrap < Item
        # Function called after damages were applied (post_damage, when target is still alive)
        def on_post_damage(handler, hp, target, launcher, skill)
          return if target != @target
          return unless skill&.direct? && launcher != target && !launcher.has_ability?(:long_reach)

          handler.scene.visual.show_item(target)
          target.effects.add(Effects::CantSwitch.new(@logic, target, launcher, self))
          launcher.effects.add(Effects::CantSwitch.new(@logic, launcher, launcher, self))
          handler.scene.display_message_and_wait(parse_text_with_2pokemon(999, 2, target, launcher))
          handler.logic.item_change_handler.change_item(:none, true, target)
        end
        alias on_post_damage_death on_post_damage
      end
      register(:glue_trap, GlueTrap)
    end
  end
end