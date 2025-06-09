# This is an optional script that is disabled by default. You should move this to a new folder like "{YourProject}/scripts/00001 PluginPatches/" and remove the "-" from the filename to enable it.
# Changing Frosbite Damage to 1/16
module Battle
  module Effects
    class Status
      class Frostbite < Status
        private

        def frostbite_effect
          (target.max_hp / 16).clamp(1, Float::INFINITY)
        end
      end
    end
  end
end
