# Allows the code to know if the move is a mental move
module Battle
  # Generic class describing a move
  class Move
    # Tell if the move is a mental move
    # @return [Boolean]
    def mental?
      return data.is_mental
    end
  end
end