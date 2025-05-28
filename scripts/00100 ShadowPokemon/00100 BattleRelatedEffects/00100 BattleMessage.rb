# The switch to disable ShadowSpeed effect. 
#If true ShadowSpeed does not get applied to Shadow Pokemon.
DISABLE_SHADOW_SPEED = 129

module Battle
  # Displays a message after the player sends out their pokemon if the enemy has a shadow pokemon
  module Message
    module_function
    def see_shadow_pokemon_start
      @text.reset_variables
      @text.set_plural(false)
      @text.parse(999, 42)
    end
  end
end

module Battle
  class Scene
    private
    # Disables asking the player to rename a stolen/shadow pokemon
    def rename_sequence(pkmn)
      if !pkmn.shadow?
        if display_message_and_wait(parse_text(30, 0, PKNAME[0] => pkmn.name), 0, text_get(25, 20), text_get(25, 21)) == 0
          GamePlay.open_pokemon_name_input(pkmn) { |scene| pkmn.given_name = scene.return_name }
        end
      end
    end
  end
end


# Handler of ShadowSpeed effect
module ShadowTransitionMessage
  # Applies ShadowSpeed to player mon if shadow
  def show_player_send_message
    super
	  get_player_shadow_pokemon.each do |pokemon|
	    pokemon.effects.add(Battle::Effects::ShadowSpeed.new(@logic, pokemon)) unless $game_switches[DISABLE_SHADOW_SPEED]
	  end
  end
  
  # Detects if player mon is shadow
  def get_player_shadow_pokemon
	  return $game_temp.vs_type.times.map do |i|
      @scene.logic.battler(0, i)
    end.select { |pokemon| pokemon && !pokemon.dead? && pokemon.shadow? }
  end

  # Applies the ShadowSpeed effect to enemy pokemon when Shadow
  def show_enemy_send_message
    super
	  get_enemy_shadow_pokemon.each do |pokemon|
	    pokemon.effects.add(Battle::Effects::ShadowSpeed.new(@logic, pokemon)) unless $game_switches[DISABLE_SHADOW_SPEED]
	  end
  end
  
  # Detects shadow pokemon from enemy
  def get_enemy_shadow_pokemon
	  return $game_temp.vs_type.times.map do |i|
      @scene.logic.battler(1, i)
    end.select { |pokemon| pokemon && !pokemon.dead? && pokemon.shadow? }
  end
end

# Displays message when switching pokemon if on the enemy side and it's shadow
# Applies ShadowSpeed effect
module ShadowSwitchMessage
  def execute
    super
	  if !@with.dead? && @with.shadow?
	    @scene.display_message(parse_text(999, 42)) if @with.bank != 0
      @with.effects.add(Battle::Effects::ShadowSpeed.new(@logic, @with)) unless $game_switches[DISABLE_SHADOW_SPEED]
	  end
  end
end

Battle::Visual::Transition::Base.prepend(ShadowTransitionMessage)
Battle::Actions::Switch.prepend(ShadowSwitchMessage)