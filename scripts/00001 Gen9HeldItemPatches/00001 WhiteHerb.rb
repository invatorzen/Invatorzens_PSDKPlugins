module Battle
    module Effects
      class Item
        class WhiteHerb < Item
		  remove_const :USED_UP
          USED_UP = 1308 # "The White Herb was used up..." message
        end
      end
    end
  end