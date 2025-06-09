<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/invatorzen/PSDKPlugins">
    <img src="https://i.imgur.com/Q3LOc4v.png" alt="Logo" width="240" height="240">
  </a>

  <h3 align="center">Physical/Special Split Switch</h3>

  <p align="center">
    <i>Flip a switch and a move's type will decide it is special or physical!</i>
    <br /> <br />
    <a href="/plugins/Physical_Special_Split/Physical_Special_Split.psdkplug"><strong>Download</strong></a>
    <br />
    <br />
    <a href="https://github.com/invatorzen/InvatorzenPSDKPlugins/issues">Report Bugs</a>
      
  [![ruby badge](https://forthebadge.com/images/badges/made-with-ruby.svg)](https://forthebadge.com)
  [![psdk badge](/svgs/made_for_psdk.svg)](https://gitlab.com/pokemonsdk/pokemonsdk)
  [![invatorzen badge](/svgs/made_by_invatorzen.svg)](https://github.com/invatorzen/Invatorzens_PSDKPlugins/tree/main)
  </p>
</div>

## Descrption
If you want to revert the special/physical split! Now types decide if a move is special or physical!

By default it uses these settings, but you can always change them in your ``Data/configs/plugins/physpec_split_config.json``:

```json
{
  "klass": "Configs::Project::PhysSpecSplitConfig",
  "physical_types": [
    "normal",
    "fighting",
    "flying",
    "poison",
    "ground",
    "rock",
    "bug",
    "ghost",
    "steel"
  ],
  "special_types": [
    "fire",
    "water",
    "grass",
    "electric",
    "psychic",
    "ice",
    "dragon",
    "dark",
    "fairy"
  ]
}
```

*Note: Fairy is considered special type by default!*

## Installation
<ol>
  <li>Download <a href="/plugins/Physical_Special_Split/Physical_Special_Split.psdkplug">Physical_Special_Split.psdkplug</a> and put it in your game's scripts folder</li>
  <li>Launch the game</li>
</ol>

If you want to disable the physical/special split, enable: ``$game_switches[Inva::Sw::PHY_SPE_SPLIT_DISABLED]``