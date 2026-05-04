extends Control

var win_code = [3, 7, 9, 1]
var current_code = [0, 0, 0, 0]

@onready var click_player = $ClickSound 
@onready var open_player = $OpenSound 
@onready var error_player = $ErrorSound 

@onready var clue_dialog = $ClueDialog
@onready var labels = [
	$HBoxContainer/VBoxContainer/Label,
	$HBoxContainer/VBoxContainer2/Label,
	$HBoxContainer/VBoxContainer3/Label,
	$HBoxContainer/VBoxContainer4/Label
]

func _ready():
	clue_dialog.visible = false
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	update_ui()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		close_menu()

func update_ui():
	for i in range(4):
		labels[i].text = str(current_code[i])

func change_digit(index: int, amount: int):
	if clue_dialog.visible:
		return
		
	current_code[index] += amount
	
	if current_code[index] > 9: current_code[index] = 0
	if current_code[index] < 0: current_code[index] = 9

	labels[index].text = str(current_code[index])
	
	if click_player:
		click_player.pitch_scale = randf_range(0.95, 1.05) 
		click_player.play()

func _on_open_button_pressed():
	if current_code == win_code:
		victory()
	else:
		flash_red_effect()

func victory():
	print("Код верный!")
	if open_player:
		open_player.play()
	
	clue_dialog.visible = true

func _on_continue_button_pressed():
	if not Global.suitcase_done: 
		Global.clues_count += 1  
		Global.suitcase_done = true 
	close_menu()

func close_menu():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	get_tree().change_scene_to_file("res://levels/level.tscn")

func flash_red_effect():
	if error_player:
		error_player.play()

	for label in labels:
		label.modulate = Color.RED
	
	await get_tree().create_timer(0.5).timeout
	
	for label in labels:
		label.modulate = Color.WHITE

func _on_button_2_pressed(): 
	close_menu()
