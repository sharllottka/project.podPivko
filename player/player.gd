extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@onready var clue_label = find_child("ClueCounter")
@onready var note_panel = find_child("NotePanel")
@onready var notification_label = find_child("NotificationLabel")

var note_alert_shown = false 

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func _process(_delta):
	if clue_label:
		clue_label.text = "Улик собрано: " + str(Global.clues_count) + "/5"

	if Global.has_note and not Global.note_notification_shown:
		if notification_label:
			if not note_panel.visible:
				notification_label.visible = true
			else:
				notification_label.visible = false
				Global.note_notification_shown = true

func _input(event):
	if event.is_action_pressed("inventory"):
		if Global.has_note:
			toggle_note()

func toggle_note():
	note_panel.visible = !note_panel.visible
	if note_panel.visible:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
