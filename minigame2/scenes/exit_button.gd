extends Area2D

var player_nearby = false

@onready var hint_label = $"/root/Game//UI/HintLabel"
@onready var exit_dialog = $"/root/Game/UI/ExitDialog"

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body.is_in_group("player"):
		player_nearby = true
		hint_label.visible = true

func _on_body_exited(body):
	if body.is_in_group("player"):
		player_nearby = false
		hint_label.visible = false

func _process(_delta):
	if player_nearby and Input.is_action_just_pressed("interact"):
		hint_label.visible = false
		exit_dialog.visible = true
		get_tree().paused = true
