extends Control

var win_code = [3, 7, 9, 1]
var current_code = [0, 0, 0, 0]

@onready var labels = [
	$HBoxContainer/VBoxContainer/Label,
	$HBoxContainer/VBoxContainer2/Label,
	$HBoxContainer/VBoxContainer3/Label,
	$HBoxContainer/VBoxContainer4/Label
]

func _ready():
	update_ui()

func update_ui():
	for i in range(4):
		labels[i].text = str(current_code[i])

func change_digit(index: int, amount: int):
	current_code[index] += amount
	
	if current_code[index] > 9: current_code[index] = 0
	if current_code[index] < 0: current_code[index] = 9

	labels[index].text = str(current_code[index])

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
	#$AudioStreamPlayer.play()
	await get_tree().create_timer(1.0).timeout
	close_menu()

func close_menu():
	queue_free() 
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func flash_red_effect():
	for label in labels:
		label.modulate = Color.RED
	
	await get_tree().create_timer(0.5).timeout
	
	for label in labels:
		label.modulate = Color.WHITE
