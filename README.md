this is a (opinionated) game template for Godot that handles some boring
boilerplating and provides a project structure.

for Godot 4.3+.

### provides

- sane project / addon settings and file hierarchy
  - GDScript static typing is enforced
  - [template scene](./scenes/_template.tscn) to duplicate for any new scenes, with [world environment and sun defaults](./scenes/defaults)
  - export presets for windows, linux, osx and web
  - ...and other settings
- [godot debug menu](https://github.com/godot-extended-libraries/godot-debug-menu) for in-game performance / hardware metrics
  - input action is named `cycle_debug_menu`, set to `Control+Alt+D` and `F3` by default
- [godot debug camera](https://github.com/kcfresh53/Godot-Debug-Camera) for a simple 3D/2D debug camera
  - input action is named `toggle_debug_camera`, set to `Control+Alt+C` by default
- [loggie](https://github.com/Shiva-Shadowsong/loggie) for logging
- [dev blocks](https://github.com/Manonox/godot-dev-blocks) for blocking out simple 3D scenes
- [scenes](./addons/scenes) for a simple threaded scene loader (TODO: publish this separately)
- [`release.sh`](./release.sh) for building all exports
- [`butler.sh`](./butler.sh) for uploading all exports to itch.io via butler

***note: addons may be modified from their original release to fix / add stuff***
