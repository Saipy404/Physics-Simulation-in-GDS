extends Control

@export var force: float = -15
@export var radius: float = 10
@export var color: Color = Color.BLUE

@onready var forceField = $"../Force Field"

func _draw() -> void:
	draw_circle(Vector2.ZERO, radius, color)

func _process(delta: float) -> void:
	if Input.is_action_pressed("mouseL"):
		position = get_global_mouse_position()
	if forceField.text == "":
		force = force
	else:
		force = float(forceField.text)
