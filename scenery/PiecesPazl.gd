extends StaticBody3D

@export_file("*.tscn") var puzzle_scene: String

func _ready():
	if Global.current_night != 1:
		visible = false

func interact():
	if Global.current_night != 1:
		return
	if puzzle_scene == "":
		print("Ошибка: Сцена пазлов не выбрана!")
		return
	var player = get_tree().get_first_node_in_group("player")
	if player:
		Global.player_pos = player.global_position
	var puzzle_instance = load(puzzle_scene).instantiate()
	puzzle_instance.name = "PuzzleUI"
	get_tree().root.add_child(puzzle_instance)
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().paused = true
