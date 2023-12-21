extends Control

@onready var score = $Score
@onready var lives = $Lives


func set_score_label(new_score: int):
	score.text = "SCORE: " + str(new_score)


func set_lives_label(new_lives: int):
	lives.text = "x " + str(new_lives)
