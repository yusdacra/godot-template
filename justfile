set shell := ['nu', '-c']

_default: (_just-cmd '-l')
_just-cmd *FLAGS="":
    @just -f {{justfile()}} {{FLAGS}}
    
package:
  rm -f template.zip
  run-external 'zip' '-r' 'template.zip' 'addons' 'assets' 'resources' 'scenes' 'utils' '.editorconfig' 'butler.sh' 'export_presets.cfg' 'project.godot' 'release.sh'
