extends CharacterBody2D

signal death

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const PIPES = "Pipes"
const GROUND = "Ground"

func _physics_process(delta: float) -> void:
	# Add the gravity.
	velocity += get_gravity() * delta * 2
#
	## Handle jump.
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = JUMP_VELOCITY     
#
	var collision_after_move = move_and_collide(velocity * delta)
	
	if collision_after_move:
		var collider = collision_after_move.get_collider()
		print(collider.name)
		if collider.is_in_group("deadly_group"):
			death.emit()
