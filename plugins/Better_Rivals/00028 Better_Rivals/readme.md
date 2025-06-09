# Better Rivals

This was mostly a learning experieince for me, however if people are interested in this and have suggestions I may implement them.
The goal of this was to make rivals easier to set up.

## Current features
* New commands:
  - name_rival - Pops open a name input window with a specified graphic, updates their name, graphic, and game_actor_index
  - create_rival - No input from a user, just creates a new rival object
  - set_rival_sprite - Sets an event to the rival's graphic
  - set_rival_starter - Sets the rival's starter to a specified db symbol
  - set_rival_team_from_trainer - Set's the rivals team to a specified trainer's from Studio
* You can now set a $game_actor's image by using $game_actors[index].character_name= (this is because rivals are $game_actors)
* Two new global variables: $rival and $rivals (initialized on new game)
* Adds a scheduler task to assign a rival to already existing saves

## Future plans
* Set up a new battle mode that's used specifically on calls for a rival battle

## Use cases
* Now users can name their rivals, yay!
* Not needing to store the name in a text variable that inevitably gets reset, you can call $rivals[index].name
* Checking their starter for some reason
* Quickly assign an event's graphic to the rival's