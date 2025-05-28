module Battle
  module Effects
    class Ability
      class Intimidate < Ability
        def on_post_damage_repeat(handler, hp, target, launcher, skill)
          alive_foes = handler.logic.foes_of(target).select(&:alive?)
          handler.scene.visual.show_ability(target) if alive_foes.any?
          alive_foes.each do |foe|
            handler.logic.stat_change_handler.stat_change_with_process(:atk, -1, foe, target)
            if foe.has_ability?(:rattled)
              handler.scene.visual.show_ability(foe)
              handler.logic.stat_change_handler.stat_change_with_process(:spd, 1, foe, target)
            end
          end
        end
      end
    end
  end
end