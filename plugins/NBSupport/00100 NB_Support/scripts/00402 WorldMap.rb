module GamePlay
  class WorldMap
    # Patch module that selects the world map player marker from the charset base,
    # falling back to "worldmap/player_icons/default" if the asset is missing.
    module NBSupportPlayerMarker
      # Override of {GamePlay::WorldMap#create_player_sprite} that picks the marker icon
      # from the charset base with a default fallback
      # @return [void]
      def create_player_sprite
        @marker_player = Sprite::WithColor.new(@viewport_map_markers)
        player_icon = "worldmap/player_icons/#{$game_player.charset_base}"
        player_icon = 'worldmap/player_icons/default' unless RPG::Cache.interface_exist?(player_icon)
        @marker_player.set_bitmap(player_icon, :interface)
        @marker_player.ox = @marker_player.src_rect.width / 2 - TileSize / 2
        @marker_player.oy = @marker_player.src_rect.height / 2 - TileSize / 2
      end
    end
    prepend NBSupportPlayerMarker
  end
end
