# scene_manager.gd
extends Node

var is_minigame_active = false

func enter_minigame():
	is_minigame_active = true
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func exit_minigame():
	is_minigame_active = false
	get_tree().change_scene_to_file("res://scenes/main.tscn")
