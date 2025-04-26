extends Node2D

func show_game_over(score: int) -> void:
	visible = true
	$Score.text = "Score: " + str(score)

func hide_game_over() -> void:
	visible = false
