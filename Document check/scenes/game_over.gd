extends Node

@onready var texture_rect = $TextureRect
@onready var laugh_sound = $LaughSound

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

	texture_rect.modulate.a = 0.0

	var tween = create_tween()
	tween.tween_property(texture_rect, "modulate:a", 1.0, 1.5)
	await tween.finished
	
	if laugh_sound:
		laugh_sound.play()
		await laugh_sound.finished

	await get_tree().create_timer(5.0).timeout
	get_tree().change_scene_to_file("res://main_menu/main_menu.tscn")
