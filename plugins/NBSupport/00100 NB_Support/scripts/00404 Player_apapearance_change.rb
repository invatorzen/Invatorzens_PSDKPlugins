# Changes the overworld sprite gender to match the games variable.
# 0 = f, 1 = m, 2 = nb
class Game_Player
  GENDER_S = %w[f m nb]
  def update_appearance(forced_pattern = 0)
    return unless @charset_base

    set_appearance("#{@charset_base}#{chara_by_state}")
    @pattern = forced_pattern
    update_pattern_state
    return true
  end
end