module RfColorUtils
  # Some colors I like :3
  COLORS = {
    white: Color.new(255, 255, 255),
    black: Color.new(0, 0, 0),
    red: Color.new(255, 0, 0),
    green: Color.new(0, 255, 0),
    blue: Color.new(0, 0, 255),
    yellow: Color.new(255, 255, 0),
    orange: Color.new(255, 165, 0),
    purple: Color.new(128, 0, 128),
    cyan: Color.new(0, 255, 255),
    magenta: Color.new(255, 0, 255)
  }

  def self.resolve(color)
    color.is_a?(Symbol) ? (COLORS[color] || COLORS[:white]) : color
  end
end

# Register Shaders
Shader.register(:rf_outline, 'graphics/shaders/rf_outline.frag')
Shader.register(:rf_blur, 'graphics/shaders/rf_blur.frag')

# Extension for shader support on Sprites
class Sprite
  # Apply outline effect using Shader
  def rf_apply_outline(color: :white, width: 1)
    return unless self.bitmap

    actual_color = RfColorUtils.resolve(color)

    sh = Shader.create(:rf_outline)
    sh.set_float_uniform("textureSize", [self.bitmap.width.to_f, self.bitmap.height.to_f])
    sh.set_float_uniform("outlineColor", [actual_color.red/255.0, actual_color.green/255.0, actual_color.blue/255.0, actual_color.alpha/255.0])
    sh.set_float_uniform("width", width.to_f)
    
    self.shader = sh
  end

  # Apply blur effect using Shader
  def rf_apply_blur(power: 1.0)
    return unless self.bitmap

    sh = Shader.create(:rf_blur)
    sh.set_float_uniform("textureSize", [self.bitmap.width.to_f, self.bitmap.height.to_f])
    sh.set_float_uniform("power", power.to_f)
    
    self.shader = sh
  end
  
  def rf_clear_effects
    self.shader = nil
  end
end

# Extension for shader support on Viewport
class Viewport
  # Apply outline effect using Shader to the entire viewport content
  # Useful for avoiding clipping on sprites by placing them in a larger viewport (I had to do this -invatorzen)
  def rf_apply_outline(color: :white, width: 1)
    actual_color = RfColorUtils.resolve(color)

    sh = Shader.create(:rf_outline)
    # Viewport texture size is its rect size
    sh.set_float_uniform("textureSize", [self.rect.width.to_f, self.rect.height.to_f])
    sh.set_float_uniform("outlineColor", [actual_color.red/255.0, actual_color.green/255.0, actual_color.blue/255.0, actual_color.alpha/255.0])
    sh.set_float_uniform("width", width.to_f)
    
    self.shader = sh
  end
  
  def rf_clear_effects
    self.shader = nil
  end
end

# Maths functions
module Math
  def self.lerp(a, b, t)
    return (1 - t) * a + t * b
  end
end

module Rf
  # You can use this as a global "wait for everything" kind of thing
  def self.wait_for_move_route
    loop do
        Graphics.update
        if $scene.respond_to?(:miniupdate)
          $scene.miniupdate
        else
          $scene.update if $scene.respond_to?(:update)
        end
  
        move_route_forcing = false
  
        move_route_forcing = true if $game_player.move_route_forcing
        $game_map.events.each_value do |event|
            move_route_forcing = true if event.move_route_forcing
        end
        
        if $game_temp.respond_to?(:followers)
          $game_temp.followers.each_follower do |event, follower|
            move_route_forcing = true if event.move_route_forcing
          end
        end
  
        break if !move_route_forcing
    end
  end
end
