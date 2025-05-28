module Battle
  class Visual
    # Module holding all the Battle transition
    module Transition
      # Base class of all transitions
      class Base
        OK_TO_SHOW = false

        

        # Function that starts the Actor send animation
        def start_actor_send_animation
          log_debug('start_actor_send_animation')
          ya = Yuki::Animation
          animation = create_player_send_animation
          # Add message display in parallel
          animation.parallel_add(ya.send_command_to(self, :show_player_send_message))
          animation.play_before(ya.message_locked_animation)
          # Once everything is done, start the actor sending Pokemon animation
          if shadow_pokemon_out
            animation.play_before(ya.send_command_to(self, :start_shadow_message))
          else
            # Once everything is done, unlock everything
            animation.play_before(ya.send_command_to(@visual, :unlock))
                     .play_before(ya.send_command_to(self, :dispose))
          end
          animation.start
          @animations << animation
        end
  
        def start_shadow_message
          log_debug('start_shadow_animation')
          ya = Yuki::Animation
          animation = create_shadow_animation
          # Add message display in parallel
          animation.parallel_add(ya.send_command_to(self, :show_shadow_message))
          animation.play_before(ya.message_locked_animation)
          # Once everything is done, unlock everything
          animation.play_before(ya.send_command_to(@visual, :unlock))
                   .play_before(ya.send_command_to(self, :dispose))
          animation.start
          @animations << animation
        end
  
        # Get the actor Pokemon sprites
        # @return [Array<ShaderedSprite>]
        def shadow_pokemon_out
          sprites = $game_temp.vs_type.times.map do |i|
            @scene.visual.battler_sprite(1, i)
          end.compact.select(&:pokemon).select { |sprite| return sprite.pokemon.shadow? if sprite.pokemon.shadow? }
          return false
        end
  
        private

        # Function that create the animation of the enemy sending its Pokemon
        # @return [Yuki::Animation::TimedAnimation]
        def create_shadow_animation
          return Yuki::Animation.wait(0)
        end

        # Function that shows the message about player sending its Pokemon
        def show_shadow_message
          return unless shadow_pokemon_out
          @scene.message_window.stay_visible = false
          @scene.display_message(shadow_message)
        end

        # Return the third message shown
        # @return [String]
        def shadow_message
          return Message.see_shadow_pokemon_start
        end
      end
    end
  end
end