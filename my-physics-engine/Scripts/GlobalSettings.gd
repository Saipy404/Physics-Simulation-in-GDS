extends Node2D

@export var fps = 60
@export var floor = 0
@export var gravity = Vector2(0, -9.81)

func _ready():
	Engine.max_fps = fps
