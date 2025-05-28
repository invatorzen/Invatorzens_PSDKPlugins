# Increases catch rate by 3.5x if shiny
# Concept by Substitube, code by Invatorzen
Battle::Logic::CatchHandler.add_ball_rate_calculation(:shiny_ball) do |target, _pkm_ally|
  next (target.rareness * 3.5) if target.shiny?
  next target.rareness
end