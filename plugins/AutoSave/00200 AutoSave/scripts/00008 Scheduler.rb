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
      GamePlay::Save.autosave
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

  # Mark that a post-battle autosave should happen
  add_proc(:on_scene_switch, Battle::Scene, 'Schedule AutoSave after battle', 1000) do
    next unless $scene.is_a?(Scene_Map)
    next unless $game_switches[Inva::Sw::AUTOSAVE]

    log_debug('Scheduling AutoSave after battle...')
    $autosave.waiting_for_animation = true
  end

  # Execute the autosave when Scene_Map is ready
  add_proc(:on_update, ::Scene_Map, 'Execute post-battle AutoSave', 1001) do
    next unless $autosave.waiting_for_animation
    next unless $scene.spriteset                    # must have new spriteset
    next if $scene.spriteset.autosave_active?       # skip if animation already running
    next if $game_system.map_interpreter.running?   # skip if event still running
    
    # Initialize wait counter
    $autosave.wait_counter ||= 0
    if $autosave.wait_counter < 45
      $autosave.wait_counter += 1
      next
    end

    log_debug('Triggering AutoSave after battle...')
    $autosave.waiting_for_animation = false
    $autosave.wait_counter = 0                      # reset counter
    $scene.spriteset.schedule_autosave              # defer UI + save safely
  end
end
