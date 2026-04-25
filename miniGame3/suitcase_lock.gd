extends Control

var win_code = [3, 7, 9, 1]
var current_code = [0, 0, 0, 0]

@onready var click_player = $ClickSound 
@onready var open_player = $OpenSound 
@onready var error_player = $ErrorSound 

@onready var labels = [
	$HBoxContainer/VBoxContainer/Label,
	$HBoxContainer/VBoxContainer2/Label,
	$HBoxContainer/VBoxContainer3/Label,
	$HBoxContainer/VBoxContainer4/Label
]

func _ready():
	update_ui()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		close_menu()

func update_ui():
	for i in range(4):
		labels[i].text = str(current_code[i])

func change_digit(index: int, amount: int):
	current_code[index] += amount
	
	if current_code[index] > 9: current_code[index] = 0
	if current_code[index] < 0: current_code[index] = 9

	labels[index].text = str(current_code[index])
	
	if click_player:
		click_player.pitch_scale = randf_range(0.95, 1.05) 
		click_player.play()

func _on_open_button_pressed():
	if current_code == win_code:
		print("Код верный! Чемодан открывается...")
		victory()
	else:
		print("Неверный код. Попробуй еще раз.")
		flash_red_effect()

func _on_button_2_pressed(): 
	close_menu()

func victory():
	print("УРА! ОТКРЫТО!")
	if open_player:
		open_player.play()
	
	await get_tree().create_timer(1.5).timeout
	close_menu()

func close_menu():
	queue_free() 
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func flash_red_effect():
	if error_player:
		error_player.play()

	for label in labels:
		label.modulate = Color.RED
	
	await get_tree().create_timer(0.5).timeout
	
	for label in labels:
		label.modulate = Color.WHITE


func _on_pressed() -> void:
	pass # Replace with function body.
