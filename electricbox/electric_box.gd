extends Area3D

@export var minigame_scene: PackedScene
@export var available_on_night: int = 4
@onready var model = $Sketchfab_Scene

func _ready():
	PauseManager.is_minigame = true
	if Global.current_night != available_on_night:
		visible = true
		$CollisionShape3D.disabled = true

func open_minigame():
	if Global.current_night != available_on_night:
		return
	if minigame_scene:
		var player = get_tree().get_first_node_in_group("player")
		if player:
			Global.player_pos = player.global_position
		var instance = minigame_scene.instantiate()
		instance.name = "ShieldUI"
		get_tree().root.add_child(instance)
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().paused = true
	else:
		print("ОШИБКА: Забыли назначить сцену мини-игры!")

func _on_mouse_entered():
	if model and Global.current_night == available_on_night:
		model.scale = Vector3(1.05, 1.05, 1.05)

func _on_mouse_exited():
	if model:
		model.scale = Vector3(1.0, 1.0, 1.0)
