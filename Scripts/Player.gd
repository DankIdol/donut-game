extends KinematicBody2D

signal dead

export (int) var speed = 50
var velocity = Vector2()
var bullet = preload("res://Scenes/Bullet.tscn")
var facing = Vector2(1, 0)

func _ready():
	randomize()
	
func _process(delta):
	var sc = _scale(position.y, 90, 150, 0.8, 1.2)
	scale = Vector2(sc, sc)

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
	if velocity != Vector2(0, 0):
		$AnimationPlayer.play("move")
	elif $AnimationPlayer.current_animation != "shoot":
		$AnimationPlayer.stop(true)

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		flip("right")
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		flip("left")
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	velocity = velocity.normalized() * speed

func flip(dir):
	if dir == "left":
		facing = Vector2(-1, 0)
		$Face.set_flip_h(true)
		if not $Gun.position.x < 0:
			$Gun.position.x = -$Gun.position.x
			$Gun/Muzzle.position.x = -$Gun/Muzzle.position.x
		$Gun.set_flip_h(true)
	if dir == "right":
		facing = Vector2(1, 0)
		$Face.set_flip_h(false)
		if not $Gun.position.x > 0:
			$Gun.position.x = -$Gun.position.x
			$Gun/Muzzle.position.x = -$Gun/Muzzle.position.x
		$Gun.set_flip_h(false)

func shoot():
	$AnimationPlayer.play("shoot")
	var b = bullet.instance()
	b.set_target(facing)
	b.position = $Gun/Muzzle.global_position
	get_parent().add_child(b)

func _scale(OldValue, OldMin, OldMax, NewMin, NewMax):
	var NewValue = (((OldValue - OldMin) * (NewMax - NewMin)) / (OldMax - OldMin)) + NewMin
	return NewValue

func _on_HitBox_area_entered(area):
	var collider = area.get_parent()
	if "Enemy" in collider.name and not collider.dead:
		emit_signal("dead")
