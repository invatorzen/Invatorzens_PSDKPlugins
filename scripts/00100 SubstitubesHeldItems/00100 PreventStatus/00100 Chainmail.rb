module Battle
  class Logic
    # List of items preventing the critical hit from happening
    NO_CRITICAL_ITEMS = %i[chainmail]

    # Calculate the critical count (to get the right critical propability)
    alias default_calc_critical_count calc_critical_count
    def calc_critical_count(user, target, initial_critical_count)
      return 0 if user.can_be_lowered_or_canceled?(NO_CRITICAL_ITEMS.include?(target.item_db_symbol))
      default_calc_critical_count(user, target, initial_critical_count)
    end
  end
end
