extends Node

const FULLSCREEN_MODE := DisplayServer.WINDOW_MODE_FULLSCREEN
const MOUSE_MODE := Input.MOUSE_MODE_CAPTURED

@onready var previous_window_mode := DisplayServer.window_get_mode()
@onready var previous_mouse_mode := Input.mouse_mode

var ACTIONS := {
	&"toggle_fullscreen": toggle_fullscreen,
	&"toggle_audio_mute": toggle_mute,
	&"toggle_mouse_capture": toggle_mouse_cursor,
	&"restart_scene": restart_scene,
}

func _unhandled_input(event: InputEvent) -> void:
	for action in ACTIONS.keys():
		if event.is_action_pressed(action):
			ACTIONS[action].call()

func toggle_fullscreen() -> void:
	var fullscreen := FULLSCREEN_MODE == DisplayServer.window_get_mode()
	var mode := FULLSCREEN_MODE if not fullscreen else previous_window_mode
	DisplayServer.window_set_mode(mode)
	Loggie.info("set window to be %s" % ("fullscreen" if not fullscreen else "not fullscreen"))

func toggle_mute() -> void:
	var mute := not AudioServer.is_bus_mute(0)
	AudioServer.set_bus_mute(0, mute)
	Loggie.info("%s audio" % ("muted" if mute else "unmuted"))

func toggle_mouse_cursor() -> void:
	var captured = Input.mouse_mode == MOUSE_MODE
	Input.mouse_mode = MOUSE_MODE if not captured else previous_mouse_mode
	Loggie.info("set mouse mode to %s" % ("captured" if not captured else "uncaptured"))

func restart_scene() -> void:
	Scenes.change_scene_to(Scenes.current.scene_file_path)
