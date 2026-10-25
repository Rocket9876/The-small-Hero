extends Node2D

func _ready() -> void:
	global.active_scene = self
	Ui.Health_bar.visible = true

func wall():
	pass


func _on_boss_fightzone_body_entered(body) -> void:
	if global.player.in_boss == false and body.is_in_group("player"):
		global.player.start_boss()
		global.boss.start_boss()
