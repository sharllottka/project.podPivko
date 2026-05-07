extends StaticBody3D

@export_file("*.tscn") var puzzle_scene: String 

func interact():
	if puzzle_scene == "":
		print("Ошибка: Сцена пазлов не выбрана в Инспекторе!")
		return

	Global.player_pos = get_tree().get_first_node_in_group("player").global_position

	get_tree().change_scene_to_file(puzzle_scene)
