# Increases the catch rate based on how light the Pokemon is
# Concept by Substitube, code by Invatorzen
# Make sure your catch rate for this ball is set to 40!
Battle::Logic::CatchHandler.add_ball_rate_calculation(:shrink_ball) do |target, _pkm_ally|
  modifier = target.rareness
  weight = target.weight
  if weight.between?(0, 204.7) || target.effects.has?(:minimize)
    modifier += 20
  elsif weight.between?(204.8, 307.1)
    modifier -= 20
  elsif weight.between?(307.2, 409.5)
    modifier -= 30
  elsif weight >= 409.6
    modifier -= 40
  end
  next modifier.clamp(1, 255)
end