# Increases the catch rate if a Pokémon is fire type or burned
# Concept by Substitube, code by Invatorzen
Battle::Logic::CatchHandler.add_ball_rate_calculation(:burn_ball) do |target, _pkm_ally|
  next (target.rareness * 3.5) if target.burnt? || target.type_fire?
  next target.rareness
end