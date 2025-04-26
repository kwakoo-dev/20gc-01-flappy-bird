extends Node2D

enum GameState {
	StartScreen,
	Playing,
	GameOver,
}

@export var pipeScene : PackedScene;

var score : int = 0 
var currentState = GameState.StartScreen

signal increase_score

func _ready() -> void:
	currentState = GameState.StartScreen
	$SplashScreens/GameOver.hide_game_over()

func _process(delta):
	if Input.is_action_pressed("ui_accept") && currentState != GameState.Playing:
		set_score(0)
		for pipe in get_tree().get_nodes_in_group("pipes"):
			pipe.queue_free()
		$Bird.position = Vector2(200, 250)
		$SplashScreens/TitleScreen.visible = false
		$SplashScreens/GameOver.hide_game_over()  
		currentState = GameState.Playing

func spawn_pipe() -> void:
	var pipe = pipeScene.instantiate()
	pipe.position.x = 1200
	var screen_height = get_viewport().size.y
	pipe.position.y = randf_range(128.0 + 32.0, $Ground.position.y - 128.0 - 32.0)
	add_child(pipe)

func _on_timer_timeout() -> void:
	if currentState == GameState.Playing:
		spawn_pipe() # Replace with function body.

func _on_pipe_remover_body_entered(body: Node2D) -> void:
	body.queue_free()

func _on_bird_death() -> void:
	if currentState == GameState.Playing:
		print("Bang")
		$SplashScreens/GameOver.show_game_over(score)
		currentState = GameState.GameOver

func _on_pipe_pass_detector_body_entered(body: Node2D) -> void:
	if currentState == GameState.Playing:
		increase_score.emit()

func _on_increase_score() -> void:
	set_score(score + 1)

func set_score(new_score: int) -> void:
	score = new_score
	$ScoreLabel.text = str(score)
