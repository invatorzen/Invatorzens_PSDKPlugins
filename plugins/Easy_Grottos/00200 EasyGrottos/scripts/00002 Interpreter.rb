class Interpreter
  # The first command called that creates our hidden grotto
  def enter_grotto(map_id = $game_map.map_id, event_id = 1)
    $hidden_grottos.create(map_id, event_id)
  end

  # The second command called, that sets the grotto's character sprite - item, pokemon, or hidden item
  def set_grotto_sprite(map_id = $game_map.map_id)
    return unless $hidden_grottos.get(map_id).time_to_reset

    $hidden_grottos.get(map_id).generate_gift
    set_ss(false, 'A', $hidden_grottos.get(map_id).event_id, map_id)
    @wait_count = 2
    $hidden_grottos.get(map_id).set_event_sprite
    $hidden_grottos.get(map_id).time_to_reset = false
  end

  # Gives the Grotto's gift to the player - whether it's an item, hidden item, or pokemon battle
  def grotto_gift(map_id = $game_map.map_id)
    gift = $hidden_grottos.get(map_id).gift
    case $hidden_grottos.get(map_id).grotto_type
    when :pokemon
      call_battle_wild(gift, gift.level)
    when :item, :hidden_item, :unique_item
      add_item(gift, true)
    else
      log_error('Grotto gift is else.')
    end
    $hidden_grottos.get(map_id).receieved_gift
    set_ss(true, 'A', $hidden_grottos.get(map_id).event_id, map_id)
  end
end
