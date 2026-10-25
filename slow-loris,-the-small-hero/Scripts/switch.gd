extends Node2D

@export var activation_signal:Node
var activated = false
func _ready() -> void:
	$AnimatedSprite2D.play("normal")


func _on_area_2d_body_entered(body) -> void:
	print(body.is_in_group("player"))
	if body.is_in_group("player") and not activated:
		if body.dash_activated:
			$AnimatedSprite2D.play("pushed")
			$StaticBody2D/normal.set_deferred("disabled",1)
			activated = true
			activation_signal.activate()
	if body.is_in_group("poison") and not activated:
		$AnimatedSprite2D.play("pushed")
		$StaticBody2D/normal.set_deferred("disabled",1)
		activated = true
		activation_signal.activate()
