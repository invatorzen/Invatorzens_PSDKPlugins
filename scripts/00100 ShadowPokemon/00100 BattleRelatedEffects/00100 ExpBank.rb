module BattleUI
  # UI element showing the exp distribution
  class ExpDistribution < UI::SpriteStack
    include UI
    include ExpDistributionAbstraction

    private

    # Function that create an exp animation for a specific pokemon
    # @param pokemon [PFM::PokemonBattler]
    # @param exp [Integer] total exp he should receive
    # @return [Array(Yuki::Animation::TimedAnimation, PFM::PokemonBattler), nil]
    alias old_anim create_exp_animation_for
    def create_exp_animation_for(pokemon, exp)
      exp = 0 if pokemon.original.shadow?
      return nil if pokemon.original.shadow?
      old_anim(pokemon, exp)
    end

    # UI element showing the basic information
    class PokemonInfo < UI::SpriteStack
      # Create a new Pokemon Info
      # @param viewport [Viewport]
      # @param index [Integer]
      # @param pokemon [PFM::Pokemon]
      # @param exp_received [Integer]
      def initialize(viewport, index, pokemon, exp_received)
        super(viewport, *COORDINATES[index])
        @exp_received = exp_received
        @leveling_up = false
        pokemon.banked_exp += exp_received if pokemon.shadow?
        @exp_received = 0 if pokemon.shadow?
        puts "pokemon.banked_exp = #{pokemon.banked_exp} now exp_received: #{exp_received}" if pokemon.shadow?
        pokemon.exp_rate = 0 if pokemon.shadow?
        create_sprites
        create_animation
        self.data = pokemon
      end
    end
  end
end