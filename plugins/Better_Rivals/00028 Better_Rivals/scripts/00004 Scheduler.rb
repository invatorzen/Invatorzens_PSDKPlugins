module Scheduler
  # Add a scheduler proc that runs when switching to ::GamePlay::Load
  add_proc(:on_scene_switch, ::GamePlay::Load, 'Initialize Rivals if Missing', 1000) do
    # Ensure both $rivals and $rival exist after loading
    if $rivals.nil? || $rival.nil?
      log_debug('Adding rival to existing save')
      # Initialize default rival and rivals manager if they don't exist
      $rival ||= PFM::Rival.new
      $rivals ||= PFM::Rivals.new
      $rivals.add_rival($rival) if $rivals.rivals.empty?
    end
  end
end
