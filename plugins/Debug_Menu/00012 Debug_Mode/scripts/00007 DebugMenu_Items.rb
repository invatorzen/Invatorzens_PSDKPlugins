# Debug Menu - Item Actions
# Contains actions related to bag management and item acquisition

module GamePlay
  class DebugMenu
    # Add a specific item to the bag.
    # Prompts for item species name and quantity.
    def add_item
      item_input = display_text_input(text_get(TEXT_FILE_ID, 60), 'potion')
      return if item_input.nil? || item_input.empty?

      item_sym = item_input.downcase.to_sym

      # Verify item exists
      begin
        item = data_item(item_sym)
        unless item && item.id > 0
          display_message(format(text_get(TEXT_FILE_ID, 61), item_sym))
          return
        end
      rescue
        display_message(format(text_get(TEXT_FILE_ID, 61), item_sym))
        return
      end

      quantity = display_number_input(text_get(TEXT_FILE_ID, 36), 1)
      return if quantity.nil?
      quantity = [quantity, 1].max

      $bag.add_item(item_sym, quantity)
      display_message(format(text_get(TEXT_FILE_ID, 95), quantity, item.name))
    end

    # Add a specified quantity of every item to the bag.
    def fill_bag
      quantity = display_number_input(text_get(TEXT_FILE_ID, 103), 10)
      return if quantity.nil?
      quantity = [quantity, 1].max

      count = 0
      each_data_item do |item|
        next if item.db_symbol == :__undef__ || item.id == 0
        $bag.add_item(item.db_symbol, quantity)
        count += 1
      end
      display_message(format(text_get(TEXT_FILE_ID, 102), quantity, count))
    end

    # Empty the entire bag.
    # Requires double confirmation via list choice.
    def empty_bag
      choice = display_list_choice(text_get(TEXT_FILE_ID, 101), [text_get(TEXT_FILE_ID, 55), text_get(TEXT_FILE_ID, 56)])
      return if choice != 0

      $bag = PFM::Bag.new
      display_message(text_get(TEXT_FILE_ID, 94))
    end
  end
end
