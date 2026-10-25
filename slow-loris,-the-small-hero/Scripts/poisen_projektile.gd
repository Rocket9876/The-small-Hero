extends CharacterBody2D

@export var speed:float
@export var damage:float

func _ready() -> void:
	position = global.player.position
	rotation = global.player.poison_arrow.rotation
	velocity = Vector2(cos(rotation)*speed,sin(rotation)*speed)

func _physics_process(delta: float) -> void:
	move_and_slide()



func _on_area_2d_body_entered(body) -> void:
	if body != global.player:
			$AnimationPlayer.play("splash")
			$AnimatedSprite2D.play("splash")
			velocity = Vector2(0,0)
			if body.is_in_group("human"):
				body.damage(damage)
			if body.is_in_group("boss"):
				body.get_parent().get_parent().damage(damage)
	


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	self.queue_free()
