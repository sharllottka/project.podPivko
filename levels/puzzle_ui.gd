extends CanvasLayer 

var pieces_placed = 0 

func _ready():
	
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	await get_tree().create_timer(0.1).timeout
	shuffle_pieces()

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
			
			#piece.rotation = randf_range(-0.2, 0.2) #наклон кусочков


func add_piece_placed():
	pieces_placed += 1
	print("Собрано деталей: ", pieces_placed)
	
	if pieces_placed == 42:
		win()

func win():
	print("Улика собрана!")
	
	await get_tree().create_timer(2.0).timeout
	queue_free()


func _on_button_pressed() -> void:
	queue_free()

func _input(event):
	if event.is_action_pressed("ui_cancel"): # Это стандартная клавиша Esc
		queue_free()
