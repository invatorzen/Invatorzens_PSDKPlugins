
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

Note that it does not work entirely like official Hidden Grottos. For example:
* The odds of getting a Hidden Item, Visible Item, Unique Item, and creature are the same as official games.
* So that means 39% chance you will have a visible item, 1% it's a unique (and visible) item, 40% it's a hidden item, and 20% chance it's a creature.
* However, the odds of those items are weighted ***separately*** after that. Meaning you'll have the best chance of understanding your odds if each ***individual*** table adds up to 100%.


## Installation
1. Drop <a href="https://github.com/invatorzen/Invatorzens_PSDKPlugins/raw/refs/heads/main/plugins/Easy_Grottos/Easy_Grottos.psdkplug">HiddenGrottos.psdkplugin</a> in your scripts folder<br>
2. Run your game<br>
3. Go to ``data/configs/hidden_grotto.json`` and [modify what you want](https://github.com/invatorzen/Invatorzens_PSDKPlugins/blob/main/plugins/Easy_Grottos/README.md#config-file)

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
This is just an array that takes in two values - the percentage chance you want for this item, and then the item's DB symbol. We are using the default values here from Bulbapedia, however we had to normalize the weights. 

Notice that ``visible_items`` adds up to 100%, and so does ``hidden_items`` - this is so I have an easier time understanding the odds of that item appearing for that category.

````
  "visible_items": [
    [32.05, "poke_ball"],
    [12.82, "great_ball"],
    [5.13, "ultra_ball"],
    [16.03, "potion"],
    [6.41, "super_potion"],
    [2.56, "hyper_potion"],
    [16.03, "repel"],
    [6.41, "super_repel"],
    [2.56, "max_repel"]
  ],
  "hidden_items": [
    [15.63, "damp_mulch"],
    [15.63, "growth_mulch"],
    [15.63, "stable_mulch"],
    [15.63, "gooey_mulch"],
    [18.75, "tiny_mushroom"],
    [6.25, "big_mushroom"],
    [2.50, "red_shard"],
    [2.50, "green_shard"],
    [2.50, "yellow_shard"],
    [2.50, "blue_shard"],
    [0.63, "rare_candy"],
    [1.25, "pp_up"],
    [0.63, "pp_max"]
  ],
````
### unique_items
This is where things get *slightly* trickier. We introduce a map_id as a key for the array. It's the same thing as before, but now you have to specify the map you want to find these items on. I'll show off two examples, one with a singular item and one with multiple items:

For this example we check for map_id ``1`` and have a ``100``% chance of a master ball if we have a ``:unique_item`` Hidden Grotto.

*note: it's easier to understand if you ensure your values add up to 100% per map.*<br>
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
Saved the trickiest for last. Since you are essentially creating a Pokemon object, you should be able to access any of the generate_from_hash properties. I have a few examples below.

For the first example, we check for the map_id ``22`` and gives pichu a ``25``% chance, pikachu a ``50``% chance and raichu a ``25``% chance of being selected for a ``unique_pokemon`` Hidden Grotto.

*note: I'm saying it again, if your values are 100% you have an easier time knowing what will appear when it is this grotto type.<br>*

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