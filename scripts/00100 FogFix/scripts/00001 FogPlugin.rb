class Spriteset_Map
  # Plugin adding the fog effect to the Spriteset_Map
  module FogPlugin
    private
    # Update some fog sprite parameters
    def update_fog_sprite_parameters
      @fog.zoom = ($game_map.fog_zoom / 100.0) * 0.5
      @fog.opacity = $game_map.fog_opacity.to_i
      @fog.blend_type = $game_map.fog_blend_type
      @fog.set_origin($game_map.display_x / 4, $game_map.display_y / 4)
      @fog.tone = $game_map.fog_tone
    end
  end
end
