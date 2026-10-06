extends Area2D

@export var speed := 600.0
var direction := Vector2.UP

var from_player := true   # true = Spieler-Schuss, false = Gegner-Schuss
var travelled := 0.0      # wie weit das Geschoss schon geflogen ist


func _ready() -> void:
	if from_player:
		add_to_group("player_weapon")


func _process(delta: float) -> void:
	position += direction * speed * delta

	# Geschoss nach 700 Pixeln geloescht.
	travelled += speed * delta
	if travelled > 700:
		queue_free()

	# schauen, was das Geschoss gerade beruehrt
	for body in get_overlapping_bodies():
		if body.is_in_group("enemy"):
			if from_player:
				body.health -= 1
				queue_free()
		elif body.is_in_group("player"):
			if from_player == false:
				body.health -= 10
				queue_free()
		else:
			queue_free()
