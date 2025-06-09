<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/invatorzen/PSDKPlugins">
    <img src="https://i.imgur.com/Q3LOc4v.png" alt="Logo" width="240" height="240">
  </a>

  <h3 align="center">Easy Outfits</h3>

  <p align="center">
    <i>Easily set up and apply outfits with a few commands</i>
    <br /> <br />
    <a href="/plugins/Easy_Outfits/Easy Outfits.psdkplug"><strong>Download</strong></a>
    <br />
    <br />
    <a href="https://github.com/invatorzen/InvatorzenPSDKPlugins/issues">Report Bugs</a>
      
  [![ruby badge](https://forthebadge.com/images/badges/made-with-ruby.svg)](https://forthebadge.com)
  [![psdk badge](/svgs/made_for_psdk.svg)](https://gitlab.com/pokemonsdk/pokemonsdk)
  [![invatorzen badge](/svgs/made_by_invatorzen.svg)](https://github.com/invatorzen/Invatorzens_PSDKPlugins/tree/main)
  </p>
</div>

## Installation
1.) Back up or delete `"pockets_active.png"` and `"pockets_inactive.png"` in `"graphics/interface/bag"`<br>
2.) Download <a href="/plugins/Easy_Outfits/Easy Outfits.psdkplug">Easy_Outfits.psdkplug</a> and place in your scripts folder and run the game<br>
3.) Close the game<br>
4.) Ensure that the graphics in step 1 are there now, after closing the game<br>
5.) Ensure 106969.csv is in `"Data/Text/Dialogs"` folder, add text translation for "Outfits" and "Cancel"

## How to use
*Currently with how Studio is set up, it doesn't like custom item sockets - but it does still work! It's just a little tedious to set up.*

### How to set up an item to a custom socket [(Preview)](https://i.imgur.com/wr8DXrp.mp4)
* Create a new item and assign it a generic item slot
* Go to `"data/studio/items"` and find the json file for your new item
* Change the socket value to `outfit_bag_slot` in `"Data/configs/plugins/outfit_config.json"` (`9` by default)
* Save the json file
* Reopen Studio, check your item - you'll see `[~9]` as the item socket value.
* **OPTIONAL**: Go to ``Data/Text/Dialogs/100015.csv`` and change ``[~9]`` to "Outfits" (or whatever you want displayed in Studio)

### How to set up an outfit
*There are two default ones as examples, but:*
* Go to your ``Data/configs/plugins/outfit_config.json`` and modify your outfits hash
* The key should be the db symbol of the item as a string (remove the `:` from the symbol)
* The matching array will have the walking sprite as the first value, followed by the backsprite
* **OPTIONAL** `true` or ``false`` after the backsprite's string represents whether it's a male or female sprite, and will set the gender if there is a value. (`True` = `female`, `false` = `male`)

### How to use in an event
* Create a conditional branch checking: ``$bag.is_socket_empty?(Configs.outfit_config.outfit_bag_slot)``
* If true, do nothing. (Or whatever you want.)
* If false, use the command ``show_outfits`` and show a message
* After the message use ``handle_outfit_change`` and you're done!