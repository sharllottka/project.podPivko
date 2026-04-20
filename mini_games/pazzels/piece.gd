extends Area2D

var dragging = false
var offset = Vector2()
var correct_position = Vector2() 

func _ready():
	correct_position = global_position

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			dragging = true
			z_index = 100
			offset = get_global_mouse_position() - global_position
	
			get_viewport().set_input_as_handled()
		else:
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
