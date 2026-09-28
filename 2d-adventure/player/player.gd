
class_name Player
extends CharacterBody2D

const SPEED = 300.0

const DEADZONE: float = 0.1

@export var bullet_scene: PackedScene

# speichert die letzt-gueltige richtung
var prev_direction: Vector2

func _physics_process(delta: float) -> void:

	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * SPEED

	var left_right := Input.get_axis("move_left", "move_right")
	var up_down := Input.get_axis("move_up", "move_down")
	
	var walk: bool = abs(direction.x) > DEADZONE or abs(direction.y) > DEADZONE
	
	if walk:
		prev_direction = direction
		_set_animation(direction, "walk_side", "walk_up", "walk_down")
	else:
		_set_animation(prev_direction, "idle_side", "idle_up", "idle_down")
	
	if Input.is_action_just_pressed("shoot"):
		shoot()
	
	move_and_slide()

func _set_animation(direction: Vector2, ani_side: StringName,
		ani_up: StringName, ani_down: StringName) -> void:

	$AnimatedSprite2D.play()

	if abs(direction.x) >= abs(direction.y):
		# x direction
		$AnimatedSprite2D.animation = ani_side
		$AnimatedSprite2D.flip_h = direction.x < 0
	else:
		# y direction
		$AnimatedSprite2D.animation = ani_up if direction.y < 0 else ani_down
		$AnimatedSprite2D.flip_h = false

func add_coin(value: int):
	print_debug("TODO: add coin for player")
	
func shoot() -> void:
	var bullet = bullet_scene.instantiate()
	bullet.global_position = global_position
	bullet.direction = prev_direction
	get_tree().current_scene.add_child(bullet)
