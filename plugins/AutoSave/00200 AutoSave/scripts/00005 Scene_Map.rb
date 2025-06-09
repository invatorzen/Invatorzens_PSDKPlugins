class Scene_Map
  alias og_transfer_player_end transfer_player_end
  # We add a on_warp_complete scheduler
  def transfer_player_end(transition_sprite)
    og_transfer_player_end(transition_sprite)
    Scheduler.start(:on_warp_complete)
  end
end
