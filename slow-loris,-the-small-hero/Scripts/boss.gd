extends Node2D

@onready var camera = $Camera2D
var active = false
var stage = 0
@onready var leg = $"Stage 1 leg/leg"
@export var leg_downwards_speed:float
@export var leg_upwards_speed:float
@export var leg_height:float
var leg_downwards = false
@export var leg_damage:float
@export var stage_1_health:float
var health = 0
func _ready() -> void:
	camera = $Camera2D
	global.boss = self

func _physics_process(delta: float) -> void:
	if stage == 1:
		global.fire.position.x = 0
		leg.velocity.x = 0
		print(3)
		if leg_downwards:
			pass
			if leg.is_on_floor():
				print(5)
				leg_downwards = false
				leg.velocity.y = leg_upwards_speed
		else:
			leg.velocity.y = leg_upwards_speed
			if leg.position.y <= leg_height:
				stomp()
		leg.move_and_slide()
		if health <= 0:
			stage = 2
			health = 200
	elif stage == 2:
		global.fire.position.x = 0
		$AnimationPlayer2.play("swipe")
		if leg_downwards:
			
			if leg.is_on_floor():
				print(5)
				leg_downwards = false
				leg.velocity.y = leg_upwards_speed
		else:
			leg.velocity.y = leg_upwards_speed
			if leg.position.y <= leg_height:
				stomp()
		leg.move_and_slide()
		if health <= 0:
			Ui.Health_bar.visible = false
			get_tree().change_scene_to_file("res://Scenes/won.tscn")
		

func stomp(delta = 0):
	print(2)
	leg.global_position.x = global.player.position.x
	leg.velocity.y = leg_downwards_speed
	leg.position.y = leg_height
	leg_downwards = true


func _on_area_2d_body_entered(body) -> void:
	if stage == 1 and leg_downwards and body.is_in_group("player"):
		body.take_damage(leg_damage)

func start_boss():
	health = stage_1_health
	stage = 1
	stomp()

func damage(damage):
	$AnimationPlayer.play("damage")
	health -= damage
