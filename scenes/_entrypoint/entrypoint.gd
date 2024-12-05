extends Node

# this will be the entrypoint scene for your project
# you could use this to setup resources, or to decide which other scene to load

@export_file var initial_scene: String

func _ready() -> void:
	Loggie.notice(State.some_string)
	# prints scene load times
	Scenes.change_started.connect(
		func(scene_path: String, _params: Dictionary) -> void:
			Loggie.info("starting change to scene %s" % scene_path)
			var load_start_time := Time.get_ticks_msec()
			Scenes.scene_changed.connect(
				func(scene: Node, _params: Dictionary) -> void:
					Loggie.info("changed to %s scene in %sms" % [scene.name, Time.get_ticks_msec() - load_start_time]),
				CONNECT_ONE_SHOT
			)
	)
	# load our scene
	Scenes.change_scene_to(initial_scene)
