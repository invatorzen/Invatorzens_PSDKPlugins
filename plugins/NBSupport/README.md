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
      
  [![forthebadge](/svgs/made-with-ruby.svg)](https://forthebadge.com)
  [![psdk badge](/svgs/made_for_psdk.svg)](https://gitlab.com/pokemonsdk/pokemonsdk)
  [![invatorzen badge](/svgs/made_by_invatorzen.svg)](https://github.com/invatorzen/Invatorzens_PSDKPlugins/tree/main)
  </p>
</div>

## Description
By default PSDK handles gender through a single switch (male/female). This plugin replaces that with a game variable so projects can support more than two genders.

The default mapping is:

| Value | Gender      |
|-------|-------------|
| 0     | Female      |
| 1     | Male        |
| 2     | Non-binary  |

The plugin patches:
- **Message parser** — adds the `\f[a§b§c]` token that picks one segment based on the gender variable.
- **World map marker** — picks `worldmap/player_icons/<charset_base>.png` (falls back to `default`).
- **Bag sprite** — picks `bag/bag_<gender>` based on the gender variable value.

## Installation
<ol>
  <li>Download <a href="https://github.com/invatorzen/Invatorzens_PSDKPlugins/raw/refs/heads/main/plugins/NBSupport/NBSupport.psdkplug">NBSupport.psdkplug</a> and put it in your game's scripts folder</li>
  <li>Launch the game</li>
</ol>

## Usage
Inside a message, use `\f[female§male§nonbinary]` to swap a word based on the variable:
```
\f[She§He§They] looked at the sky.
```

## Configuration

Edit your project's `Data/configs/plugins/nb_support_config.json` to customize:

```json
{
  "klass": "Configs::Project::NBSupportConfig",
  "gender_var": 495
}
```

| Key          | Description                                              | Default |
|--------------|----------------------------------------------------------|---------|
| `gender_var` | ID of the game variable used to track the player's gender | `495`   |

## Modified graphics

The plugin replaces how graphics work, it now expects:
- worldmap: `graphics/interface/worldmap/player_icons/<charset_base>.png`
- character: `graphics/characters/<charset_base>.png`
- bag: `graphics/interface/bag/bag_<gender_var_value>.png`
