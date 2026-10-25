extends Node2D

@export var damage:float

var player = null

func _on_area_2d_body_entered(body) -> void:
	if body.is_in_group("player"):
		body.take_damage(damage)
		player = body
		$Timer.start()


func _on_area_2d_body_exited(body) -> void:
	if body == player:
		player = null


func _on_timer_timeout() -> void:
	if player:
		player.take_damage(damage)
	else:
		$Timer.stop()
