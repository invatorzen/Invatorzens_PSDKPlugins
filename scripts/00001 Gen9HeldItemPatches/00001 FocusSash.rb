# Adds in a check to see if you have gen 9 held item mechanic on, changes how the item is consumed and the message displayed

module Battle
  module Effects
    class Item
      class FocusSash < Item
	    remove_const :USED_UP
        USED_UP = 1293 # "[VAR PKNICK(0000)]'s Focus Sash was used up... message
      end
    end
  end
end