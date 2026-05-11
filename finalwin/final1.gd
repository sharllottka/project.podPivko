extends Node3D

func _on_body_entered(body):
	if body.is_in_group("player") and Global.current_night == 5 and Global.clues_count >= 4:
		get_tree().change_scene_to_file.call_deferred("res://finalwin/final_dialog.tscn")
