module Battle
  module Effects
    class Item
      class MagicBalloon < Item
        # Function called when a Pokemon has actually switched with another one
        # @param handler [Battle::Logic::SwitchHandler]
        # @param who [PFM::PokemonBattler] Pokemon that is switched out
        # @param with [PFM::PokemonBattler] Pokemon that is switched in
        def on_switch_event(handler, who, with)
          return if with != @target || with.dead?
          return if with.grounded?
  
          handler.scene.display_message_and_wait(parse_text_with_pokemon(999, 9, with))
        end
  
        # Function called after damages were applied (post_damage, when target is still alive)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage(handler, hp, target, launcher, skill)
          return if target != @target
          return unless skill
          return unless target.hold_item?(:magic_balloon)
          target.change_types(data_type(:fairy).id)
          handler.scene.visual.show_item(target)
          handler.scene.display_message_and_wait(parse_text_with_pokemon(999, 12, target))
          handler.logic.item_change_handler.change_item(:none, true, target)
        end
        alias on_post_damage_death on_post_damage
      end
      register(:magic_balloon, MagicBalloon)
    end
  end
end