extends KinematicBody2D

signal died(me)

export (int) var speed = 25
var velocity = Vector2()
var bullet = preload("res://Scenes/Bullet.tscn")
var target = Vector2(0, 0)
var dead = false

func _ready():
	randomize()
	
func _process(delta):
	if not dead:
		if position.x < 0 or position.x > 180 or position.y < 0 or position.y > 320:
				get_parent().remove_enemy(self)
				get_parent().remove_child(self)
				queue_free()
		var sc = _scale(position.y, 90, 150, 0.8, 1.2)
		scale = Vector2(sc, sc)
#	if randi() % 100 < 5: 
#		shoot(Vector2(rand_range(-1, 1), rand_range(-1, 1)))

func _physics_process(delta):
	if not dead:
		simulate_input(target)
		velocity = move_and_slide(velocity)
		if velocity != Vector2(0, 0):
			$AnimationPlayer.play("move")
		elif $AnimationPlayer.current_animation != "shoot":
			$AnimationPlayer.stop(true)

func simulate_input(target: Vector2):
	velocity = Vector2()
	var pos = position
	var tx = target.x - pos.x
	var ty = target.y - pos.y
	if tx > 0:
		flip("right")
		velocity.x += 1
	if tx < 0:
		flip("left")
		velocity.x -= 1
	if ty > 0:
		velocity.y += 1
	if ty < 0:
		velocity.y -= 1
	velocity = velocity.normalized() * speed

func flip(dir):
	if dir == "left":
		$Face.set_flip_h(true)
	if dir == "right":
		$Face.set_flip_h(false)

func _scale(OldValue, OldMin, OldMax, NewMin, NewMax):
	return (((OldValue - OldMin) * (NewMax - NewMin)) / (OldMax - OldMin)) + NewMin

func _on_Hitbox_area_entered(area):
	var collider = area.name
	if "Bullet" in collider:
		if not dead: emit_signal("died", self)
		get_parent().remove_child(self)
		queue_free()

