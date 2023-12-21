extends Node2D

var player_lives = 3
var score = 0

var game_over_scene = preload("res://scenes/game_over_screen.tscn")

@onready var player = $Player
@onready var hud = $UI/HUD


func _ready():
	player.player_damaged.connect(on_player_damaged)
	hud.set_score_label(score)
	hud.set_lives_label(player_lives)


func on_deathzone_area_entered(other_area):
	if player_lives > 0:
		on_player_damaged()
	
	other_area.queue_free()


func on_player_damaged():
	player_lives -= 1
	hud.set_lives_label(player_lives)
	$PlayerHitSound.play()
	
	if player_lives == 0:
		game_over()

func game_over():
	player.die()
	await get_tree().create_timer(1).timeout
	var game_over_instance = game_over_scene.instantiate()
	game_over_instance.set_score_label(score)
	$UI.add_child(game_over_instance)

func on_enemy_died():
	score += 100
	hud.set_score_label(score)
	$EnemyHitSound.play()


func on_enemy_spawner_enemy_spawned(enemy_instance):
	$Enemies.add_child(enemy_instance)
	enemy_instance.enemy_died.connect(on_enemy_died)


func on_enemy_spawner_path_enemy_spawned(path_enemy_instance):
	$Enemies.add_child(path_enemy_instance)
	path_enemy_instance.enemy.enemy_died.connect(on_enemy_died)
