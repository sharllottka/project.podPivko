extends Area3D

@export var minigame_scene: PackedScene
@onready var model = $Sketchfab_Scene

func _ready():
	PauseManager.is_minigame = true
	if Global.current_night != 2:
		visible = true
		$CollisionShape3D.disabled = true

func open_minigame():
	if Global.current_night != 2:
		return
	if minigame_scene:
		var player = get_tree().get_first_node_in_group("player")
		if player:
			Global.player_pos = player.global_position
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().change_scene_to_packed(minigame_scene)
	else:
		print("ОШИБКА: Забыли назначить сцену мини-игры в инспекторе щитка!")

func _on_mouse_entered():
	if model and Global.current_night == 2:
		model.scale = Vector3(1.05, 1.05, 1.05)

func _on_mouse_exited():
	if model:
		model.scale = Vector3(1.0, 1.0, 1.0)
