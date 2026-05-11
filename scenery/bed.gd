extends StaticBody3D

func _ready():
	add_to_group("interactable")

func interact():
	var menu = preload("res://levels/sleepmenu.tscn").instantiate()
	get_tree().root.add_child(menu)
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().paused = true
