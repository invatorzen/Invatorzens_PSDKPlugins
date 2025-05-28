# Let's you change the line to pull from for Eject Pack
# Known PSDK bug with Eject Pack: When a mon gets switched out their move still proceeds as if they didn't. Not caused by this plugin.

module Battle
  module Effects
    class Item
      class EjectPack < Item
	    remove_const :USED_UP
        USED_UP = 1305 # "[VAR PKNICK(0000)]'s Eject Pack was used up..." message
	  end
    end
  end
end