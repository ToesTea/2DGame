class_name Coin
extends Area2D

signal collected(value: int)

@export var value: int = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("coin")

	# auch reagieren, wenn ein Geschoss/Schwert (Area2D) die Muenze beruehrt
	area_entered.connect(_on_area_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	print_debug("entered!!!!!")
	if body.is_in_group("player"):
		print_debug("ist der player!")
		collected.emit(value)
		body.add_coin(value)
		# $CollisionShape2D.disabled = true
		$CollisionShape2D.set_deferred("disabled", true)
		queue_free()

# basically das gleiche wie oben
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_weapon"):
		var player = get_tree().get_first_node_in_group("player")
		collected.emit(value)
		player.add_coin(value)
		$CollisionShape2D.set_deferred("disabled", true)
		queue_free()
