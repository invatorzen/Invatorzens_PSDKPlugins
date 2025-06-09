
<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/invatorzen/PSDKPlugins">
    <img src="https://i.imgur.com/Q3LOc4v.png" alt="Logo" width="240" height="240">
  </a>

  <h3 align="center">Easy Grottos</h3>

  <p align="center">
    <i>Easier at least!</i>
    <br /> <br />
    <a href="https://github.com/invatorzen/Invatorzens_PSDKPlugins/raw/refs/heads/main/plugins/Easy_Grottos/Easy_Grottos.psdkplug"><strong>Download</strong></a>
    <br />
    <br />
    <a href="https://github.com/invatorzen/InvatorzenPSDKPlugins/issues">Report Bugs</a>
      
  [![ruby badge](https://forthebadge.com/images/badges/made-with-ruby.svg)](https://forthebadge.com)
  [![psdk badge](/svgs/made_for_psdk.svg)](https://gitlab.com/pokemonsdk/pokemonsdk)
  [![invatorzen badge](/svgs/made_by_invatorzen.svg)](https://github.com/invatorzen/Invatorzens_PSDKPlugins/tree/main)
  </p>
</div>

## Description
Setting up Hidden Grottos are not difficult, but can be tedious to manage. So this plugin aimed to ease up on the amount of tedious tasks a dev has to do when creating a Hidden Grotto! It does so by:
* Creating a config file so users can modify the Hidden Items, Visible Items, Unique Items and Unique Pokemon offered by a Hidden Grotto
* Users will only need to add a few simple lines of code to event
* Automatically assign graphics of events
* Automatically handle the resetting of events

## Installation
1. Drop <a href="https://github.com/invatorzen/Invatorzens_PSDKPlugins/raw/refs/heads/main/plugins/Easy_Grottos/Easy_Grottos.psdkplug">HiddenGrottos.psdkplugin</a> in your scripts folder<br>
2. Run your game<br>
3. Go to ``data/configs/hidden_grotto.json`` and modify what you want

## How to use
### Event setup (in grotto)
#### First page
Create a new event and call this script command in it: ``grotto_gift``<br>
<details>
<summary>event example</summary>

![event example](https://i.imgur.com/JqPyxXr.png)<br>
</details>

### Second page 
Create a new page in that event, leave it blank but have a condition of self switch A
<details>
<summary>event example</summary>

![event example](https://i.imgur.com/Et0Lb4x.png)<br>
</details>

### Warp setup (entering grotto)
*Ensure you do the steps above before continuing.*

After you warp a player into the map for a Hidden Grotto call this in a script command:
````
enter_grotto(map_id, event_id)
set_grotto_sprite(map_id)
````
![event example](https://i.imgur.com/YbhO2Lr.png)<br>
*note: the map_id should be the map you're transferring to, and the event should be the event you want to change the sprite of*
## Config file
### visible_items & hidden_items
*note: visible items should make up 49% and hidden items should make up 50%*<br>
This is just an array that takes in two values - the percentage chance you want for this item, and then the item's DB symbol. We are using the default values here from Bulbapedia.

````
"visible_items": [
    [12.5, "poke_ball"],
    [5.0, "great_ball"],
    [2.0, "ultra_ball"],
    [6.25, "potion"],
    [2.5, "super_potion"],
    [1.0, "hyper_potion"],
    [6.25, "repel"],
    [2.5, "super_repel"],
    [1.0, "max_repel"]
  ],
  "hidden_items": [
    [6.25, "damp_mulch"],
    [6.25, "growth_mulch"],
    [6.25, "stable_mulch"],
    [6.25, "gooey_mulch"],
    [7.5, "tiny_mushroom"],
    [2.5, "big_mushroom"],
    [1.0, "red_shard"],
    [1.0, "green_shard"],
    [1.0, "yellow_shard"],
    [1.0, "blue_shard"],
    [0.25, "rare_candy"],
    [0.5, "pp_up"],
    [0.25, "pp_max"]
  ],
````
### unique_items
*note: always ensure your values add up to 100% per map.<br>(This also makes up the 1% missing in visible items!)*<br><br>
This is where things get *slightly* trickier. We introduce a map_id as a key for the array. It's the same thing as before, but now you have to specify the map you want to find these items on. I'll show off two examples, one with a singular item and one with multiple items:

````
  "unique_items": {
    "1": [
      [100, "master_ball"]
    ],
    "22": [
      [80, "metal_coat"],
      [20, "dragon_scale"]
    ]
  },
````

### unique_pokemon
*note: ensure your values add up to 100% per map.<br>*

Saved the trickiest for last. Since you are essentially creating a Pokemon object, you should be able to access any of the generate_from_hash properties. I have a few examples below.

````
  "unique_pokemon": {
    "22": [
      [25, {
        "id": "pichu",
        "level": 12,
        "no_shiny": true,
        "nature": "jolly",
        "stats": [31, 20, 15, 25, 18, 22],
        "bonus": [0, 20, 0, 10, 0, 5],
        "ability_index": 1,
        "moves": ["thunderbolt", "quick_attack", "iron_tail", "electro_ball"]
      }],
      [50, {
        "id": "pikachu",
        "level": 12,
        "shiny": true,
        "stats": [31, 20, 15, 25, 18, 22],
        "bonus": [0, 20, 0, 10, 0, 5]
      }],
      [25, {
        "id": "raichu",
        "level": 15,
        "no_shiny": true,
        "nature": "timid",
        "ability_index": 0,
        "moves": ["thunder", "thunder_wave", "agility", "quick_attack"]
      }]
    ],
    "45": [
      [100, {
        "id": "mewtwo",
        "level": 70
      }]
    ]
  }
````