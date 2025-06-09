# Marks a Pokémon as captured despite whether it's caught or not
# Concept by Substitube, code by Invatorzen
Battle::Logic::CatchHandler.add_ball_rate_calculation(:dex_ball) do |target, _pkm_ally|
  next mark_captured(target.id)
end