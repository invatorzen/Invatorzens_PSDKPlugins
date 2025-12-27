# Better catching if the Pokémon is an evolution of another mon
# Concept by Substitube, code by Rey
Battle::Logic::CatchHandler.add_ball_rate_calculation(:evo_ball) do |target, _pkm_ally|
    next (target.rareness * 3.5) if each_data_creature.any? { |creature| creature.forms.any? { |form| form.evolutions.any? { |evolution| evolution.db_symbol == target.db_symbol && evolution.form == target.original.form } } }
    next target.rareness
  end