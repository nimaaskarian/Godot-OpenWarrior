extends KinematicBody2D

const bulletPath = preload("res://nodes/Bullet.tscn")

func _ready():
	$AnimationPlayer.play("Walk")
var direction = "right"
var time = 0

func shoot():
	if time > 0: return null
	time = 0.25
	var bullet = bulletPath.instance()
	
	
	var value_to_add = Vector2(0,0)
	if direction == "left":
		bullet.velocity = Vector2(-1,0)
		value_to_add = Vector2(+50,0)
	var pos = $Node2D/Gun_fire_point.global_position - value_to_add
	bullet.global_position = pos
	get_parent().add_child(bullet)
	return bullet



func _physics_process(delta):
	if time > 0:
		time -= delta
	var new_position = position
	var is_right = Input.is_action_pressed("ui_right")
	var is_left = Input.is_action_pressed("ui_left")
	var is_down = Input.is_action_pressed("ui_down")
	var is_up = Input.is_action_pressed("ui_up")
	if is_down:
		new_position.y += 10
	if is_up:
		new_position.y -= 10
	if is_right:
		direction = "right"
		new_position.x += 10
		$Node2D.scale.x = 1
		
	if is_left:
		direction = "left"
		new_position.x -= 10
		$Node2D.scale.x = -1
		
	
	if is_right or is_left:
		position = new_position
		$AnimationPlayer.play("Walk")
	else:
		$AnimationPlayer.play("idle")
	
	if Input.is_action_pressed("ui_select"):
		$Node2D/fire.show()
		if not $AnimationPlayer2.is_playing():
			$AnimationPlayer2.play("Fire")
		shoot()
	else:
		if not $AnimationPlayer2.is_playing():
			$AnimationPlayer2.play("hidden")
	
	position = new_position
