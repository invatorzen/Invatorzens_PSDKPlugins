
<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/invatorzen/PSDKPlugins">
    <img src="https://i.imgur.com/Q3LOc4v.png" alt="Logo" width="240" height="240">
  </a>

  <h3 align="center">Save Checks</h3>

  <p align="center">
    <i>Allows the user to check data from other saves!</i>
    <br /> <br />
    <a href="https://github.com/invatorzen/Invatorzens_PSDKPlugins/raw/refs/heads/main/plugins/Save_Checks/Save_Checks.psdkplug"><strong>Download</strong></a>
    <br />
    <br />
    <a href="https://github.com/invatorzen/InvatorzenPSDKPlugins/issues">Report Bugs</a>
      
  [![ruby badge](https://forthebadge.com/images/badges/made-with-ruby.svg)](https://forthebadge.com)
  [![psdk badge](/svgs/made_for_psdk.svg)](https://gitlab.com/pokemonsdk/pokemonsdk)
  [![invatorzen badge](/svgs/made_by_invatorzen.svg)](https://github.com/invatorzen/Invatorzens_PSDKPlugins/tree/main)
  </p>
</div>

## Installation
<ol>
  <li>Download <a href="https://github.com/invatorzen/Invatorzens_PSDKPlugins/raw/refs/heads/main/plugins/Save_Checks/Save_Checks.psdkplug">Save_Checks.psdkplug</a> and put it in your game's scripts folder</li>
  <li>Launch the game</li>
</ol>

## How to use
You can call any of the new methods added by this plugin like:
``GamePlay::Load.new.{method}``

For example: ``GamePlay::Load.new.check_switch(1, 0)`` would return the value of my first save and the switch with the index of 0.

### New methods
* check_switch(save_slot, switch_id) - returns the value of the switch
* check_var(save_slot, var_id) - returns the value of the variable
* check_actors(save_slot, index) - returns an actor (creature) from the specific save and index
* check_map_id(save_slot) - returns the map_id the player is on in that save
* check_player_position(save_slot) - returns the x, y, z, and direction the player is facing in that save
* nuzlocke_enabled?(save_slot) - returns if they have nuzlocke_enabled? in that save
* check_user_data(save_slot, key) - returns the value from ``$user_data[:key]`` in that save