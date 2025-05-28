# Random catch value between 0-255
# Concept by Substitube, code by Invatorzen
Battle::Logic::CatchHandler.add_ball_rate_calculation(:luck_ball) do |target, _pkm_ally|
  next target.rareness + rand(255).clamp(1, 255)
end