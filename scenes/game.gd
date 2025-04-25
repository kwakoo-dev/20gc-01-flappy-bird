extends Node2D

@export var pipeScene : PackedScene;
var score : int = 0 

signal increase_score

func spawn_pipe() -> void:
	var pipe = pipeScene.instantiate()
	pipe.position.x = 1200
	var screen_height = get_viewport().size.y
	pipe.position.y = randf_range(128.0 + 32.0, $Ground.position.y - 128.0 - 32.0)
	add_child(pipe)

func _on_timer_timeout() -> void:
	spawn_pipe() # Replace with function body.

func _on_pipe_remover_body_entered(body: Node2D) -> void:
	body.queue_free()

func _on_bird_death() -> void:
	print("Bang")
	get_tree().reload_current_scene()


func _on_pipe_pass_detector_body_entered(body: Node2D) -> void:
	increase_score.emit()


func _on_increase_score() -> void:
	score += 1
	$Label.text = str(score)
