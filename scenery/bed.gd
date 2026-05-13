extends StaticBody3D

func _ready():
	add_to_group("interactable")

func interact():
	if Global.current_night == 5 and Global.clues_count < 4:
		get_tree().change_scene_to_file("res://bed_end/bad_ending.tscn")
		return
	
	var menu = preload("res://levels/sleepmenu.tscn").instantiate()
	get_tree().root.add_child(menu)
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().paused = true
