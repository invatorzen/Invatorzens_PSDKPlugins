module Battle
    module Effects
      class Item
        class RedCard < Item
		  remove_const :USED_UP
          USED_UP = 1314 # "[VAR PKNICK(0000)]'s Red Card was used up..."
        end
      end
    end
  end