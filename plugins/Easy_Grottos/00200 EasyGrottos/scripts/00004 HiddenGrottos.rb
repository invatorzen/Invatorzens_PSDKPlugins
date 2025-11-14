class HiddenGrottos
  def initialize
    @grottos = {}
  end

  def get(map_id)
    @grottos[map_id]
  end
  alias grotto get

  def create(map_id, event_id = 1)
    return @grottos[map_id] if @grottos.key?(map_id)

    @grottos[map_id] = HiddenGrotto.new(map_id, event_id)
  end
  alias add create

  def reset(map_id)
    @grottos.delete(map_id)
  end
  alias clear reset

  def all
    @grottos.values
  end

  def increase_step_count
    @grottos.each_value do |grotto|
      next if grotto.time_to_reset == true || !grotto.gift.nil?

      grotto.steps += 1
      next unless grotto.steps >= 256

      new_gift = grotto.check_for_gift
      grotto.steps = 0
      grotto.time_to_reset = true if new_gift
    end
  end
end
