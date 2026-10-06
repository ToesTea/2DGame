extends Node

@export var main_menu_scene: PackedScene
@export var settings_scene: PackedScene
@export var pause_menu_scene: PackedScene
@export var gameplay_scene: PackedScene

var _current: Node
var _gameplay: Node
var _pause_menu: Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_show_main_menu()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause") and _is_gameplay_active():
		_open_pause_menu()

func _show_main_menu() -> void:
	var main_menu := main_menu_scene.instantiate()
	main_menu.start_pressed.connect(_on_main_menu_start_pressed)
	main_menu.settings_pressed.connect(_on_main_menu_settings_pressed)
	main_menu.exit_pressed.connect(_on_main_menu_exit_pressed)
	_switch_to(main_menu)

func _open_pause_menu() -> void:
	_pause_menu = pause_menu_scene.instantiate()
	_pause_menu.resume_pressed.connect(_on_pause_menu_resume_pressed)
	_pause_menu.main_menu_pressed.connect(_on_pause_menu_main_menu_pressed)
	add_child(_pause_menu)
	pass

func _on_main_menu_start_pressed() -> void:
	_gameplay = gameplay_scene.instantiate()
	_switch_to(_gameplay)

func _on_main_menu_settings_pressed() -> void:
	print_debug("TODO")
	pass

func _close_pause_menu() -> void:
	print_debug("TODO")
	pass

func _on_main_menu_exit_pressed() -> void:
	get_tree().quit()
	
func _on_pause_menu_resume_pressed() -> void:
	get_tree().paused = false
	_pause_menu.queue_free()
	_pause_menu = null
	pass

func _on_pause_menu_main_menu_pressed() -> void:
	_close_pause_menu()
	_show_main_menu()
	pass

func _is_gameplay_active() -> bool:
	return is_instance_valid(_gameplay) and _current == _gameplay

func _switch_to(next: Node) -> void:
	if is_instance_valid(_current):
		_current.queue_free()
	if _current == _gameplay:
		_gameplay = null
	_current = next
	add_child(_current)
