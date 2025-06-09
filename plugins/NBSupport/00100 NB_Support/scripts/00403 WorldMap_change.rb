# Makes the player icon to be based on the gender variable (0 = female, 1 = male, 2 = nb)
# Looks for "graphics/interface/worldmap/charactername_gendernum.png"
# Credits: Invatorzen
module GamePlay
  class WorldMap
  # Create the player marker
    def create_player_sprite
      @marker_player = Sprite::WithColor.new(@viewport_map_markers)
      player_icon = 'worldmap/player_icons/' \
        "#{$game_player.charset_base}"
    #If your icon isn't loading, you can uncomment under this and look in the console to see the graphic it's looking for
    #puts "#{player_icon}"
      player_icon = 'worldmap/player_icons/default' unless RPG::Cache.interface_exist?(player_icon)
      @marker_player.set_bitmap(player_icon, :interface)
      @marker_player.ox = @marker_player.src_rect.width / 2 - TileSize / 2
      @marker_player.oy = @marker_player.src_rect.height / 2 - TileSize / 2
    end
  end
end