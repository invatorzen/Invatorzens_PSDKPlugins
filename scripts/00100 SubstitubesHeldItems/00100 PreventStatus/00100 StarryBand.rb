module Battle
  module Effects
    class Item
      class StarryBand < Item
        def on_status_prevention(handler, status, target, launcher, skill)
          return if target != @target
          return unless status == :confusion
          return handler.prevent_change do
            handler.scene.visual.show_item(target)
            handler.scene.display_message_and_wait(parse_text_with_pokemon(999, 33, target))
          end
        end
      end
      register(:starry_band, StarryBand)
    end
  end
end