extends Node2D

var target

func _ready():
	randomize()
	target = Vector2(rand_range(0.5, 1.5), 0)

func _process(delta):
	position -= target
