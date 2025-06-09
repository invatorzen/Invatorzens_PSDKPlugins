module Scheduler
  add_proc(:on_scene_switch, ::GamePlay::Load, 'Initialize $hidden_grottos if missing', 1000) do
    next unless $hidden_grottos.nil?

    $hidden_grottos ||= HiddenGrottos.new
  end

  add_proc(:on_scene_switch, ::GamePlay::Load, 'Initialize $hidden_grottos if missing', 1000) do
    next if $hidden_grottos.get($game_map.map_id).nil?

    $hidden_grottos.get($game_map.map_id).set_event_sprite unless $hidden_grottos.get($game_map.map_id).gift.nil?
  end

  add_proc(:on_scene_switch, ::GamePlay::Load, 'Initialize $hidden_grottos if missing', 1000) do
    $hidden_grottos ||= HiddenGrottos.new if $hidden_grottos.nil?
    next if $hidden_grottos.get($game_map.map_id).nil?

    $hidden_grottos.get($game_map.map_id).set_event_sprite unless $hidden_grottos.get($game_map.map_id).gift.nil?
  end

  add_proc(:on_warp_end, ::Scene_Map, 'Hidden Grotto', 1000) do
    next if $hidden_grottos.get($game_map.map_id).nil?

    log_debug('This is a scheduler task when players enter a hidden grotto.')
  end
end
