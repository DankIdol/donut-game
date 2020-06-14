extends Area2D

var velocity = Vector2(1, 0)
var speed = .1
var enemy: bool

func _ready():
	pass
	
func _physics_process(delta):
	if position.x < 0 or position.x > 180\
		or position.y < 0 or position.y > 320:
			get_parent().remove_child(self)
			queue_free()
	position += velocity

func set_target(target: Vector2):
	$Particles2D.process_material.gravity = Vector3(target.x * -100, 0, 0)
	velocity = target

func _clamp(val):
	if val < 0: return -1
	else: return 1
