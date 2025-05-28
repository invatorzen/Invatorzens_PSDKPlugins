# Increases the catch rate for every negative state effect on the target
# Concept by Substitube, code by Rey
Battle::Logic::CatchHandler.add_ball_rate_calculation(:stat_ball) do |target, _pkm_ally|
  count_negative_battle_stage = 0
  target.battle_stage.each { |stage| count_negative_battle_stage += stage if stage.negative? }
  next (target.rareness - (20 * count_negative_battle_stage))
end