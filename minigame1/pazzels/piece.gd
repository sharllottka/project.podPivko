extends Area2D

var dragging = false
var offset = Vector2()
var correct_position = Vector2()

func _ready():
	correct_position = global_position
	process_mode = Node.PROCESS_MODE_ALWAYS  

func _input(event):
	if not input_pickable:
		return
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			var mouse_pos = get_global_mouse_position()
			if global_position.distance_to(mouse_pos) < 48:
				dragging = true
				z_index = 100
				offset = mouse_pos - global_position
				if owner and owner.has_method("play_pick"):
					owner.play_pick()
				elif get_parent().get_parent().has_method("play_pick"):
					get_parent().get_parent().play_pick()
				get_viewport().set_input_as_handled()
		else:
			if dragging:
				dragging = false
				z_index = 0
				check_win_condition()

func _process(_delta):
	if dragging:
		global_position = get_global_mouse_position() - offset

func check_win_condition():
	if global_position.distance_to(correct_position) < 20:
		global_position = correct_position
		input_pickable = false
		dragging = false
		if owner and owner.has_method("add_piece_placed"):
			owner.add_piece_placed()
		else:
			get_parent().get_parent().add_piece_placed()
	else:
		if owner and owner.has_method("play_drop"):
			owner.play_drop()
		elif get_parent().get_parent().has_method("play_drop"):
			get_parent().get_parent().play_drop()
