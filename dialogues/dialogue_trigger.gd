extends Node3D

@onready var dialogue_ui = get_tree().current_scene.get_node("dialogue_ui/Canvas")
@onready var dialogue_animation = get_tree().current_scene.get_node("dialogue_ui/Canvas/AnimationPlayer")
@onready var speaker_name: RichTextLabel = get_tree().current_scene.get_node("dialogue_ui/Canvas/speaker_name")
@onready var dialogue_text: RichTextLabel = get_tree().current_scene.get_node("dialogue_ui/Canvas/dialogue_text")
@onready var player: CharacterBody3D = get_tree().current_scene.get_node("player")

@export var dialogues: Array[String]
@export var speaker_names: Array[String]
@export var speaker: Node3D

var current_dialoge = -1
var started = false

func _ready() -> void:
	dialogue_ui.get_node("continue").connect("pressed", Callable(self, "continue_dialogue"))

func start_dialogue(body):
	if body == player and !started:
		started = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		player.SPEED = 0.0
		player.get_node("head").sensitivity = 0.0
		if !dialogue_ui.visible:
			dialogue_ui.visible = true
		speaker.look_at(player.global_transform.origin)
		speaker.rotation_degrees.x = 0
		speaker.rotation_degrees.z = 0
		continue_dialogue()
		
func end_dialogue():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	player.SPEED = 5.0
	player.get_node("head").sensitivity = 0.2
	dialogue_ui.visible = false

func continue_dialogue():
	current_dialoge += 1
	if current_dialoge < dialogues.size():
		dialogue_text.text = dialogues[current_dialoge]
		speaker_name.text = speaker_names[current_dialoge]
		dialogue_animation.play("RESET")
		dialogue_animation.play("new_animation")
	else:
		end_dialogue()
