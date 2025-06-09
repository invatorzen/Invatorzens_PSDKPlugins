<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/invatorzen/PSDKPlugins">
    <img src="https://i.imgur.com/Q3LOc4v.png" alt="Logo" width="240" height="240">
  </a>

  <h3 align="center">Better Rivals</h3>

  <p align="center">
    <i>Makes setting up rival events and battles a little bit easier!</i>
    <br /> <br />
    <a href="https://github.com/invatorzen/Invatorzens_PSDKPlugins/raw/refs/heads/main/plugins/Better_Rivals/Better_Rivals.psdkplug"><strong>Download</strong></a>
    <br />
    <br />
    <a href="https://github.com/invatorzen/InvatorzenPSDKPlugins/issues">Report Bugs</a>
      
  [![ruby badge](https://forthebadge.com/images/badges/made-with-ruby.svg)](https://forthebadge.com)
  [![psdk badge](/svgs/made_for_psdk.svg)](https://gitlab.com/pokemonsdk/pokemonsdk)
  [![invatorzen badge](/svgs/made_by_invatorzen.svg)](https://github.com/invatorzen/Invatorzens_PSDKPlugins/tree/main)
  </p>
</div>

## Descrption
I'll be honest - this is a bit of a nothing burger currently. I can't provide much use case.

This was mostly a learning experieince for me, however if people are interested in this and have suggestions I may implement them!<br>
The goal of this was to make rivals easier to set up by providing:
* New commands:
  - name_rival - Pops open a name input window with a specified graphic, updates their name, graphic, and game_actor_index
  - create_rival - No input from a user, just creates a new rival object
  - set_rival_sprite - Sets an event to the rival's graphic
  - set_rival_starter - Sets the rival's starter to a specified db symbol
  - set_rival_team_from_trainer - Set's the rivals team to a specified trainer's from Studio
* You can now set a $game_actor's image by using $game_actors[index].character_name= (this is because rivals are $game_actors)
* Two new global variables: $rival and $rivals (initialized on new game)
* Adds a scheduler task to assign a rival to already existing saves



## Installation
<ol>
  <li>Download <a href="https://github.com/invatorzen/Invatorzens_PSDKPlugins/raw/refs/heads/main/plugins/Better_Rivals/Better_Rivals.psdkplug">Better_Rivals.psdkplug</a> and put it in your game's scripts folder</li>
  <li>Launch the game</li>
</ol>