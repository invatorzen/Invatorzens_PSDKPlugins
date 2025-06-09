# Changes the image based on the variable's number to either bag/bag_0, bag/bag_1, or bag/bag_2
# Modifies 00040 BagSprite
# Credits: Nuri Yuri
module UI
  module Bag
    class BagSprite
      # List of bag images
      BAG_IMAGES = %w[bag/bag_0 bag/bag_1 bag/bag_2]

      private

      def bag_filename
        BAG_IMAGES[$game_variables[Yuki::Var::GenderVar]] || BAG_IMAGES[0]
      end
    end
  end
end