extends Node2D

@export var radius: float = 30.0
@export var color: Color = Color.ORANGE_RED
@export var mass: float = 1.0
@export var friction: float = 0.995
@export var bounciness: float = 0.75
@export var velocity = Vector2(-5, -5)
@export var force: float = 10.0

@onready var gs = $"../GlobalSettings"
@onready var wl = $"../Wall left".position.x
@onready var wr = $"../Wall right".position.x
@onready var wu = $"../Ceiling".position.y
@onready var forceF = $"../Force"
@onready var circle = $"../Circle"

@onready var pushPower = $"../Push Power"

var grv = Vector2(0, 0)
var v2mass

func _ready() -> void:
	v2mass = Vector2(mass, mass)
	queue_redraw()

func _draw() -> void:
	draw_circle(Vector2.ZERO, radius, color)

func _process(delta: float):
	if pushPower.text == "":
		force = force
	else:
		force = float(pushPower.text)
	grv = -(gs.gravity)

func _physics_process(delta: float):
	velocity += (grv * v2mass) * delta
	
	if position.y >= -radius:
		position.y = -radius
		velocity.y = -velocity.y * bounciness
		
	if Input.is_action_just_pressed("leftF"):
		velocity.x -= force
	if Input.is_action_just_pressed("rightF"):
		velocity.x += force
	if Input.is_action_just_pressed("upF"):
		velocity.y -= force
		
	if wl + radius >= position.x:
		position.x = radius + wl
		velocity.x = -velocity.x * bounciness
	if wr - radius <= position.x:
		position.x = wr - radius
		velocity.x = -velocity.x * bounciness
	if wu + radius >= position.y:
		position.y = radius + wu
		velocity.y = -velocity.y * bounciness
		
	if self.global_position.distance_to(circle.global_position) < (radius + circle.radius):
		position += (self.global_position - circle.global_position).normalized() * ((radius + circle.radius - self.global_position.distance_to(circle.global_position)) / 2)
		velocity = velocity + ((self.global_position - circle.global_position) * bounciness).normalized()
	
	var force_direction: Vector2 = (self.global_position - forceF.global_position).normalized()
	velocity += force_direction * forceF.force * delta
	
	velocity = velocity * friction
	position += velocity
	#print(position)
	#print(velocity)
