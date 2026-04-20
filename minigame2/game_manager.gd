extends Node

var score = 0

@onready var score_label: Label = $ScoreLabel

func add_points():
	score+=1 
	score_label.text = "Ti sobral " + str(score) + " coins
mozesh gorditsya etim.."
