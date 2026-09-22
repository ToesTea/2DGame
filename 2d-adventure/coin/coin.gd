class_name Coin
extends Area2D

signal collected(value: int)

@export var value: int = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	print_debug("entered!!!!!")
	if body.is_in_group("player"):
		print_debug("ist der player!")
		collected.emit(value)
		body.add_coin(value)
