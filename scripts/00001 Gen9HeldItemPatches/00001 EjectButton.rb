# Let's you change the line to pull from for Eject Button
# Known PSDK bug with Eject Button: When a mon gets switched out their move still proceeds as if they didn't. Not caused by this plugin.

module Battle
  module Effects
    class Item
      class EjectButton < Item
	    remove_const :USED_UP
        USED_UP = 1302 # "[VAR PKNICK(0000)]'s Eject Button was used up..." message
	  end
    end
  end
end