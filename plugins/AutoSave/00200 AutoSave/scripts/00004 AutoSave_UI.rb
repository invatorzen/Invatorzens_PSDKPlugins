module UI
  class AutoSave < SpriteStack
    def initialize(viewport)
      super(viewport, *initial_coordinates)
      @animation = nil
      @animation_stage = 0
      create_sprites
      start_fade_in_animation
    end

    def update
      return if Graphics.frozen?

      @animation&.update
      check_animation_completion
    end

    def done?
      return @animation.nil?
    end

    private

    def create_sprites
      @autosave_icon_core = add_sprite(0, 0, 'autosave/PSDKLogo_core_perfect', ox: 25, oy: 25)
      @autosave_icon_border = add_sprite(0, 0, 'autosave/PSDKLogo_border_s', ox: 25, oy: 25)
    end

    def start_fade_in_animation
      ya = Yuki::Animation
      fade_in_core = ya.opacity_change(0.4, @autosave_icon_core, 0, 255)
      fade_in_border = ya.opacity_change(0.4, @autosave_icon_border, 0, 255)
      anim = fade_in_core.parallel_add(fade_in_border)
      anim.play_before(ya.wait(0.5))
      anim.start
      @animation = anim
      @animation_stage = 1
    end

    def start_rotation_animation
      update_core_sprite(:rotating)
      ya = Yuki::Animation
      anim = ya.rotation(1.0, @autosave_icon_border, 0, 360)
      anim.play_before(ya.wait(0.5))
      anim.start
      @animation = anim
      @animation_stage = 2
    end

    def start_fade_out_animation
      update_core_sprite(:fading)
      ya = Yuki::Animation
      fade_out_core = ya.opacity_change(0.4, @autosave_icon_core, 255, 0)
      fade_out_border = ya.opacity_change(0.4, @autosave_icon_border, 255, 0)
      anim = fade_out_core.parallel_add(fade_out_border)
      anim.start
      @animation = anim
      @animation_stage = 3
    end

    def check_animation_completion
      return unless @animation&.done?

      case @animation_stage
      when 1
        start_rotation_animation
      when 2
        update_core_sprite(:original)
        start_fade_out_animation
      when 3
        @animation = nil # All animations done
      end
    end

    def update_core_sprite(state)
      case state
      when :rotating
        @autosave_icon_core.set_bitmap('autosave/PSDKLogo_core_s', :interface)
      when :original, :fading
        @autosave_icon_core.set_bitmap('autosave/PSDKLogo_core_perfect', :interface)
      end
    end

    def initial_coordinates
      [275, 29]
    end
  end
end
