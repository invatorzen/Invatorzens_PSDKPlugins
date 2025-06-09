# Clears the nickname screen when naming a Pokémon
# Made by Nuri Yuri
class Scene_NameInput
  alias old_init initialize
  def initialize(default_name, max_length, character = nil)
    old_init(default_name, max_length, character)
    @name.clear if character.is_a?(PFM::Pokemon)
  end
end
