extends Node2D

@export var fps = 60
@export var floor = 0
@export var gravity = Vector2(0, -9.81)

@onready var gravityX = $"../GravityX"
@onready var gravityY = $"../GravityY"

func _ready():
	Engine.max_fps = fps

func _process(delta: float):
	if gravityX.text == "":
		gravity.x = gravity.x
	else:
		gravity.x = float(gravityX.text)
		
	if gravityY.text == "":
		gravity.y = gravity.y
	else:
		gravity.y = float(gravityY.text)
