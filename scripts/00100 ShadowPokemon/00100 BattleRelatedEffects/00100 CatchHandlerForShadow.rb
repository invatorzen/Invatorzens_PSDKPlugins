# Includes original hooks because we needed to remove the old one that allowed the rocket ball to work

module Battle
  class Logic
    # Handler responsive of answering properly Pokemon catching requests
    class CatchHandler < ChangeHandlerBase
    
      include Hooks

      # Allows the player to steal a trainer pokemon when:
      # * they are a shadow pokemon when the specific switch is enabled or 
      # * they are using the rocket ball (built in item functionality)

      SNAG_SWITCH = 128

      Hooks.register(Battle::Logic::CatchHandler, :ball_blocked, 'Check if the battle is a Trainer battle') do |hook_binding|
        if logic.battle_info.trainer_battle?
          unless (hook_binding[:target].shadow? && $game_switches[SNAG_SWITCH]) || hook_binding[:ball].db_symbol == :rocket_ball
            # @scene.visual.ball_deflect_animation(target, ball)
            @scene.display_message_and_wait(parse_text(18, 69)) #TODO Write the text for a Pokémon owned by a Trainer that can't be caught
            force_return(false)
          end
        end
      end
      Hooks.register(Battle::Logic::CatchHandler, :ball_blocked, 'Check if the initial rareness of the Pokemon is 0') do |hook_binding|
        if hook_binding[:target].rareness == 0
          # @scene.visual.ball_deflect_animation(target, ball)
          @scene.display_message_and_wait(parse_text(18, 69)) #TODO Write the text for a Pokémon with rareness 0
          force_return(false)
        end
      end

      Hooks.register(Battle::Logic::CatchHandler, :ball_blocked, 'Check if catching is forbidden in this battle') do |_hook_binding|
        if $game_switches[Yuki::Sw::BT_NoCatch]
          # @scene.visual.ball_deflect_animation(target, ball)
          @scene.display_message_and_wait(parse_text(18, 69)) #TODO Write the text for forbidding catching in this battle
          force_return(false)
        end
      end
    end
  end
end
