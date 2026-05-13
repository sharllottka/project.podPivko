extends Node

var pause_menu_scene = preload("res://pause_menu/pause_menu.tscn")
var is_paused = false
var is_3d = false

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

func _input(event: InputEvent):
	if event is InputEventKey and event.pressed and not event.echo and event.keycode == KEY_ESCAPE:
		get_viewport().set_input_as_handled()
		toggle_pause()

func toggle_pause():
	is_paused = !is_paused
	get_tree().paused = is_paused
	if is_paused:
		var menu = pause_menu_scene.instantiate()
		get_tree().root.add_child(menu)
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		if is_3d:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
