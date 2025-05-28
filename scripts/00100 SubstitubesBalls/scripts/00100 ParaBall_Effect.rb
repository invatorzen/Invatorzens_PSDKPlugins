# Increases the catch rate if a Pokémon is electric type or paralyze
# Concept by Substitube, code by Invatorzen
Battle::Logic::CatchHandler.add_ball_rate_calculation(:para_ball) do |target, _pkm_ally|
  next (target.rareness * 3.5) if target.paralyzed? || target.type_electric?
  next target.rareness
end