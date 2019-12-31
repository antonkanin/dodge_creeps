extends Node

export (PackedScene) var Mob
var score

func _ready():
#	randomize()
	#AudioServer.set_bus_mute(0, true) # disable music for debug purposes
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeathSound.play(10)

func new_game():
	score = 0
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$Player.start($StartPosition.position)
	$Music.play(22)
	$StartTimer.start()

func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

func _on_MobTimer_timeout():
	# choose a random location on Path2D
	$MobPath/MobSpawnLocation.set_offset(randi())
	
	# create a mob instance and add it to the scene
	var mob = Mob.instance()
	
	add_child(mob)
	
	# set the mob's direaction perpendicular to the path direction
	var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
	
	# set the mob's position to a random location
	mob.position = $MobPath/MobSpawnLocation.position
	
	# add some randomness to the direction
	direction += rand_range(-PI / 4, PI / 2)
	mob.rotation = direction
	
	# set the velocity (speed & direction)
	mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = mob.linear_velocity.rotated(direction)