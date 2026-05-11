extends Panel

func _ready():
	if not $ContinueButton.pressed.is_connected(_on_continue):
		$ContinueButton.pressed.connect(_on_continue)

func _on_continue():
	if not Global.puzzle_done:
		Global.clues_count += 1
		Global.puzzle_done = true
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_parent().queue_free()
