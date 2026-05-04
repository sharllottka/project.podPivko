extends StaticBody3D

@export_file("*.tscn") var target_scene: String 

func interact():
	if target_scene == "":
		print("Сцена не выбрана в инспекторе!")
		return

	Global.player_pos = get_tree().get_first_node_in_group("player").global_position

	get_tree().change_scene_to_file(target_scene)
