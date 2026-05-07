module UI
  module Bag
    class BagSprite
      # Patch module that picks the bag sprite based on the gender variable
      module NBSupportBag
        private

        # Override of {UI::Bag::BagSprite#bag_filename} that selects the bag sprite
        # based on the gender variable value (e.g. "bag/bag_0", "bag/bag_2")
        # @return [String] bag sprite filename
        def bag_filename
          "bag/bag_#{Inva::NBSupport.gender}"
        end
      end
      prepend NBSupportBag
    end
  end
end
