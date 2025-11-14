module AutoSave_SceneMapMixin
  def transfer_player_end(transition_sprite)
    super
    Scheduler.start(:on_warp_complete)
  end
end
Scene_Map.prepend(AutoSave_SceneMapMixin)
