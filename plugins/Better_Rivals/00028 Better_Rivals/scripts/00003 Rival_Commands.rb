# Interpreter commands revolving around rivals
module Rival_Commands
  # Allows players to name their rival and store their data
  # @param rival_index [Integer] the index in the $rivals array
  # @param rival_name [String] the name to display in the name_input window
  # @param rival_image [String] the image used for this rival
  # @param actor_index [Integer] the $game_actors index for this rival
  # @param message [Integer, Integer] message displayed when inputting name
  # @param max_char [Integer] max characters allowed to input
  def name_rival(rival_index = 0, rival_name = $rivals[0].name, rival_image = $rivals[0].graphic, actor_index = $rivals[0].game_actors_index,
                 message: [100_997, 0], max_char: 12)
    $scene.window_message_close(false) if $scene.class == Scene_Map
    GamePlay.open_character_name_input(rival_name, max_char, rival_image, message) do |name_input|
      $game_actors[actor_index].name = name_input.return_name
    end
    $game_actors[actor_index].character_name = rival_image
    @wait_count = 2
    set_rival_data(rival_index, rival_name, rival_image, actor_index)
  end

  # Allows users to create new rivals on the fly
  # @param rival_index [Integer] The index in the $rivals array for this rival to appear
  # @param rival_name [String] The name of the rival
  # @param rival_image [String] The OW image for the rival
  # @param game_actors_index [Integer] The $game_actors index
  # @param starter [Symbol] The symbol of their starter pokemon
  # @param team [Array] The array of their team
  # Example: create_rival(0, "Blue", "npc_blue", 7)
  def create_rival(rival_index = $rivals.instance_variable_get(:@rivals).length, rival_name = 'John', rival_image = 'npc_blue',
                   game_actors_index = 7, rival_bgm: nil, starter: nil, team: nil)
    $rivals.create_rival(rival_index, name: rival_name, graphic: rival_image, game_actors_index: game_actors_index, battle_bgm: rival_bgm,
                                      starter: starter, team: team)
    log_debug("Created rival: #{rival_name} at index: #{rival_index}") unless $rivals[rival_index].nil?
    true
  end
  alias overwrite_rival create_rival

  # Sets the event to user the rival's graphic
  # @param event [Integer] event id to target (-1 for player)
  # @param rival_index [Integer] the index in $rivals to target (defaults to first rival)
  def set_rival_sprite(event = -1, rival_index = 0)
    get_character(event).set_appearance($rivals[rival_index].graphic)
    true
  end
  alias set_player_to_rival_sprite set_rival_sprite

  # Sets the rivals starter pokemon
  # @param starter [Symbol] the db_symbol of the pokemon
  def set_rival_starter(rival_index, starter)
    $rivals[rival_index].starter = starter
    log_debug("Rival #{$rivals[rival_index].name}'s starter is now set to: #{$rivals[rival_index].starter}")
    true
  end

  # Sets the rivals team array to a specific trainer's
  # @param rival_index [Integer] the index in $rivals
  # @param trainer_index [Integer] the ID for the trainer, found in Studio
  # @note If the trainer_index doesn't actually exist, it seems to default to 0. (I believe this is a PSDK thing.)
  def set_rival_team_from_trainer(rival_index, trainer_index)
    # Create a new BattleInfo instance and add the trainer's team
    bi = Battle::Logic::BattleInfo.new
    Battle::Logic::BattleInfo.add_trainer(bi, 1, trainer_index)
    # Access the trainer's team from the generated battle info
    trainer_team = bi.parties[1][0]

    # Duplicate the team and assign to the rival
    $rivals[rival_index].team = trainer_team.map(&:dup)
    true
  end

  # The core to starting a rival battle
  def start_rival_battle_internal(rivals, bgm, disable, enable, can_lose, _can_escape, troop_id)
    # Ensure all required teams are present
    rivals.each do |rival|
      log_error('This rival has no team') if rival.team.nil?
      return if rival.team.nil?
    end

    set_self_switch(false, disable, @event_id) # Better to disable the switch here than in defeat
    $game_variables[::Yuki::Var::BT_Mode] = rivals.length == 1 ? 1 : 2 # 1 for single, 2 for double battle

    # Save references to the original battle BGM
    original_battle_bgm = $game_system.battle_bgm
    $game_system.battle_bgm = RPG::AudioFile.new(*bgm)

    # Prepare $game_temp
    $game_temp.rival1_battler = rivals[0]
    $game_temp.rival2_battler = rivals[1] if rivals.length == 2
    $game_temp.battle_abort = true
    $game_temp.battle_calling = true
    $game_temp.battle_troop_id = troop_id
    $game_temp.battle_can_escape = false
    $game_temp.battle_can_lose = can_lose
    $game_temp.battle_proc = proc do |n|
      yield if block_given?
      # Resets after battles
      $game_temp.rival1_battler = nil
      $game_temp.rival2_battler = nil
      $game_variables[Yuki::Var::Allied_Trainer_ID] = 0
      set_self_switch(true, enable, @event_id) if n == 0
      $game_system.battle_bgm = original_battle_bgm
      $game_variables[::Yuki::Var::BT_Mode] = 0
    end
    Yuki::FollowMe.set_battle_entry
    Yuki::FollowMe.save_follower_positions
  end

  def start_rival_battle(rival_index = 0, bgm: $rivals[rival_index].battle_bgm, disable: 'A', enable: 'B', can_lose: false, can_escape: false,
                         troop_id: 3)
    start_rival_battle_internal([$rivals[rival_index]], bgm, disable, enable, can_lose, can_escape, troop_id)
  end

  def start_rival_double_battle(rival1_index = 0, rival2_index = 1, bgm: $rivals[rival1_index].battle_bgm, disable: 'A', enable: 'B',
                                can_lose: false, can_escape: false, troop_id: 3)
    start_rival_battle_internal([$rivals[rival1_index], $rivals[rival2_index]], bgm, disable, enable, can_lose,
                                can_escape, troop_id)
  end

  private

  # Sets the specified rival's name, image, and actor index
  # @param rival_index [Integer] The index in the $rivals array for this rival to appear
  # @param rival_name [String] The name of the rival
  # @param rival_image [String] The OW image for the rival
  # @param game_actors_index [Integer] The $game_actors index
  def set_rival_data(rival_index, rival_name, rival_image, actor_index)
    $rivals[rival_index].name = rival_name
    $rivals[rival_index].graphic = rival_image
    $rivals[rival_index].game_actors_index = actor_index
    true
  end
end

Interpreter.include(Rival_Commands)
