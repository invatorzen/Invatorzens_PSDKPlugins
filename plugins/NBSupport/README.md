<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/invatorzen/PSDKPlugins">
    <img src="https://i.imgur.com/Q3LOc4v.png" alt="Logo" width="240" height="240">
  </a>

  <h3 align="center">Non-Binary Support</h3>

  <p align="center">
    <i>Why use a switch when we can use a variable?</i>
    <br /> <br />
    <a href="https://github.com/invatorzen/Invatorzens_PSDKPlugins/raw/refs/heads/main/plugins/NBSupport/NBSupport.psdkplug"><strong>Download</strong></a>
    <br />
    <br />
    <a href="https://github.com/invatorzen/InvatorzenPSDKPlugins/issues">Report Bugs</a>
      
  [![ruby badge](https://forthebadge.com/images/badges/made-with-ruby.svg)](https://forthebadge.com)
  [![psdk badge](/svgs/made_for_psdk.svg)](https://gitlab.com/pokemonsdk/pokemonsdk)
  [![invatorzen badge](/svgs/made_by_invatorzen.svg)](https://github.com/invatorzen/Invatorzens_PSDKPlugins/tree/main)
  </p>
</div>

## Descrption
By default PSDK handles gender through a switch. This plugin aims to change it to a variable and remove any hardcoded gender, like male/female string checks.

## Installation
<ol>
  <li>Download <a href="https://github.com/invatorzen/Invatorzens_PSDKPlugins/raw/refs/heads/main/plugins/NBSupport/NBSupport.psdkplug">NBSupport.psdkplug</a> and put it in your game's scripts folder</li>
  <li>Launch the game</li>
</ol>

## Monkey Patch
If you want to change the variable, since it uses 495 by default, you can do so like this:
```rb
module Yuki
  module Var
    GenderVar = 495 #Change me
  end
end
```