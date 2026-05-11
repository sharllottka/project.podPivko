extends StaticBody3D

@export_file("*.tscn") var suitcase_game_scene: String

func interact():
	if suitcase_game_scene == "":
		return
	var player = get_tree().get_first_node_in_group("player")
	if player:
		Global.player_pos = player.global_position
	var suitcase_instance = load(suitcase_game_scene).instantiate()
	suitcase_instance.name = "SuitcaseUI"
	get_tree().root.add_child(suitcase_instance)
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().paused = true
