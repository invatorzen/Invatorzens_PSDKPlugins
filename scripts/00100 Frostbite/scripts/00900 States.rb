module Configs
    class States
      alias old_initialize initialize
      def initialize
        old_initialize
        @ids[:frostbite] = 10
      end
    end
  end