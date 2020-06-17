extends Node2D

signal direction(which)
signal button_up()

var dragging = false

func _process(delta):
	if dragging:
		var mousepos = get_global_mouse_position()
		var donutpos = self.global_position
		#if abs(mousepos.x - donutpos.x) < 35 and abs(mousepos.y - donutpos.y) < 35:
		$Thumb.global_position = Vector2(mousepos.x, mousepos.y)

func _set_drag():
	dragging=!dragging
	if not dragging: $Thumb.global_position = self.global_position

func _on_Thumb_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			_set_drag()
		elif event.button_index == BUTTON_LEFT and !event.pressed:
			_set_drag()
	elif event is InputEventScreenTouch:
		if event.pressed and event.get_index() == 0:
			_set_drag()
		if event.released and event.get_index == 0:
			_set_drag()

func _on_Up_body_entered(body):
	print("up")
	emit_signal("direction", "up")

func _on_Right_body_entered(body):
	print("right")
	emit_signal("direction", "right")

func _on_Down_body_entered(body):
	print("down")
	emit_signal("direction", "down")

func _on_Left_body_entered(body):
	print("left")
	emit_signal("direction", "left")

func _on_Body_exited(b):
	print("released")
	emit_signal("button_up")
