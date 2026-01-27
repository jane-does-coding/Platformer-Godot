extends Node

var score = 0
@onready var score_label: Label = $ScoreLabel
@onready var score_label2: Label = $"../GameManager2/ScoreLabel"
@onready var game_manager: Node = %GameManager

func add_point():
	score += 1
	score_label.text = "You collected " + str(score) + " coins."
	score_label2.text = "You collected " + str(score) + " coins."
	
	if score == 90:
		print("won")
