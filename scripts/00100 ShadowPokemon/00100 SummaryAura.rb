module UI
  # UI part displaying the generic information of the Pokemon in the Summary
  class Summary_Top < SpriteStack
    # Update the graphics
    def update_graphics
      @sprite.update
      update_aura
    end

    # Set the Pokemon shown
    # @param pokemon [PFM::Pokemon]
    alias old_data data=
    def data=(pokemon)
      super
      old_data(pokemon)
      @aura.visible = pokemon.shadow?
    end
    private
    alias old_init_sprite init_sprite
    def init_sprite
      old_init_sprite
      @aura = create_aura
      @aura_frame = 0
    end
    
    def create_aura
      push(15, 30, 'new_shadow_aura_sheet', rect: [0, 0, 70, 70]) # older is 80 80
    end

    def update_aura
      height = 70 # old is 80
      width = 2100 # old is 2400
      frame_width = height
      total_frames = width / height

      # Set the frame rate (lower value means slower animation)
      frame_rate = 10  # Adjust this value to control the animation speed
      frame_delay = 60 / frame_rate  # Assuming 60 FPS

      # Increment the frame counter
      @aura_frame_counter = (@aura_frame_counter || 0) + 1

      # Check if enough frames have passed to update the animation
      if @aura_frame_counter >= frame_delay
        # Update the frame count
        @aura_frame = (@aura_frame + 1) % total_frames
        # Reset the frame counter
        @aura_frame_counter = 0
      end

      # Calculate the new source rectangle coordinates based on the current frame
      src_x = @aura_frame * frame_width

      # Update the source rectangle of the aura sprite
      @aura.src_rect.set(src_x, 0, frame_width, 80)
    end
  end
end