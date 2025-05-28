# Increases the catch rate if a Pokémon is ice  type or frozen
# Concept by Substitube, code by Invatorzen
Battle::Logic::CatchHandler.add_ball_rate_calculation(:ice_ball) do |target, _pkm_ally|
  next (target.rareness * 3.5) if target.frozen? || target.type_ice?
  next target.rareness
end