class_name Main
extends Node

@export var coin_scene: PackedScene
var score := 0
@onready var hud = $Score

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_coin_collected(value: int) -> void:
	print_debug("coin collected!!!")
	_add_score(value)

	var coin: Coin = coin_scene.instantiate()
	coin.collected.connect(_on_coin_collected)

	# random position
	coin.position.x = randf() * 500
	coin.position.y = randf() * 500
	add_child(coin)


func _add_score(points: int) -> void:
	score += points
	hud.update_score(score)
	
