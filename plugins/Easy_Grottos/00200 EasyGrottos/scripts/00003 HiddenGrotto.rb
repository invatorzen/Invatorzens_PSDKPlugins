class HiddenGrotto < Interpreter_RMXP
  attr_accessor :steps, :grotto_type, :gift, :map_id, :event_id, :time_to_reset, :day_set, :month_set

  def initialize(map_id, event_id)
    @map_id = map_id
    @event_id = event_id
    @steps = 256
    @gift = nil
    @grotto_type = nil
    @time_to_reset = true
    @day_set = $game_variables[Yuki::Var::TJN_MDay]
    @month_set = $game_variables[Yuki::Var::TJN_Month]
  end

  # @return [Boolean] if a new day has started or just time to reset grotto item bc steps
  def time_to_reset
    current_day = $game_variables[Yuki::Var::TJN_MDay]
    current_month = $game_variables[Yuki::Var::TJN_Month]

    @time_to_reset = true if current_month > @month_set || (current_month == @month_set && current_day > @day_set)

    return @time_to_reset
  end

  # Generates a new gift for the hidden grotto
  def generate_gift
    map_key = @map_id.to_s.to_sym
    @grotto_type = get_random_type
    @gift = case @grotto_type
            when :unique_item
              data = get_from_sample(Configs.grotto_config.unique_items[map_key])
              data = convert_strings_to_symbols(data)
              get_from_sample(data)
            when :pokemon
              data = get_from_sample(Configs.grotto_config.unique_pokemon[map_key])
              data = convert_strings_to_symbols(data)
              PFM::Pokemon.generate_from_hash(data)
            when :item
              data = Configs.grotto_config.visible_items
              data = convert_strings_to_symbols(data)
              get_from_sample(data)
            when :hidden_item
              data = Configs.grotto_config.hidden_items
              data = convert_strings_to_symbols(data)
              get_from_sample(data)
            end
    @day_set = $game_variables[Yuki::Var::TJN_MDay]
    @month_set = $game_variables[Yuki::Var::TJN_Month]
  end

  # Sets the character sprite to a mon, invisible item, or a pokeball
  def set_event_sprite
    character = get_character(@event_id)
    character.direction = 2
    character.through = false
    character.step_anime = false
    case @grotto_type
    when :unique_item, :item
      character.character_name = 'fx-Pokeball'
      character.direction_fix = true
    when :pokemon
      character.step_anime = true
      character.character_name = gift.character_name
    when :hidden_item
      character.character_name = 'fx-Pokeball'
      character.direction = 8
      character.direction_fix = true
      character.through = true
    end
    character.character_name
  end

  # Returns if a new gift should spawn
  def check_for_gift
    helper = RandomHelper.new
    helper.add(5, true)
    helper.add(95, false)
    return helper.get
  end

  # Resets the Hidden Grotto after player gets gift
  def receieved_gift
    @steps = 0
    @gift = nil
  end

  private

  # Returns the type of grotto to create
  def get_random_type
    helper = RandomHelper.new
    helper.add(39, :item)
    helper.add(1, :unique_item)
    helper.add(40, :hidden_item)
    helper.add(20, :pokemon)
    return helper.get
  end

  # Handles the randomization and grabbing the right item/mon
  def get_from_sample(entries)
    return nil if entries.nil? || entries.empty?

    helper = RandomHelper.new
    entries.each do |weight, value|
      helper.add(weight, value)
    end
    return helper.get
  end

  # We convert any string to symbols because JSON is freaky-deaky
  def convert_strings_to_symbols(data)
    case data
    when Hash
      data.transform_keys!(&:to_sym)
      data.each { |k, v| data[k] = convert_strings_to_symbols(v) }
    when Array
      data.map! { |v| convert_strings_to_symbols(v) }
    when String
      data.to_sym
    else
      data
    end
  end
end
