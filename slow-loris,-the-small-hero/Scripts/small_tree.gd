extends Node2D

func _ready() -> void:
	$AnimatedSprite2D.play("normal")

func _physics_process(delta: float) -> void:
	if global.fire.position.x > position.x:
		$AnimatedSprite2D.play("fire")
