# Prevents statuses by applying confusion to the user
# Concept by Substitube
# Code by Invatorzen
module Battle
  module Effects
    class Item
      class DunceCap < Item
        def on_status_prevention(handler, status, target, launcher, skill)
          return if target != self.target
          return if status == :confusion
          return unless handler.logic.status_change_handler.status_appliable?(:confusion, target)
          return handler.prevent_change do
            handler.scene.visual.show_item(target)
            handler.logic.status_change_handler.status_change(:confusion, target)
            handler.scene.display_message_and_wait(parse_text_with_pokemon(999, 30, target))
          end
        end
      end
      register(:dunce_cap, DunceCap)
    end
  end
end