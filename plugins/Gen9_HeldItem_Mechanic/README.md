<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/invatorzen/PSDKPlugins">
    <img src="https://i.imgur.com/Q3LOc4v.png" alt="Logo" width="240" height="240">
  </a>

  <h3 align="center">Gen 9 Held Item Mehcanics</h3>

  <p align="center">
    <i>With a flip of a switch, held items no longer get consumed!</i>
    <br /> <br />
    <a href="https://github.com/invatorzen/Invatorzens_PSDKPlugins/raw/refs/heads/main/plugins/Gen9_HeldItem_Mechanic/Gen9_HeldItem_Mechanics.psdkplug"><strong>Download</strong></a>
    <br />
    <br />
    <a href="https://github.com/invatorzen/InvatorzenPSDKPlugins/issues">Report Bugs</a>
      
  [![ruby badge](https://forthebadge.com/images/badges/made-with-ruby.svg)](https://forthebadge.com)
  [![psdk badge](/svgs/made_for_psdk.svg)](https://gitlab.com/pokemonsdk/pokemonsdk)
  [![invatorzen badge](/svgs/made_by_invatorzen.svg)](https://github.com/invatorzen/Invatorzens_PSDKPlugins/tree/main)
  </p>
</div>

## Descrption
I prefer how Held Items were handled in Scarlet and Violet, where you don't lose them after a battle! I feel like it makes things like Focus Sash actually usable during the main-game instead of only PVP!

Now make your trainers harder. ;D

This plugin will effect these items/moves:
* Air Balloon
* Attract/Mental Herb (Mental herb is handled through the attract move's code.)
* Eject Button
* **Eject Pack**
* Focus Sash
* Red Card
* **Room Service**
* **Throat Spray**
* White Herb

*Bold are new items w/ new code*

## Installation
<ol>
  <li>Download <a href="https://github.com/invatorzen/Invatorzens_PSDKPlugins/raw/refs/heads/main/plugins/Gen9_HeldItem_Mechanic/Gen9_HeldItem_Mechanics.psdkplug">Gen9_HeldItem_Mechanics.psdkplug</a> and put it in your game's scripts folder</li>
  <li>Launch the game</li>
</ol>

Enable ``$game_switches[Yuki::Sw::Gen9HeldItems]`` for the effect!

## Personal note for next update:
* Check if mental herb is handled differently now
* Check if all effects are already in PSDK
* Include icons in plugin resources
* Move text to separate CSV and target it