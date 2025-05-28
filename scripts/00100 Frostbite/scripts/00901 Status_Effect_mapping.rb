module Battle
  class Move
    remove_const :STATUS_EFFECT_MAPPING
    # Array mapping the status effect to an action
    STATUS_EFFECT_MAPPING = %i[nothing poison paralysis burn sleep freeze confusion flinch toxic ko frostbite]
  end
end