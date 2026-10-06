extends CharacterBody2D

const SPEED = 80.0

@export var bullet_scene: PackedScene

var health := 10.0
var shoot_timer := 2.0   # Sekunden bis zum naechsten Schuss
var player


func _ready() -> void:
	add_to_group("enemy")
	player = get_tree().get_first_node_in_group("player")


func _physics_process(delta: float) -> void:
	# Richtung und Abstand zum Spieler ausrechnen
	var direction = player.global_position - global_position
	var distance = direction.length()
	direction = direction.normalized() # length = 1

	# Gegner läuft auf den Spieler zu, solange er zwischen 100 und 300 Pixel entfernt ist
	if distance < 300 and distance > 100:
		velocity = direction * SPEED
		$AnimatedSprite2D.play("walk")
	else:
		velocity = Vector2.ZERO
		$AnimatedSprite2D.play("idle")

	# Gegner nach links/rechts drehen
	$AnimatedSprite2D.flip_h = direction.x < 0

	# Alle 2 Sekunden schiessen, wenn der Spieler nah genug ist
	shoot_timer -= delta
	if shoot_timer <= 0 and distance < 300:
		shoot_timer = 2.0
		var bullet = bullet_scene.instantiate()
		bullet.global_position = global_position
		bullet.direction = direction
		bullet.from_player = false      # Gegner-Schuss
		get_tree().current_scene.add_child(bullet)
	
	print(health)
	if health <= 0:
		queue_free()

	move_and_slide()
