module Battle
  class Move
    # Move that inflict attract effect to the ennemy
    class Attract < Move
      private
	  remove_const :USED_UP
      USED_UP = 1311 # "[VAR PKNICK(0000)]'s Mental Herb was used up..." message
    end
  end
end