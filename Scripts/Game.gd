extends Node2D

var cloud = preload("res://Scenes/Cloud.tscn")
var enemies = []
var enemy = preload("res://Scenes/Enemy.tscn")
var score = 0
var level = 1

func _ready():
	randomize()

func _process(delta):
	lvl_up()
	$ScoreLabel.text = "score: " + str(score)
	$LevelLabel.text = "level: " + str(level)
	for e in enemies:
		e.target = $Player.global_position
	if randi() % 10 < 8:
		var c = cloud.instance()
		c.position.x = 180 + 50
		c.position.y = rand_range(0, 320)
		add_child(c)
	if randi() % 100 < level:
		spawn()

func remove_enemy(e):
	if not e == null:
		enemies.remove(enemies.find(e))

func spawn():
	var e = enemy.instance()
	e.connect("died", self, "_on_enemy_died")
	var spawn = randi() % 4
	var spawn_point
	var spawn_sign
	if spawn == 0: 
		spawn_point = $Spawner0
		spawn_sign = $Spawner0/Sprite
	if spawn == 1: 
		spawn_point = $Spawner1
		spawn_sign = $Spawner1/Sprite
	if spawn == 2: 
		spawn_point = $Spawner2
		spawn_sign = $Spawner2/Sprite
	if spawn == 3: 
		spawn_point = $Spawner3
		spawn_sign = $Spawner3/Sprite
	e.global_position = spawn_point.global_position
	
	spawn_sign.visible = true
	yield(get_tree().create_timer(0.5), "timeout")
	
	spawn_sign.visible = false
	enemies.append(e)
	add_child(e)

func lvl_up():
	if score > 10: level = score / 10

func _on_enemy_died(e):
	if not e == null:
		enemies.remove(enemies.find(e))
	$DeathPlayer.play()
	score += 1

func _on_ShotTimer_timeout():
	if len(enemies) > 0:
		$Player.shoot()

func _on_Player_dead():
	get_tree().change_scene("res://Scenes/Menu.tscn")
