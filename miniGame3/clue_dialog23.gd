extends Panel

func _ready():
	if not $ContinueButton.pressed.is_connected(_on_continue):
		$ContinueButton.pressed.connect(_on_continue)

func _on_continue():
	if not Global.suitcase_done:
		Global.clues_count += 1
		Global.suitcase_done = true
	visible = false
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	get_parent().queue_free()
