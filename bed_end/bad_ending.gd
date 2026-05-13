extends Control

@onready var black_rect = $ColorRect
@onready var end_sound = $EndSound
@onready var label = $Label

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	label.visible = false
	black_rect.modulate.a = 0.0
	
	var tween = create_tween()
	tween.tween_property(black_rect, "modulate:a", 1.0, 2.0)
	await tween.finished
	
	if end_sound:
		end_sound.play()
		await end_sound.finished
	
	label.visible = true
	label.modulate.a = 0.0
	var tween2 = create_tween()
	tween2.tween_property(label, "modulate:a", 1.0, 1.5)
	await tween2.finished

	await get_tree().create_timer(3.0).timeout
	get_tree().change_scene_to_file("res://main_menu/main_menu.tscn")
