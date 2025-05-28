# Reduces the damage taken from beam attacks to 3/4
# Redirects the 1/4 of damage back to the attacker
# Item gets consumed
# Concept by: Substitube
# Code by: Invatorzen

module Battle
  module Effects
    class Item
      class BeamMirror < Item
        # Moves that are definitely "beam" moves as it's in the name
        BEAM_MOVES = %i[aurora_beam bubble_beam charge_beam eternabeam hyper_beam ice_beam
        meteor_beam moongeist_beam psybeam signal_beam simple_beam solar_beam steel_beam twin_beam]

        # Moves that are "beamlike" but don't have beam in the name
        BEAMLIKE_MOVES = %i[aeroblast dragon_pulse mirror_shot power_gem flash_cannon tri_attack]

        def on_damage_prevention(handler, hp, target, launcher, skill)
          return unless skill && target == @target
          return unless beam_move?(skill)
          
          @damage_launcher = true
          @launcher_damage = -(target.hp * 0.25).to_i.clamp(1, Float::INFINITY)
          return (target.hp * 0.75).ceil
        end

        # Function called after damages were applied (post_damage, when target is still alive)
        def on_post_damage(handler, hp, target, launcher, skill)
          return unless @damage_launcher

          @damage_launcher = false
          handler.scene.visual.show_item(target)
          handler.logic.item_change_handler.change_item(:none, true, target)
          handler.scene.visual.show_hp_animations([launcher], [@launcher_damage]) do
            handler.scene.display_message_and_wait(parse_text_with_2pokemon(999, -1, target, launcher))
          end
        end
        alias on_post_damage_death on_post_damage

        # Tell if the used skill triggers the effect
        def beam_move?(move)
          return BEAM_MOVES.include?(move.db_symbol) || BEAMLIKE_MOVES.include?(move.db_symbol)
        end
      end
      register(:beam_mirror, BeamMirror)
    end
  end
end