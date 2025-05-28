#Disables the shadow of all overworld Pokémon (if their graphic is just numbers)
#Made by Nuri Yuri
class Game_Character
  alias psdk_character_name= character_name=
  def character_name=(character_name)
    if character_name =~ /^[0-9]+/
      @shadow_disabled = :pokemon
    elsif @shadow_disabled == :pokemon
      @shadow_disabled = false
    end
    self.psdk_character_name = character_name
  end
end