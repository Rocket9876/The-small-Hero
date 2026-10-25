extends Node

var fire
var player
const poison_projektile = preload("res://Scenes/poisen_projektile.tscn")
var active_scene
var player_health = 100
var boss

func _ready() -> void:
	pass

func create_poison_projektile():
	active_scene.add_child(poison_projektile.instantiate())

func debug():
	if player.in_boss:
		player.position = boss.leg.position

func _physics_process(delta: float) -> void:
	#debug()
	pass
