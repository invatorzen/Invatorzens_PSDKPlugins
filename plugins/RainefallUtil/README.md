<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/invatorzen/PSDKPlugins">
    <img src="https://i.imgur.com/Q3LOc4v.png" alt="Logo" width="240" height="240">
  </a>

  <h3 align="center">Rainfall Utils</h3>

  <p align="center">
    <i>A utility plugin providing shader effects, color helpers, and convenience functions for PSDK projects.</i>
    <br />
    <i>Originally created by rainefall for Pokémon Essentials, ported to PSDK by invatorzen. (<a href="https://eeveeexpo.com/resources/1079/">Original Resource</a>)</i>
    <br /> <br />
    <a href="https://github.com/invatorzen/Invatorzens_PSDKPlugins/raw/refs/heads/main/plugins/RainefallUtil/RainefallUtil.psdkplug"><strong>Download</strong></a>
    <br />
    <br />
    <a href="https://github.com/invatorzen/InvatorzenPSDKPlugins/issues">Report Bugs</a>
      
  [![ruby badge](https://forthebadge.com/images/badges/made-with-ruby.svg)](https://forthebadge.com)
  [![psdk badge](/svgs/made_for_psdk.svg)](https://gitlab.com/pokemonsdk/pokemonsdk)
  [![invatorzen badge](/svgs/made_by_invatorzen.svg)](https://github.com/invatorzen/Invatorzens_PSDKPlugins/tree/main)
  </p>
</div>


<!-- Rainfall Utils -->
## Features

### 🎨 Color Utilities (`RfColorUtils`)
A helper module with a preset color palette (`white`, `black`, `red`, `green`, `blue`, `yellow`, `orange`, `purple`, `cyan`, `magenta`) and a `resolve` method that converts symbol names to `Color` objects.

### ✨ Shader Effects
Two shader effects that can be applied to **Sprites** and **Viewports**:

- **Outline** (`rf_apply_outline`) — Draws an outline around a sprite or viewport's content. Useful for highlighting UI elements, Pokémon icons, etc.
  - `color:` — A symbol (e.g. `:white`, `:cyan`) or a `Color` object. Default: `:white`
  - `width:` — Outline thickness in pixels. Default: `1`
- **Blur** (`rf_apply_blur`) — Applies a blur effect to a sprite. *(Sprite only)*
  - `power:` — Blur intensity. Default: `1.0`
- **Clear** (`rf_clear_effects`) — Removes any applied shader from a sprite or viewport.

### 📐 Math Extensions
- `Math.lerp(a, b, t)` — Linear interpolation between two values.

### 🕹️ Convenience (`Rf`)
- `Rf.wait_for_move_route` — Blocks execution until all active move routes (player, events, and followers) have completed. Handy for cutscenes and scripted sequences.

## Installation
<ol>
  <li>Download <a href="https://github.com/invatorzen/Invatorzens_PSDKPlugins/raw/refs/heads/main/plugins/RainefallUtil/RainefallUtil.psdkplug">RainefallUtil.psdkplug</a> and place it in your game's <code>scripts</code> folder.</li>
  <li>Launch the game — the plugin will load automatically.</li>
</ol>

## Usage Examples

```ruby
# Apply a cyan outline to a sprite
sprite.rf_apply_outline(color: :cyan, width: 2)

# Apply a blur effect
sprite.rf_apply_blur(power: 2.0)

# Clear all shader effects
sprite.rf_clear_effects

# Apply an outline to an entire viewport
viewport.rf_apply_outline(color: :red, width: 1)

# Wait for all move routes to finish
Rf.wait_for_move_route

# Lerp between two values
Math.lerp(0, 100, 0.5) # => 50.0
```

## Included Shaders
| Shader | File | Description |
|--------|------|-------------|
| `rf_outline` | `graphics/shaders/rf_outline.frag` | Outline effect with configurable color and width |
| `rf_blur` | `graphics/shaders/rf_blur.frag` | Gaussian-style blur with configurable power |