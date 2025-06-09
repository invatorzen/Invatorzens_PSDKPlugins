# Increases the catch rate if a Pokémon is psychic type or confused
# Concept by Substitube, code by Invatorzen
Battle::Logic::CatchHandler.add_ball_rate_calculation(:dizzy_ball) do |target, _pkm_ally|
  next (target.rareness * 3.5) if target.confused? || target.type_psychic?
  next target.rareness
end