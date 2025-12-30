<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/invatorzen/PSDKPlugins">
    <img src="https://i.imgur.com/Q3LOc4v.png" alt="Logo" width="240" height="240">
  </a>

  <h3 align="center">Umbra Debug Mode</h3>

  <p align="center">
    <i>The ultimate development toolkit for PSDK!</i>
    <br /> <br />
    <a href="file:///c:/Users/becra/Desktop/psdk/Umbra/Pokemon%20Umbra/scripts/00012%20Debug_Mode"><strong>View Source</strong></a>
    <br />
    <br />
    <a href="https://github.com/invatorzen/InvatorzenPSDKPlugins/issues">Report Bugs</a>
      
  [![ruby badge](https://forthebadge.com/images/badges/made-with-ruby.svg)](https://forthebadge.com)
  [![psdk badge](/svgs/made_for_psdk.svg)](https://gitlab.com/pokemonsdk/pokemonsdk)
  [![invatorzen badge](/svgs/made_by_invatorzen.svg)](https://github.com/invatorzen/Invatorzens_PSDKPlugins/tree/main)
  </p>
</div>

## Description
Umbra Debug Mode is a comprehensive developer toolkit designed to streamline the project development and testing process in PSDK. It provides a unified, highly accessible interface for common developer tasks, drastically reducing the time spent on tedious testing procedures.

Key features include:
* **Unified Debug Menu**: Access everything from world-state editing (switches/variables) to party management in one place.
* **Full Mouse Support**: Navigate the entire menu with hover, click, and mouse-wheel scrolling for a modern feel.
* **Developer Power-Hotkeys**: Hold **Control** to instantly bypass encounters, guarantee escapes, or ensure 100% catch rates.
* **Modular Architecture**: Cleanly separated logic makes it easy to extend or modify specific categorical actions.

## Installation
1. Drop the `00012 Debug_Mode` folder into your `scripts` directory.
2. Ensure you have the `graphics/debug/menu_icon.png` asset present.
3. Import the debug text CSV (ID: `100101`) into your project's data.

## How to use
### Accessing the Menu
* **F8 Hotkey**: Press **F8** at any time on the overworld to jump into the menu.
* **Game Menu**: Open your main menu; a "Debug" entry will appear at the bottom if the game is in debug mode.

### Power-User Shortcuts
When on the overworld or in battle, keep an eye on your **Control** keys:
* **Hold Ctrl (Overworld)**: No wild encounters while moving.
* **Hold Ctrl (Fleeing)**: Guaranteed 100% escape success.
* **Hold Ctrl (Catching)**: Guaranteed 100% catch rate for any Pokéball.

### Mouse Navigation
Simply move your mouse to highlight entries:
* **Left Click**: Confirm/Enter category/Execute option.
* **Mouse Wheel**: Scroll through long lists or categories.
* **Right Click (Number Input)**: Quickly cancel or exit.

---
*Developed for the Pokèmon Umbra project.*
