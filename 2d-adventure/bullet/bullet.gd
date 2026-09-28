extends Area2D

@export var speed := 600.0
var direction := Vector2.UP

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += direction * speed * delta
	var size := get_viewport_rect().size
	
	if global_position.x < 0 or global_position.x > size.x or global_position.y < 0 or global_position.y > size.y:
		queue_free()
