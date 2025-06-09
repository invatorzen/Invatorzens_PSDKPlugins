# Increases the catch rate if a Pokémon is poison  type or poisoned
# Concept by Substitube, code by Invatorzen
Battle::Logic::CatchHandler.add_ball_rate_calculation(:poison_ball) do |target, _pkm_ally|
  next (target.rareness * 3.5) if target.poisoned? || target.toxic? || target.type_poison?
  next target.rareness
end