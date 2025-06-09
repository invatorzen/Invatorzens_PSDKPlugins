<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/invatorzen/PSDKPlugins">
    <img src="https://i.imgur.com/Q3LOc4v.png" alt="Logo" width="240" height="240">
  </a>

  <h3 align="center">Freeze to Frostbite</h3>

  <p align="center">
    <i>Converts freeze to frostbite from Legends Arceus!</i>
    <br /> <br />
    <a href="https://github.com/invatorzen/Invatorzens_PSDKPlugins/raw/refs/heads/main/plugins/Freeze_to_Frostbite/Freeze_To_Frostbite.psdkplug"><strong>Download</strong></a>
    <br />
    <br />
    <a href="https://github.com/invatorzen/InvatorzenPSDKPlugins/issues">Report Bugs</a>
      
  [![ruby badge](https://forthebadge.com/images/badges/made-with-ruby.svg)](https://forthebadge.com)
  [![psdk badge](/svgs/made_for_psdk.svg)](https://gitlab.com/pokemonsdk/pokemonsdk)
  [![invatorzen badge](/svgs/made_by_invatorzen.svg)](https://github.com/invatorzen/Invatorzens_PSDKPlugins/tree/main)
  </p>
</div>

<!-- Frostbite -->
## Description
This plugin adds in a new status that's basically burn but reduces your special damage dealt. It procs guts, and can be prevented by magma armor. By default hail will make you 3x more likely to inflict frostbite, 
and frostbite does 1/8th the users MAX HP as damage per turn. (This is how burn works in PSDK.)

## Installation
<ol>
  <li>Make a backup or delete your "statusen.png" file so it replaces the frozen icon!</li>
  <li>Download <a href="https://github.com/invatorzen/Invatorzens_PSDKPlugins/raw/refs/heads/main/plugins/Freeze_to_Frostbite/Freeze_To_Frostbite.psdkplug">Freeze_To_Frostbite.psdkplug</a> and put it in your game's scripts folder</li>
  <li>Launch the game</li>
</ol>

## Monkey Patch
If you want to change the damage dealt or the effect, make a monkey patch. Something like:
```rb
module Battle
  module Effects
    class Status
      class Frostbite < Status
        private
        def frostbite_effect
          return (target.max_hp / 16).clamp(1, Float::INFINITY) # Change this
        end
      end
    end
  end
end
```
And you're good to go! To test if the status is working, give your first mon frostbite by typing ``$actors[0].status_frostbite`` and going into battle by typing ``S.MI.call_battle_wild(:bulbasaur, 5)`` in the cmd prompts.