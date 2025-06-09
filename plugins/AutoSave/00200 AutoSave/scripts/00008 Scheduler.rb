module Scheduler
  # Called at the complete end of the warp transfer
  @tasks[:on_warp_complete] = {}

  # On input AutoSave scheduler task
  add_proc(:on_update, ::Scene_Map, 'AutoSave on input', 1000) do
    next if $scene.is_a?(Scene_Title) || $game_map.map_id == $data_system.start_map_id - 1
    next unless $game_switches[Inva::Sw::AUTOSAVE] && $scene.spriteset
    next if $scene.spriteset.instance_variable_defined?(:@autosave_sprite)

    if Input.trigger?(:F11)
      log_debug('Auto saving...')
      $scene.spriteset.exec_hooks(Spriteset_Map, :show_autosave_ui, binding)
      GamePlay::Save.save
    end
  end

  # Warping AutoSave scheduler tasks
  add_proc(:on_warp_complete, ::Scene_Map, 'AutoSave on warp complete', 1000) do
    next unless $scene.spriteset && $game_switches[Inva::Sw::AUTOSAVE]
    next if $scene.spriteset.instance_variable_defined?(:@autosave_sprite)

    if $game_map.map_id != $data_system.start_map_id - 1
      log_debug('Auto saving on warp end.')
      $scene.spriteset.exec_hooks(Spriteset_Map, :show_autosave_ui, binding)
      GamePlay::Save.save
    end
  end

  # Post battle AutoSave scheduler tasks
  add_proc(:on_scene_switch, Battle::Scene, 'Changes AutoSave state after battle', 1000) do
    next unless $scene.is_a?(Scene_Map)
    next unless $game_switches[Inva::Sw::AUTOSAVE]

    log_debug('Auto saving after battle.')
    $autosave.waiting_for_animation = true
  end

  add_proc(:on_update, ::Scene_Map, 'AutoSave after a battle', 1001) do
    next unless $autosave.waiting_for_animation

    $scene.spriteset.exec_hooks(Spriteset_Map, :show_autosave_ui, binding)
    $autosave.waiting_for_animation = false
    GamePlay::Save.save
  end
end
