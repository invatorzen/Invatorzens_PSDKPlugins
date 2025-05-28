module Battle
  class Visual
    # Show the ability animation
    # @param target [PFM::PokemonBattler]
    # @param [Boolean] no_go_out Set if the out animation should be not played automatically
    alias default_show_ability show_ability
    def show_ability(target, no_go_out = false)
      Audio.se_play("Audio/SE/In-Battle_Ability_Activate.mp3")
      default_show_ability(target, no_go_out = false)
    end
    # Show the item user animation
    # @param target [PFM::PokemonBattler]
    alias default_show_item show_item
    def show_item(target)
      Audio.se_play("Audio/SE/In-Battle_Ability_Activate.mp3")
      default_show_item(target)
    end
  end
end