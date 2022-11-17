extends KinematicBody2D

var velocity = Vector2(1,0)
var speed = 2000
var time = 0
var collision_info_before
func _physics_process(delta):
	var collision_info = move_and_collide(velocity.normalized()*delta*speed)
	if collision_info:
		# queue_free()
		if velocity.x < 0:
			$Node2D.global_scale = Vector2(-1,1)
			
		if (collision_info.collider):
			$Node2D/Bullet.hide()
			$Node2D/BulletExplosion.show()
			var played = $AnimationPlayer.play("Explosion")
			time += delta
			if time >= 0.55:
				queue_free()
			if (collision_info.collider.name == "BasicEnemy"):
				print(collision_info.collider.damage())
