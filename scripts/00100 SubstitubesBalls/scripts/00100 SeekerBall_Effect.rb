# Can catch Pokémon that are semi-invulnerable
# Concept by Substitube, code by Invatorzen
module Battle
  class Logic
    class CatchHandler < ChangeHandlerBase
      private
      Hooks.register(Battle::Logic::CatchHandler, :ball_blocked, 'Check if target is out of reach') do |hook_binding|
        if hook_binding[:target].effects.has?(&:out_of_reach?) && hook_binding[:ball].db_symbol != :seeker_ball
          @scene.display_message_and_wait(parse_text(18, 290))
          force_return(false)
        end
      end
    end
  end
end