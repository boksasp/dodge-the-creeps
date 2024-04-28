extends Node

@export var mob_scene: PackedScene
var score
var game_setting
var mob_velocity: Vector2
var backgrounds = [0x037051ff, 0x126cc7ff, 0x7a04baff, 0xc70493ff, 0xeddc40ff, 0x4dbdb9ff, 0xde6dd1ff, 0xf75cc58ff]
var default_background = 0x535353ff

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func gamer_over():
	$BackgroundColor.color = Color.hex(default_background)
	$ScoreTimer.stop()
	$StartTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeathSound.play()
	
func set_easy_game_setting():
	print("Game setting: EASY")
	mob_velocity = Vector2(randf_range(30.0, 70.0), 0.0)
	$MobTimer.wait_time = 5.0

func set_medium_game_setting():
	print("Game setting: MEDIUM")
	mob_velocity = Vector2(randf_range(100.0, 150.0), 0.0)
	$MobTimer.wait_time = 2

func set_hard_game_setting():
	print("Game setting: HARD")
	mob_velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	$MobTimer.wait_time = 0.5
	
func new_game():
	var game_setting_menu: OptionButton = get_node("HUD/GameSettingMenu")
	game_setting_menu.hide()
	var game_setting_index: int = game_setting_menu.selected
	
	var background_number = randi() % backgrounds.size()
	print("%x" % backgrounds[background_number])
	$BackgroundColor.color = Color.hex(backgrounds[background_number])
	
	if game_setting_index == 0:
		set_easy_game_setting()
	elif game_setting_index == 2:
		set_hard_game_setting()
	else:
		set_medium_game_setting()
	
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.show_message("Get Ready")
	$HUD.update_score(score)
	get_tree().call_group("mobs", "queue_free")
	$MobTimer.stop()
	
	if not $Music.playing:
		$Music.play()


func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate()
	
	# Choose a random location on Path2D.
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2
	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction	
	mob.linear_velocity = mob_velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)


func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)


func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
