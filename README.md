this is a (opinionated) game template for Godot that handles some boring
boilerplating and provides a project structure.

for Godot 4.3+.

## provides

- sane project / addon settings and file hierarchy
  - GDScript static typing is enforced
  - template scenes (2D/3D) to duplicate for any new scenes, with [world environment and sun defaults](./scenes/_defaults)
  - export presets for windows, linux, osx and web
  - default rendering method is set to Compatibility
  - ...and other settings
- [godot debug menu](https://github.com/godot-extended-libraries/godot-debug-menu) for in-game performance / hardware metrics
  - input action is named `cycle_debug_menu`, set to `Control+Alt+D` and `F3` by default
- [godot debug camera](https://github.com/kcfresh53/Godot-Debug-Camera) for a simple 3D/2D debug camera
  - input action is named `toggle_debug_camera`, set to `Control+Alt+C` by default
- [loggie](https://github.com/Shiva-Shadowsong/loggie) for logging
- [dev blocks](https://github.com/Manonox/godot-dev-blocks) for blocking out simple 3D scenes
- [scenes](./addons/scenes) for a simple threaded scene loader (TODO: publish this separately)
- [shortcuts](./addons/shortcuts) to provide some shortcuts (fullscreen, mute, mouse capture, etc.) (TODO: publish this separately)
- [`release.sh`](./release.sh) for building all exports
- [`butler.sh`](./butler.sh) for uploading all exports to itch.io via butler

***note: addons may be modified from their original release to fix / add stuff***

## usage

you can get the latest release from the [asset library](https://godotengine.org/asset-library/asset/3546).

clone the repository and change the remote to point to your own.
or use GitHub's "Use this template" button.

alternatively, if you don't want to delete unwanted files like the `UNLICENSE` or `icon.png` etc.
head over to the [releases tab](https://github.com/yusdacra/godot-template/releases) and download the `template.zip` file from the latest release.
