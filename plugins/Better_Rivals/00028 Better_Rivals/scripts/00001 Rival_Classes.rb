module PFM
  # Rival data
  class Rival
    # Manages the rivals name
    # @returns [String]
    attr_accessor :name

    # Manages the game_actors_index for this rival
    # @returns [Index]
    attr_accessor :game_actors_index

    # Manages this rivals overworld sprite
    # @returns [String]
    attr_accessor :graphic

    # Manages this rivals starter pokemon
    attr_accessor :starter

    # Manages this rivals team
    # @return [Array<PFM::PokemonBattler>]
    attr_accessor :team

    # Manages this rivals battle bgm
    # @returns [String]
    attr_accessor :battle_bgm

    # Manages this rivals trainer class
    # @returns [String]
    attr_accessor :trainer_class

    # Manages this rivals victory text
    # @returns [String]
    attr_accessor :victory_text

    # Manages this rivals defeat text
    # @returns [String]
    attr_accessor :defeat_text

    # Manages this rivals small battle image
    # @returns [String]
    attr_accessor :artwork_small

    # Manages this rivals large battle image
    # @returns [String]
    attr_accessor :artwork_full

    # Manages this rivals base money
    # @returns [Integer]
    attr_accessor :base_money

    # Manages this rivals bag items
    # @return [Array<Hash>]
    attr_accessor :bag_items

    # Manages this rivals "battle event" (found in Data/Events/Battle/)
    attr_accessor :battle_id

    # Manages this rivals ai level
    attr_accessor :ai_level

    attr_accessor :defeat_bgm, :victory_bgm

    # Initializes a rival
    def initialize
      @name = 'Rival1'
      @game_actors_index = 7
      @graphic = 'npc_blue'
      @starter = :pikachu
      @battle_bgm = 'xy_trainer_battle.ogg'
      @defeat_bgm = ''
      @victory_bgm = ''
      @trainer_class = 'Rival'
      @artwork_small = '048_sma'
      @artwork_full = '048_big'
      @ai_level = 7
      @victory_text = ''
      @defeat_text = ''
      @base_money = 100
      @bag_items = []
      @battle_id = 0
      @team = nil
    end

    # Returns the rival's name. If a CSV it should show translated texts.
    def name
      case @name
      when String
        @name
      when Array
        text_get(@name[0], @name[1])
      else
        log_error('No name exists for this rival.')
        false
      end
    end

    # Allows users to set the name of the rival either with a CSV or string
    # @param name [String, Array] The name of the rival.
    # @return [Boolean] if the name was set
    def name=(name)
      case name
      when String
        # Directly set the trainer class to the provided string
        @name = name
      when Array
        # If an array is provided, use text_get to fetch the trainer class name
        @name = name.size == 2 ? name : log_error("Error. name.size != 2 in name= (name.size == #{name.size})")
      else
        log_error('Issue when assigning trainer class.')
        false
      end
    end

    # Returns the trainer class. If a CSV it should show translated texts.
    def trainer_class
      case @trainer_class
      when String
        @trainer_class
      when Array
        text_get(@trainer_class[0], @trainer_class[1])
      else
        log_error('No trainer class exists for this rival.')
        false
      end
    end

    # Allows users to set the trainer class of the rival either with a CSV or string
    # @param name [String, Array] The trainer class name.
    # @return [Boolean] if the trainer class was set
    def trainer_class=(name)
      case name
      when String
        # Directly set the trainer class to the provided string
        @trainer_class = name
      when Array
        # If an array is provided, use text_get to fetch the trainer class name
        @trainer_class = name.size == 2 ? name : log_error("Error. name.size != 2 in trainer_class= (name.size == #{name.size})")
      else
        log_error('Issue when assigning trainer class.')
        false
      end
    end

    # Gets the defeat text of the rival
    def defeat_text
      case @defeat_text
      when String
        @defeat_text
      when Array
        text_get(@defeat_text[0], @defeat_text[1])
      else
        log_error('No defeat_text exists for this rival.')
        false
      end
    end

    # Sets the defeat text of the rival
    def defeat_text=(text)
      case text
      when String
        # Directly set the trainer class to the provided string
        @defeat_text = text
      when Array
        # If an array is provided, use text_get to fetch the trainer class name
        @defeat_text = text.size == 2 ? text : log_error("Error. text.size != 2 in defeat_text= (text.size == #{text.size})")
      else
        log_error('Issue when assigning defeat_text.')
        false
      end
    end

    # Gets the victory text of the rival
    def victory_text
      case @victory_text
      when String
        @victory_text
      when Array
        text_get(@victory_text[0], @victory_text[1])
      else
        log_error('No victory_text exists for this rival.')
        false
      end
    end

    # Sets the victory text of the rival
    def victory_text=(text)
      case text
      when String
        # Directly set the trainer class to the provided string
        @victory_text = text
      when Array
        # If an array is provided, use text_get to fetch the trainer class name
        @victory_text = text.size == 2 ? text : log_error("Error. text.size != 2 in victory_text= (text.size == #{text.size})")
      else
        log_error('Issue when assigning victory_text.')
        false
      end
    end
  end

  # Array of your rivals (for those using more than one)
  class Rivals
    # Manages your rivals
    attr_accessor :rivals

    # Initialize empty array to hold Rival objects
    def initialize
      @rivals = []
    end

    # Allows access to rivals
    def [](index)
      @rivals[index]
    end

    # Add a new rival to the collection
    # @param rival [PFM::Rival] a rival object
    def add_rival(rival)
      @rivals << rival
    end

    # Create a rival at a specific index with customizable properties
    def create_rival(index, name: 'Blue', graphic: 'npc_blue', game_actors_index: 6, battle_bgm: nil, starter: nil,
                     team: nil)
      rival = Rival.new
      rival.name = name
      rival.graphic = graphic
      rival.game_actors_index = game_actors_index
      rival.starter = starter unless starter.nil?
      rival.team = team unless team.nil?
      rival.battle_bgm = battle_bgm unless battle_bgm.nil?

      @rivals[index] = rival
    end

    # Remove a rival from the collection by name
    def remove_rival(name)
      @rivals.reject! { |rival| rival.name == name }
    end

    # Find a rival by name and return their index
    # @param name [String] the name of the rival to look for
    def find_rival(name)
      @rivals.each_with_index do |rival, index|
        return index if rival.name == name
      end
      log_error("No rival found with name: #{name}")
      false
    end

    # List all rivals by their name
    def list_rivals
      @rivals.map(&:name)
    end
  end

  class GameState
    # Information about the rival
    attr_accessor :rival
    # Information about the rivals
    attr_accessor :rivals_manager

    # Initialize rivals when the player is intialized
    on_player_initialize(:rivals) do
      @rival ||= PFM::Rival.new # Initialize the rival instance here
      @rivals_manager ||= PFM::Rivals.new # Initialize the Rivals manager
      @rivals_manager.add_rival(@rival) # Add the first rival to the manager
    end

    # Creates global variables for rivals
    on_expand_global_variables(:rivals) do
      $rival ||= @rival # Set the global rival variable
      $rivals ||= @rivals_manager # Set the global rivals variable to the list of rivals
    end
  end
end
