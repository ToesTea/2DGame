class_name Player
extends CharacterBody2D

const SPEED = 300.0

const DEADZONE: float = 0.1

@export var bullet_scene: PackedScene

# speichert die letzt-gueltige richtung
# Schießt wenn in noch keine richtung gedrückt nach unten anstatt das das projektik stehen bleibt
var prev_direction: Vector2 = Vector2.DOWN

var health := 100
var weapon := "gun"      # entweder "gun" oder "sword"
var sword_timer := 0.0   # so viele Sekunden ist das Schwert noch aktiv


func _ready() -> void:
	# Geschosse und Schwert gehören zur Gruppe "player_weapon",
	# daran erkennt die Münze, dass sie eingesammelt werden darf
	$SwordArea.add_to_group("player_weapon")


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

	if Input.is_action_just_pressed("switch_weapon"):
		if weapon == "gun":
			weapon = "sword"
		else:
			weapon = "gun"

	if Input.is_action_just_pressed("shoot"):
		if weapon == "gun":
			shoot()
		else:
			sword_timer = 0.2

	# Schwert (Kreis hitbox)
	$SwordArea.position = prev_direction.normalized() * 50
	if sword_timer > 0:
		sword_timer -= delta
		$SwordArea.visible = true
		$SwordArea/CollisionShape2D.disabled = false
		# alle Objekte im Schwert prüfen
		for body in $SwordArea.get_overlapping_bodies():
			if body.is_in_group("enemy"):
				body.health -= 10 * delta
	else:
		$SwordArea.visible = false
		$SwordArea/CollisionShape2D.disabled = true

	if health <= 0:
		get_tree().reload_current_scene()

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
