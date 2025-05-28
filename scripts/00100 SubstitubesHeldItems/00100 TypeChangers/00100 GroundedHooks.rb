module PFM
  class PokemonBattler
    register_force_flying_hook('PSDK flying: Magic Balloon') { |pokemon| pokemon.hold_item?(:magic_balloon) }
    register_force_flying_hook('PSDK flying: Water Balloon') { |pokemon| pokemon.hold_item?(:water_balloon) }
    register_force_flying_hook('PSDK flying: Dirty Balloon') { |pokemon| pokemon.hold_item?(:dirty_balloon) }
  end
end