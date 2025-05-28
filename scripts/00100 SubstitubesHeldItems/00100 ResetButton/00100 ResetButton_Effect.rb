# Reactivates an ability when taking damage.
# Item gets consumed
# Concept by: Substitube
# Code by: Invatorzen

module Battle
  module Effects
    class Item
      class ResetButton < Item
        # Abilities that activate when you enter battle
        ENTERING_BATTLE = %i[anticipation as_one download forewarn frisk hadron_engine imposter
                                mold_breaker neutralizing_gas pressure protosynthesis quark_drive
                                schooling screen_cleaner shields_down supersweet_syrup supreme_overlord trace unnerve]
  
        # Abiltiies that activate on damage
        ON_DAMAGE = %i[aftermath anger_point color_change cotton_down cursed_body cute_charm diguise effect_spore flame_body
                            gooey gulp_missile ice_face innards_out iron_barbs justified lingering_aroma mummy perish_body pickpocket 
                            poison_point rattled rough_skin sand_spit seed_sower stamina static steam_engine tangling hair thermal exchange
                            toxic_debris wandering_spirit weak_armor wind_power]

        # Abiltiies that activate and modify weather
        WEATHER = %i[air_lock cloud_nine delta_stream desolate_land drizzle drought orichalcum_pulse primordial_sea sand_stream snow_warning]

        # Abilities that activate on end of turn
        END_TURN = %i[bad_dreams dry_skin harvest healer hydration ice_body ice_face moody pickup poison_heal power_construct schooling 
                            shed_skin shields_down solar_power speed_boot zen_mode]
  
        # Function called after damages were applied (post_damage, when target is still alive)
        def on_post_damage(handler, hp, target, launcher, skill)
          return unless @target == target
          return unless repeatable_ability?
            
          handler.scene.visual.show_item(target)
          handler.scene.display_message_and_wait(parse_text_with_pokemon(999, 6, target))
          target.ability_effect.on_post_damage_repeat(handler, hp, target, launcher, skill)
          handler.logic.item_change_handler.change_item(:none, true, target)
        end
  
        # Tell if the ability can repeat
        def repeatable_ability?
          return @target.ability_effect.respond_to?(:on_post_damage_repeat)
        end
      end
      register(:reset_button, ResetButton)
    end
  end
end