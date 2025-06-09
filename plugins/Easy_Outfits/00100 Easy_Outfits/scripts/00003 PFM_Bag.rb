module PFM
  class Bag
    # Check if a specific socket (pocket) in the bag is empty
    # @param socket [Integer, Symbol] ID of the socket to check
    # @return [Boolean] true if the socket is empty, false otherwise
    def is_socket_empty?(socket)
      # Return true if the bag is locked or the socket itself is empty
      return true if @locked || get_order(socket).empty?

      # Check if any items in the socket have a quantity greater than 0
      get_order(socket).each do |db_symbol|
        return false if item_quantity(db_symbol) > 0
      end

      # If no items with a positive quantity were found, the socket is empty
      return true
    end
  end
end
