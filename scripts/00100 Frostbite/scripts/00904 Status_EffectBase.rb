module Battle
  module Effects
    class Status < EffectBase
      # Tell if the status effect is frostbitten
      # @return [Boolean]
      def frostbite?
        @status == :frostbite
      end
    end
  end
end