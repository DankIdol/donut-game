extends Node2D

func _ready():
	pass # Replace with function body.



func _on_Button_pressed():
	$Tween.interpolate_property($menubg, "scale", Vector2(1, 1), Vector2(.1, .1), .5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.interpolate_property($Label, "scale", Vector2(1, 1), Vector2(.1, .1), .5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.interpolate_property($Sprite, "scale", Vector2(1, 1), Vector2(.1, .1), .5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()

func _on_Tween_tween_all_completed():
	get_tree().change_scene("res://Scenes/Game.tscn")
