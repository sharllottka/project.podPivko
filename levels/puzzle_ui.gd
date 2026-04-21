extends CanvasLayer 

var pieces_placed = 0 

@onready var pick_sound = $PickSound
@onready var drop_sound = $DropSound
@onready var snap_sound = $SnapSound
@onready var win_sound = $WinSound

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	await get_tree().create_timer(0.1).timeout
	shuffle_pieces()

func play_pick():
	if pick_sound:
		pick_sound.pitch_scale = randf_range(0.9, 1.1)
		pick_sound.play()

func play_drop():
	if drop_sound:
		drop_sound.pitch_scale = randf_range(0.8, 1.0)
		drop_sound.play()

func shuffle_pieces():
	var screen_size = get_viewport().get_visible_rect().size
	for piece in $PuzzleScaler.get_children():
		if piece is Area2D:
			var random_x = 0
			if randf() > 0.5:
				random_x = randf_range(50, 250)
			else:
				random_x = randf_range(screen_size.x - 250, screen_size.x - 50)
			
			var random_y = randf_range(100, screen_size.y - 100)
			piece.global_position = Vector2(random_x, random_y)

func add_piece_placed():
	pieces_placed += 1

	if snap_sound:
		snap_sound.play()
		
	print("Собрано деталей: ", pieces_placed)
	if pieces_placed == 42:
		win()

func win():
	print("Улика собрана!")

	if win_sound:
		win_sound.play()
		
	await get_tree().create_timer(2.0).timeout
	queue_free()

func _on_button_pressed() -> void:
	queue_free()

func _input(event):
	if event.is_action_pressed("ui_cancel"): 
		queue_free()
