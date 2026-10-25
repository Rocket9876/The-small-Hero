extends Node2D

func _physics_process(delta: float) -> void:
	if global.fire.position.x > position.x:
		$AnimatedSprite2D.visible = true
		$AnimatedSprite2D.play("fire")
