PFM::ItemDescriptor.define_on_creature_usability(Studio::TechItem) do |item, creature|
  next false if creature.shadow?

  next creature.can_learn?(Studio::TechItem.from(item).move)
end