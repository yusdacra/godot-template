extends Node

## emitted when `change_scene_to` is called, right after scene load is started
signal change_started(scene_path: String, params: Dictionary)
## emitted after the scene is loaded, but before it's `_ready` is called (ie. before it's added to the scene tree)
signal scene_loaded(scene: Node, params: Dictionary)
## emitted after the scene is fully loaded and completed it's `_ready` (after it's added to the scene tree)
signal scene_changed(scene: Node, params: Dictionary)

var _params: Dictionary = {}

@onready var _loader_mt = preload("res://addons/scenes/loader.gd").new()

## the current scene's root node
var current: Node = null

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	var cur_scene: Node = get_tree().current_scene
	change_started.emit(cur_scene.scene_file_path, _params)
	# if playing a specific scene
	if ProjectSettings.get("application/run/main_scene") != cur_scene.scene_file_path:
		# call pre_start and start method to ensure compatibility with "Play Scene"
		if not cur_scene.is_node_ready():
			await cur_scene.ready
		scene_loaded.emit(cur_scene, _params)
	scene_changed.emit(cur_scene, _params)


func _set_new_scene(resource: PackedScene) -> void:
	var current_scene = get_tree().current_scene
	current_scene.queue_free()
	await current_scene.tree_exited  # wait for the current scene to be fully removed
	var instanced_scn: Node = resource.instantiate()  # triggers _init
	scene_loaded.emit(instanced_scn, _params)
	get_tree().root.add_child(instanced_scn)  # triggers _ready
	get_tree().current_scene = instanced_scn
	scene_changed.emit(instanced_scn, _params)
	_params = {}


## this function will load a scene in a multithreaded manner (via `ResourceLoader`)
##
## returns the `scene_changed` signal to easily chain some code to run after the scene is changed.
## note that you should use `CONNECT_ONESHOT` while connecting anything to `scene_changed`
## (and any other signal) otherwise it will run every time a scene is changed.
func change_scene_to(path: String, params = {}) -> Signal:
	_params = params
	_loader_mt.resource_loaded.connect(_set_new_scene, CONNECT_ONE_SHOT)
	_loader_mt.load_resource(path)
	change_started.emit(path, params)
	return scene_changed
