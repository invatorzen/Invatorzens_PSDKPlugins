<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/invatorzen/PSDKPlugins">
    <img src="https://i.imgur.com/Q3LOc4v.png" alt="Logo" width="240" height="240">
  </a>

  <h3 align="center">Invatorzen's PSDKPlugins</h3>

  <p align="center">
    When I'm not gaming, working on my own project (Umbra) or working on mods, I like to make plugins. <br />
    So here they are. :D
    <br /> <br />
    <a href="https://eeveeexpo.com/members/781/#resources"><strong>You can find most of these on EeveeExpo as well »</strong></a>
    <br />
    <br />
    <a href="https://github.com/invatorzen/InvatorzenPSDKPlugins/issues">Report Bugs</a>
      
  [![ruby badge](https://forthebadge.com/images/badges/made-with-ruby.svg)](https://forthebadge.com)
  [![psdk badge](/svgs/made_for_psdk.svg)](https://gitlab.com/pokemonsdk/pokemonsdk)
  [![invatorzen badge](/svgs/made_by_invatorzen.svg)](https://github.com/invatorzen/Invatorzens_PSDKPlugins/tree/main)
  </p>
</div>


<!-- ABOUT THE PROJECT -->
## Quick intro
Hi! I'm Invatorzen, I've been working on Pokémon fan games since I was a kid but more seriously since I was in high-school. Starting with ROM Hacks and quickly getting overwhelmed as a kid I learned about 
fan games and heard about a kit called Pokémon Essentials. After working on my own project for a few years, I decided to start a new group project which is known as [Pokémon Umbra](https://twitter.com/PokemonUmbra). 
After another few years we decided to move to a newer kit called PSDK, which I have grown to learn and love and now make plugins for!
<br/><br/>
I'm very much an amateur dev, but I do enjoy making my own game and making these plugins in my free-time. I'm open to suggestions, but may never get to it if it's too demanding, out of my scope, or if I would never use it in my project.

<!-- Installing PSDK Plugins -->
## Repo Structure
You will find all my plugins hosted as separate folders in the <a href="/plugins/">plugins</a> folder.<br>
From there you can navigate to the plugin you want to download, and click the download button in the README.md!<br><br>
I also have a table of contents below:
  <ul>
    <li><a href="/plugins/AutoRun_Toggle/README.md">AutoRun_Toggle</a></li>
    <li><a href="/plugins/AutoSave/README.md">AutoSave</a></li>
    <li><a href="/plugins/Better_Rivals/README.md">Better_Rivals</a></li>
    <li><a href="/plugins/Better_Time_Switches/README.md">Better_Time_Switches</a></li>
    <li><a href="/plugins/Blank_Nicknames/README.md">Blank_Nicknames</a></li>
    <li><a href="/plugins/Easy_Outfits/README.md">Easy_Outfits</a></li>
    <li><a href="/plugins/Freeze_to_Frostbite/README.md">Freeze_to_Frostbite</a></li>
    <li><a href="/plugins/Gen9_HeldItem_Mechanic/README.md">Gen9_HeldItem_Mechanics</a></li>
    <li><a href="/plugins/OnScreen_Keyboard/README.md">OnScreen_Keyboard</a></li>
    <li><a href="/plugins/Physical_Special_Split/README.md">Physical/Special_Split_Switch</a></li>
  </ul>

  Anything without a README.md is the wild-west, and may still be getting a proper page.

<!-- Installing PSDK Plugins -->
## Installing PSDK Plugins
Installing PSDK plugins is made to be as easy as possible for users and is basically a drag and drop process.
<ol>
  <li>Download the psdkplug file you want directly from the repo or you can grab them all and download them as a zip.</li>
  <li>Drag the psdkplug files you want into your scripts folder.</li>
  <li>Run your project and the plugin manager will handle the rest!</li>
</ol>
<br/>
If any of the plugins have more instructions, it'd be indicated in their README.md!

<!-- Nb Support -->
## Non-Binary Support
This plugin does not require any extra steps to install, however do pay attention to the <a href="#proper-setup">proper setup!</a>

This plugin modifies how gender is handled in PSDK, which originally was using a switch. It is set through variable 495!
By default I believe each value represents:
<ol>
  <li>0 = Female</li>
  <li>1 = Male</li>
  <li>2 = Non-binary</li>
</ol>

If you'd like to change the variable, it's rather easy, make a monkey patch like:
```rb
module Yuki
  module Var
    GenderVar = 495 # Change this 
  end
end
```

### Proper Setup
<ul>
  <li>Overworld Sprites are set up just like before!</li>
  For example: gp.set_appearance_set('hero_01_cindy') with variable 495 = 1 would load the graphic "hero_01_cindy_f_walk"
  <li>Region map icons are simple!</li>
  Save an image in your graphics/interface/worldmap folder with the same name used for your character's overworld sprite!
  For example: "hero_01_white_f_walking" would be "hero_01_white_1" in the worldmap folder.
  <li>Setting up the bag is easy!</li>
  Just add another graphic to graphics/interface/bag called "bag_nb"!
</ul>
This is one of my first plugins, let me know if you find any bugs!

<!-- DayNightBGM -->
## DayNightBGM

<!-- Sub's balls -->
## Substitube's Balls

<!-- Consumables -->
## Gen 9 Consumables
