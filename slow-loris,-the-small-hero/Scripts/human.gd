extends CharacterBody2D

@export var health:float

func _ready() -> void:
	$AnimatedSprite2D.play("default")

func damage(damage):
	$AnimationPlayer.play("damage")
	health -= damage
	if health <= 0:
		global.fire.speed -= 5
		self.queue_free()
