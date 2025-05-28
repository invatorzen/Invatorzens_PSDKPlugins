module Battle
  module Effects
    class Item
      class RoomService < Item
	    remove_const :USED_UP
        USED_UP = 1317 # "[VAR PKNICK(0000)]'s Room Service was used up..." message
      end
    end
  end
end