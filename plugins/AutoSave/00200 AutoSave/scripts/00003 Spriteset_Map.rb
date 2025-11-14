module AutoSave_SpritesetMap
  # Public: trigger showing the autosave UI immediately
  def show_autosave_ui
    init_autosave_ui
  end

  # Public: schedule an autosave to run after events finish
  def schedule_autosave
    @autosave_wait_for_idle = true
  end

  # Public: check if autosave UI is active
  def autosave_active?
    defined?(@autosave_sprite) && @autosave_sprite
  end

  # Public: check if autosave is pending
  def autosave_pending?
    @autosave_wait_for_idle || @pending_autosave
  end

  # Display the autosave UI (internal)
  def init_autosave_ui
    return if autosave_active?

    @autosave_sprite = UI::AutoSave.new(@viewport2)
  end

  # Disposes the autosave UI
  def dispose_autosave_ui
    @autosave_sprite&.dispose
    @autosave_sprite = nil
  end

  # Override dispose to clean autosave properly
  def dispose(from_warp = false)
    dispose_autosave_ui
    super
  end

  # Update every sprite (autosave included)
  def update
    super

    # If we’re waiting for the interpreter to finish running,
    # schedule the autosave only once it’s idle.
    if @autosave_wait_for_idle && !$game_system.map_interpreter.running?
      @pending_autosave = true
      @autosave_wait_for_idle = false
    end

    # Execute autosave when it’s pending and safe to do so
    if @pending_autosave
      init_autosave_ui
      GamePlay::Save.save
      @pending_autosave = false
    end

    update_autosave
  end

  # Update the autosave animation, or dispose it
  def update_autosave
    return unless @autosave_sprite

    @autosave_sprite.update
    dispose_autosave_ui if @autosave_sprite.done?
  end
end

Spriteset_Map.prepend(AutoSave_SpritesetMap)
