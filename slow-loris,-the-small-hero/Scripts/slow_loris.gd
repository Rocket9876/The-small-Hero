extends CharacterBody2D

const gravity_acceleration = 200
@export var speed:float
@onready var AnimationController = $AnimatedSprite2D
@onready var poison_arrow = $"poison arrow"
@onready var collision = $CollisionShape2D
var wall = null

var health = 100

@export var jump_strength:float
@export var dash_speed:float
var animation = "idle"
var direction = "right"
var horizontal_motion = 0
var dash_activated = false
var mouse_position_to_player = get_local_mouse_position()

var in_fire = false

var in_boss = false


func _ready() -> void:
	global.player = self
	Ui.Health_bar.value = health
	

func _physics_process(delta: float) -> void:
	start_fire()
	end_fire()
	void_damage()
	start_wall()
	mouse_position_to_player = get_local_mouse_position()
	shoot()
	if not wall:
		gravity(delta)
	movement()
	if Input.is_action_just_pressed("shoot"):
		global.create_poison_projektile()
	
	if not is_on_floor() and not wall:
		animation = "air"
	if animation == "air" and is_on_ceiling() and horizontal_motion < 0:
		horizontal_motion = 0 
	dash()
	_AnimationPlayer()
	if not wall:
		velocity.y = horizontal_motion
	move_and_slide()
	if wall:
		velocity.x = 0
	if not is_on_wall():
		end_wall()
	#print(atan(mouse_position_to_player.y/mouse_position_to_player.x))

func movement():
	if not wall:
		if Input.is_action_pressed("right") and not dash_activated:
			velocity.x = speed
			animation = "run"
			direction = "right"
		elif Input.is_action_pressed("left") and not dash_activated:
			velocity.x = -speed
			animation = "run"
			direction = "left"
		else:
			velocity.x = 0
			animation = "idle"
	if wall:
		if Input.is_action_pressed("up"):
			velocity.y = -speed
			animation = "run"
			direction = "right"
			if wall == "left":
				direction = "left"
		elif Input.is_action_pressed("down"):
			velocity.y = speed
			animation = "run"
			direction = "left"
			if wall == "left":
				direction = "right"
		else:
			velocity.y = 0
			animation = "idle"
	
	
	if (is_on_floor() and Input.is_action_just_pressed("jump")) or (wall and Input.is_action_just_pressed("jump")):
		horizontal_motion = -jump_strength
		if wall == "left":
			position.x += 3
		if wall == "right":
			position.x -= 3
		end_wall()
		
	
	
	

func _AnimationPlayer():
	if direction == "left":
		AnimationController.flip_h = true
	else:
		AnimationController.flip_h = false
	AnimationController.play(animation)
	
func gravity(delta):
	horizontal_motion += gravity_acceleration * delta
	if is_on_floor():
		horizontal_motion = 0
	
	
func dash():
	if Input.is_action_just_pressed("dash") and not is_on_floor() and not wall:
		dash_activated = true
	if dash_activated:
		horizontal_motion = dash_speed
		animation = "dash"
	if is_on_floor():
		dash_activated = false

func shoot():
	poison_arrow.look_at(get_global_mouse_position())
	
	
	
func start_wall():
	if is_on_wall_only() and not wall:
		horizontal_motion = 0
		$AnimationPlayer2.play("RESET")
		if get_wall_normal().x < 0:
			wall = "right"
			velocity.x = 1000
			rotate_sprite_collision(-90)
		else:
			wall = "left"
			velocity.x = -1000
			rotate_sprite_collision(90)
func rotate_sprite_collision(deg):
	collision.rotation_degrees = deg + 90
	AnimationController.rotation_degrees = deg
func end_wall():
	velocity.x = 0
	if wall == "left":
		rotate_sprite_collision(0)
	if wall == "right":
		rotate_sprite_collision(0)
	wall = null



func take_damage(damage):
	health -= damage
	$AnimationPlayer.play("take damage")
	Ui.Health_bar.value = health
	if health <= 0:
		get_tree().change_scene_to_file("res://Scenes/death_screen.tscn")

func void_damage():
	if position.y > 3000:
		take_damage(200)

func start_fire():
	if global.fire.position.x > position.x and not in_fire:
		$AnimationPlayer.play("fire_start")
		in_fire = true
		$fire_damage.start()

func end_fire():
	if global.fire.position.x < position.x and in_fire:
		$fire_damage.stop()
		in_fire = false
		$AnimationPlayer.play("fire end")
		$damage.color = Color(0,0,0,0)




func _on_fire_damage_timeout() -> void:
	take_damage(5)





func start_boss():
	position.x = global.boss.position.x
	position.y = global.boss.position.y
	$Camera2D.enabled = false
	global.boss.camera.enabled = true
	in_boss = true
	


func boss_loop():
	if in_boss:
		pass
