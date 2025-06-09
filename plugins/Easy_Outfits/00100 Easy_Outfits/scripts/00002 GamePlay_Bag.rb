module GamePlay
  class Bag < BaseCleanUpdate::FrameBalanced
    include BagMixin

    # The name of the pocket
    # Only English is provided
    NEW_POCKETS = [
      [:text_get, 6969, 3] # Outfits
    ]

    # Appends our new pockets to the old list
    POCKET_NAMES.push(*NEW_POCKETS)

    # Re-defines the default menu
    # There are more options - menu, battle, berry, hold and shop.
    # We are only modifying the default menu one, though.
    POCKETS_PER_MODE[:menu] = [1, 2, 6, 3, 5, 4, 8, Configs.outfit_config.outfit_bag_slot]
    POCKETS_PER_MODE.default = POCKETS_PER_MODE[:menu]
  end
end

module UI
  module Bag
    class PocketList < SpriteStack
      remove_const :POCKET_TRANSLATION

      # These icons are pulled from graphics/interface/bag/pockets_active.png and pockets_inactive.png
      POCKET_TRANSLATION = [0, 0, 1, 3, 5, 4, 2, 6, 7, Configs.outfit_config.outfit_icon_slot]
    end
  end
end
