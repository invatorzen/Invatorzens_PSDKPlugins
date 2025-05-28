module Battle
  class Scene
    # Begin the Pokemon giving procedure
    # @param battler [PFM::PokemonBattler] pokemon that was just caught
    # @param ball [Studio::BallItem]
	alias old_give_pokemon give_pokemon_procedure
    def give_pokemon_procedure(battler, ball)
      old_give_pokemon(battler, ball)
      pkmn = battler.original
      pkmn.shadow = true if ball&.db_symbol == :dark_ball #New
      battler.loyalty = 0 if ball&.db_symbol == :dark_ball #New
    end
  end
end
