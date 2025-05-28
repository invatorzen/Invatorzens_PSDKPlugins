#Makes it to where the fog doesn't move with the player
#Created by MikeCakes
class Spriteset_Map
  # Retrieve the Game Player sprite
  # @return [Sprite_Character]
  attr_reader :game_player_sprite
  def update_panorama_fog
    if @panorama_name != $game_map.panorama_name # or @panorama_hue != $game_map.panorama_hue
      @panorama_name = $game_map.panorama_name
      @panorama_hue = $game_map.panorama_hue
      unless @panorama.texture.nil?
        @panorama.texture.dispose
        @panorama.texture = nil
      end
      @panorama.texture = RPG::Cache.panorama(@panorama_name, @panorama_hue) unless @panorama_name.empty? # if @panorama_name != ""
      Graphics.frame_reset
    end

    if @fog_name != $game_map.fog_name # or @fog_hue != $game_map.fog_hue
      @fog_name = $game_map.fog_name
      @fog_hue = $game_map.fog_hue
      unless @fog.texture.nil?
        @fog.texture.dispose
        @fog.texture = nil
      end
      @fog.texture = RPG::Cache.fog(@fog_name, @fog_hue) unless @fog_name.empty? # if @fog_name != ""
      Graphics.frame_reset
    end

    @panorama.set_origin($game_map.display_x / 8, $game_map.display_y / 8)
    
    @fog.zoom = $game_map.fog_zoom / 100.0
    @fog.opacity = $game_map.fog_opacity.to_i
    @fog.blend_type = $game_map.fog_blend_type
    @fog.set_origin($game_map.display_x / 8, $game_map.display_y / 8)
    @fog.tone = $game_map.fog_tone
  end
end