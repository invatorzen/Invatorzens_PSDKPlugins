# Better catching during the day or in brightly lit indoor areas
# Concept by Substitube, code by Invatorzen
Battle::Logic::CatchHandler.add_ball_rate_calculation(:dawn_ball) do |target, _pkm_ally|
  next (target.rareness * 3.5) if $env.indoor?
  next (target.rareness * 3.5) if $env.day?
  next target.rareness
end