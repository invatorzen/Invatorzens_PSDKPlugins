# Let's you change the line to pull from for Air Balloon

module Battle
  module Effects
    class Item
      class AirBalloon < Item
	    remove_const :USED_UP
        USED_UP = 1296 # "[VAR PKNICK(0000)]'s Air Balloon was used up..." message
	  end
    end
  end
end  