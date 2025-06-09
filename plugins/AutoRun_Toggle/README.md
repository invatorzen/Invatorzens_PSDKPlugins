<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/invatorzen/PSDKPlugins">
    <img src="https://i.imgur.com/Q3LOc4v.png" alt="Logo" width="240" height="240">
  </a>

  <h3 align="center">Auto Run Toggle</h3>

  <p align="center">
    <i>Allows the user to toggle-run! <br>When toggled, you will run by default and walk by holding "B"!</i>
    <br /> <br />
    <a href="/plugins/AutoRun_Toggle/AutoRunOption.psdkplug"><strong>Download</strong></a>
    <br />
    <br />
    <a href="https://github.com/invatorzen/InvatorzenPSDKPlugins/issues">Report Bugs</a>
      
  [![ruby badge](https://forthebadge.com/images/badges/made-with-ruby.svg)](https://forthebadge.com)
  [![psdk badge](/svgs/made_for_psdk.svg)](https://gitlab.com/pokemonsdk/pokemonsdk)
  [![invatorzen badge](/svgs/made_by_invatorzen.svg)](https://github.com/invatorzen/Invatorzens_PSDKPlugins/tree/main)
  </p>
</div>


<!-- Auto-Run -->
## Installation
This plugin requires extra steps:
<ol>
  <li>Download <a href="/plugins/AutoRun_Toggle/AutoRunOption.psdkplug">AutoRunOption.psdkplug</a> and put it in your game's scripts folder</li>
  <li>Open your Data\configs\game_options_config.json and add "toggled_running_choice" to the list of options</li>
  <li>Go to Data/Text/Dialogs and open 100042.csv (use VSCode/Notepad/whatever, make sure it's still a CSV when saved)</li>
  <li>Make sure line 11 says whatever you want to represent "on" and 12 to represent "off"</li>
  <li>By default I use line 68 for the title "Auto Run" and line 69 for the description of the option. (This can be changed in scripts/00000 Plugins/xxxxx AutoRunOption/00100 Options_Menu.rb.)</li>
  <li>Launch the game</li>
</ol>

This plugin will check if you have the switch that allows you to run enabled (checking if you have running shoes), if it enabled then it checks your option setting to see if you've enabled auto-run. You could modify this to activate on a switch if you wanted to and know what you're doing.