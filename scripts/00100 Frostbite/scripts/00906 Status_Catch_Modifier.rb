module Battle
  class Logic
    # Handler responsive of answering properly Pokemon catching requests
    class CatchHandler < ChangeHandlerBase
      STATUS_MODIFIER[:frostbite] = 1.5
    end
  end
end