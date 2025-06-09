# Increases the catch rate if a Pokémon is trapped
# Concept by Substitube, code by Invatorzen
Battle::Logic::CatchHandler.add_ball_rate_calculation(:trap_ball) do |target, _pkm_ally|
  next (target.rareness * 3.5) if target.effects.has?(:bind)
  next target.rareness
end