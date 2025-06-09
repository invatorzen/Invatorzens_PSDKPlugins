# Changes how the held item icon works. Fixes a bug that showed you holding an item on the team UI when it was temporarily consumed in battle.

module UI
  # Sprite that show the hold item if the pokemon is holding an item
  class HoldSprite < Sprite
    # Name of the image in Graphics/Interface
    IMAGE_NAME = 'hold'
    # Create a new Hold Sprite
    # @param viewport [Viewport, nil] the viewport in which the sprite is stored
    def initialize(viewport)
      super(viewport)
      set_bitmap(IMAGE_NAME, :interface)
    end

    # Set the Pokemon used to show the hold image
    # @param pokemon [PFM::Pokemon, nil]
    def data=(pokemon)
      if pokemon
        item_id = ($game_temp.in_battle ? pokemon.battle_item : pokemon.item_holding) || 0
        self.visible = item_id != 0
      else
        self.visible = false
      end
      # New changes
      self.visible = if $game_temp.in_battle
                       (pokemon ? pokemon.battle_item != 0 : false)
                     else
                       (pokemon ? pokemon.item_holding != 0 : false)
                     end
    end
  end
end
