module Scheduler
  # Called at the complete end of the warp transfer
  @tasks[:on_warp_complete] = {}

  # On input AutoSave scheduler task
  add_proc(:on_update, ::Scene_Map, 'AutoSave on input', 1000) do
    next if $scene.is_a?(Scene_Title) || $game_map.map_id == $data_system.start_map_id - 1
    next unless $game_switches[Inva::Sw::AUTOSAVE] && $scene.spriteset
    next if $scene.spriteset.autosave_active?
    next if $game_system.map_interpreter.running?

    if Input.trigger?(:F11)
      log_debug('Auto saving...')
      $scene.spriteset.show_autosave_ui
      GamePlay::Save.save
    end
  end

  # Warping AutoSave scheduler task
  add_proc(:on_warp_complete, ::Scene_Map, 'AutoSave on warp complete', 1000) do
    next unless $scene.spriteset && $game_switches[Inva::Sw::AUTOSAVE]
    next if $scene.spriteset.autosave_active?
    next if $game_map.map_id == $data_system.start_map_id - 1

    log_debug('Scheduling AutoSave on warp end...')
    $scene.spriteset.schedule_autosave
  end
end
