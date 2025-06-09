class Scene_Map
  # Register rival battle mode
  register_battle_mode(1) do |scene|
    # Set up battle information from rival settings
    battle_info = Battle::Logic::BattleInfo.from_rival_settings($game_temp.rival1_battler)
    # Start the battle with the configured scene and battle information
    scene.setup_start_battle(Battle::Scene, battle_info)
  end
  # Register rival double battle mode
  register_battle_mode(2) do |scene|
    # Set up battle information from rival settings
    battle_info = Battle::Logic::BattleInfo.from_rival_settings($game_temp.rival1_battler, $game_temp.rival2_battler)
    # Start the battle with the configured scene and battle information
    scene.setup_start_battle(Battle::Scene, battle_info)
  end
end
