extends StaticBody3D

@export_file("*.tscn") var target_scene: String

func interact():
	if target_scene == "":
		print("Сцена не выбрана в инспекторе!")
		return

	var player = get_tree().get_first_node_in_group("player")
	if player:
		Global.player_pos = player.global_position

	var note_instance = load(target_scene).instantiate()
	note_instance.name = "NoteUI"
	get_tree().root.add_child(note_instance)

	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().paused = true
