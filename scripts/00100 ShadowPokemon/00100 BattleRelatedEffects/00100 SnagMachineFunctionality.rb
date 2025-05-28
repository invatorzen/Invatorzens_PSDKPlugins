module Studio
  # Data class describing an Item that allow the player to catch a creature
  class BallItem < Item
  end
end

SNAG_SWITCH = 128

PFM::ItemDescriptor.define_chen_prevention(Studio::BallItem) do
  next !$game_temp.in_battle if $game_switches[SNAG_SWITCH]
end