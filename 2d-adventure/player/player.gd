
class_name Player
extends CharacterBody2D

const SPEED = 300.0

func _physics_process(delta: float) -> void:

	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * SPEED

	var left_right := Input.get_axis("move_left", "move_right")
	var up_down := Input.get_axis("move_up", "move_down")
	
	$AnimatedSprite2D.play()

	if abs(direction.x) >= abs(direction.y):
		# x direction
		$AnimatedSprite2D.animation = "walk_side"
		$AnimatedSprite2D.flip_h = direction.x < 0
	else:
		# y direction
		$AnimatedSprite2D.animation = "walk_up" if direction.y < 0 else "walk_down"
		$AnimatedSprite2D.flip_h = false

	move_and_slide()

func add_coin(value: int):
	print_debug("TODO: add coin for player")
