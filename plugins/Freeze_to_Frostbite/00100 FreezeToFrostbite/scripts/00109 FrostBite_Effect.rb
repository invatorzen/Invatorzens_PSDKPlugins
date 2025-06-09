module Battle
  module Effects
    class Status
      class Frozen < Status
        PREVENT_MESSAGE_LINE = 11 # Line with "[VAR PKNICK(0000)] already has frostbite." in 100019.csv

        # Give the move mod1 mutiplier (before the +2 in the formula)
        # @param user [PFM::PokemonBattler] user of the move
        # @param target [PFM::PokemonBattler] target of the move
        # @param move [Battle::Move] move
        # @return [Float, Integer] multiplier
        def mod1_multiplier(user, _target, move)
          return 1 if user != target
          return 1 unless move.special?
          return 1 if user.has_ability?(:guts)

          0.5
        end

        # Prevent frostbite from being applied twice
        def on_status_prevention(handler, status, target, _launcher, _skill)
          # Ignore if status is not frostbite or the taget is not the target of this effect
          return if target != self.target # checks target
          return if status != :freeze # checks if they have frostbite already
          return if target.has_ability?(:magma_armor) # checks if they have magma armor

          # Prevent change by telling the target is already frostbitten
          handler.prevent_change do
            handler.scene.display_message_and_wait(parse_text_with_pokemon(300_000, PREVENT_MESSAGE_LINE - 2, target)) # Message shown if the target already is frostbitten
          end
        end

        # Apply burn effect on end of turn
        # @param logic [Battle::Logic] logic of the battle
        # @param scene [Battle::Scene] battle scene
        # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
        def on_end_turn_event(logic, scene, battlers)
          return unless battlers.include?(target)
          return if target.has_ability?(:magic_guard)

          hp = frostbite_effect
          # No current ability halves the damage, you'd put it here
          # hp /= 2 if target.has_ability?(:heatproof)
          scene.display_message_and_wait(parse_text_with_pokemon(300_000, PREVENT_MESSAGE_LINE - 8, target)) # Message shown after you take damage from frostbite
          scene.visual.show_rmxp_animation(target, 469 + status_id)
          logic.damage_handler.damage_change(hp.clamp(1, Float::INFINITY), target)

          # Ensure the procedure does not get blocked by this effect
          nil
        end

        # Disabling part of the OG freeze effect
        def on_move_prevention_user(user, targets, move); end

        # Function giving the name of the effect
        # @return [Symbol]
        def name
          :freeze
        end

        private

        # Return the Frostbite effect on HP of the Pokemon
        # @return [Integer] number of HP loosen
        def frostbite_effect
          (target.max_hp / 8).clamp(1, Float::INFINITY)
        end
      end

      register(:freeze, Frozen)
    end
  end
end
