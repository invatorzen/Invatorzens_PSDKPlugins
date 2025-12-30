module DebugFeatures
  # Prevent wild encounters when holding Ctrl in debug mode
  module GamePlayerLogic    
    # Prevents wild encounters if the player is in debug mode and holding a Control key.
    # @param last_moving [Boolean] whether the player was moving in the last frame.
    def update_check_trigger(last_moving)
      if last_moving && !check_event_trigger_here([1, 2]) && !((debug? || $TEST) && (Input::Keyboard.press?(Input::Keyboard::LControl) || Input::Keyboard.press?(Input::Keyboard::RControl)))
        $wild_battle.update_encounter_count
      end
      super
    end
  end

  # Prepend to FleeHandler to guarantee escape when holding Ctrl
  module FleeHandlerDebug
    # Overrides the flee attempt to guarantee success if holding a Control key in debug mode.
    # @param index [Integer] the actor index attempting to flee.
    # @return [Symbol] :success if debug flee is triggered, otherwise result of super.
    def attempt(index)
      if (debug? || $TEST) && (Input::Keyboard.press?(Input::Keyboard::LControl) || Input::Keyboard.press?(Input::Keyboard::RControl))
        @scene.display_message_and_wait('Debug: Guaranteed escape!')
        return :success
      end
      super
    end
  end

  # Prepend to CatchHandler to guarantee catch when holding Ctrl
  module CatchHandlerDebug
    # Overrides the catch rate to guarantee a catch if holding a Control key in debug mode.
    # @param pokemon [PFM::Pokemon] the pokemon being caught.
    # @param ball [PFM::Item] the ball used.
    # @return [Integer] 1000 if debug catch is triggered, otherwise result of super.
    def pokemon_catch_rate(pokemon, ball)
      if (debug? || $TEST) && (Input::Keyboard.press?(Input::Keyboard::LControl) || Input::Keyboard.press?(Input::Keyboard::RControl))
        return 1000
      end
      super
    end
  end
end

Game_Player.prepend(DebugFeatures::GamePlayerLogic)
Battle::Logic::FleeHandler.prepend(DebugFeatures::FleeHandlerDebug)
Battle::Logic::CatchHandler.prepend(DebugFeatures::CatchHandlerDebug)


