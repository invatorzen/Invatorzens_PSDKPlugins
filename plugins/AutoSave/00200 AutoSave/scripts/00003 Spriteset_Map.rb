class Spriteset_Map
  # Display the autosave UI
  def init_autosave_ui
    return if @autosave_sprite

    @autosave_sprite = UI::AutoSave.new(@viewport2)
  end
  Hooks.register(self, :show_autosave_ui, 'Show the Autosave UI') do
    init_autosave_ui
  end

  # Disposes the autosave ui
  def dispose_autosave_ui
    @autosave_sprite&.dispose
    @autosave_sprite = nil
    remove_instance_variable(:@autosave_sprite)
  end

  # Update the autosave animation, or dispose it
  def update_autosave
    return unless @autosave_sprite

    @autosave_sprite.update
    dispose_autosave_ui if @autosave_sprite&.done?
  end
  Hooks.register(self, :update, 'AutoSave animation') { update_autosave }
end
