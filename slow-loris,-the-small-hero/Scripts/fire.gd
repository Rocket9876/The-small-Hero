extends Node2D

func _ready() -> void:
	global.fire = self
	start_fire()

@export var start_speed:float

var speed = 0

func fire_expansion(delta):
	position.x += speed * delta

func _physics_process(delta: float) -> void:
	speed += delta * 2
	fire_expansion(delta)

func start_fire():
	speed = start_speed
	
