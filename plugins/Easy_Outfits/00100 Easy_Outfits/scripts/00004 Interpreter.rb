class Interpreter
  # Displays the user's outfits in a choice box
  def show_outfits
    @choices = []
    @item_symbol_map = {}

    # Get the items in the 9th socket (default is outfit) and add their names to the choices array
    $bag.get_order(Configs.outfit_config.outfit_bag_slot).each do |db_symbol|
      item_name = data_item(db_symbol).name
      if $bag.item_quantity(db_symbol) > 0
        @choices << item_name
        @item_symbol_map[item_name] = db_symbol # Map the item name to its symbol
      end
    end

    # Add a "Cancel" option to allow the player to exit the choice menu
    @choices << ext_text(106_969, 6)

    # Display the choices to the player
    choice(26, -1, *@choices)
  end

  # Users OW and backsprite to that of the outfit
  def handle_outfit_change
    # Get the choice index from $game_variables[Yuki::Var::TMP1]
    choice_index = $game_variables[Yuki::Var::TMP1] - 1

    # Check if the user chose the "Cancel" option
    if choice_index < 0 || choice_index >= @choices.size - 1
      log_debug('User canceled the outfit selection.')
      return
    end

    # Get the selected item name from the choices array
    selected_item_name = @choices[choice_index]
    db_symbol = @item_symbol_map[selected_item_name]

    # Apply outfit if found in config
    outfit_map = Configs.outfit_config.outfits
    if outfit_map.key?(db_symbol)
      apply_outfit(db_symbol.to_sym)
      log_debug("Applied outfit for: #{db_symbol}")
    else
      log_error("No matching outfit found for symbol: #{db_symbol}")
    end

    # Reset the choice variable
    $game_variables[Yuki::Var::TMP1] = 0
  end

  # Applies the sprites and optionally sets gender
  def apply_outfit(symbol)
    outfit_map = Configs.outfit_config.outfits
    entry = outfit_map[symbol]
    return unless entry && entry.size >= 2

    walk_sprite, back_sprite, gender = entry
    $game_player.set_appearance_set(walk_sprite)
    set_player_back(back_sprite)

    # Only change gender if a value is provided
    unless gender.nil?
      $game_switches[Yuki::Sw::Gender] = gender
      log_debug("Gender set to #{gender ? 'female' : 'male'} for outfit #{symbol}")
    end
    $game_player.update_appearance
  end

  # Automatically sets the outfit to Lyra
  def outfit_lyra
    apply_outfit(:lyra_outfit)
    return true
  end

  # Automatically sets the outfit to Ethan
  def outfit_ethan
    apply_outfit(:ethan_outfit)
    return true
  end
end
