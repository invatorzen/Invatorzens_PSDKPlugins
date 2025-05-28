module Battle
  module Effects
    class Item
      class ThroatSpray < Item
	    remove_const :USED_UP
        USED_UP = 1299 # "[VAR PKNICK(0000)]'s Throat Spray was used up..." message
      end
    end
  end
end