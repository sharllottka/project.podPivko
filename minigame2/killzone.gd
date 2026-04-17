extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	# Проверяем, есть ли у входящего тела метод die (чтобы не упасть с ошибкой)
	if body.has_method("die"):
		body.die()
	
	print("Ты умер!")
	Engine.time_scale = 0.5
	# Убираем коллизию, чтобы персонаж не бился об врагов, пока умирает
	body.get_node("CollisionShape2D").queue_free() 
	timer.start()

func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()
