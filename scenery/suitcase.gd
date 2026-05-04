extends StaticBody3D

@export_file("*.tscn") var suitcase_game_scene: String 

func interact():
	if suitcase_game_scene == "":
		return

	Global.player_pos = get_tree().get_first_node_in_group("player").global_position

	get_tree().change_scene_to_file(suitcase_game_scene)
