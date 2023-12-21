extends Control

func set_score_label(score):
	$Panel/Score.text = "SCORE: " + str(score)

func on_retry_button_pressed():
	get_tree().reload_current_scene()
