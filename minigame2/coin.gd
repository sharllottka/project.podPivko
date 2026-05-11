extends Area2D

@onready var game_manager: Node = %GameManager
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var clue_dialog = $"/root/Game/UI/ClueDialog"
@onready var win_sound = $"../WinSound"


func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	game_manager.add_points()
	if win_sound:
		win_sound.play()
	clue_dialog.visible = true
	get_tree().paused = true
	queue_free()
