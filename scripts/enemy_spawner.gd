extends Node2D

signal enemy_spawned(enemy_instance)
signal path_enemy_spawned(path_enemy_instance)

var enemy_scene: PackedScene = preload("res://scenes/enemy.tscn")
var path_enemy_scene: PackedScene = preload("res://scenes/path_enemy.tscn")

@onready var enemy_spawn_timer = $EnemySpawnTimer
@onready var path_enemy_spawn_timer = $PathEnemySpawnTimer
@onready var spawn_positions = $SpawnPositions

func _ready():
	enemy_spawn_timer.timeout.connect(on_enemy_spawn_timer_timeout)
	path_enemy_spawn_timer.timeout.connect(on_path_enemy_spawn_timer_timeout)

func spawn_enemy():
	var spawn_positions_array = spawn_positions.get_children()
	var random_spawn_position = spawn_positions_array.pick_random()
	var enemy_instance = enemy_scene.instantiate() as Node2D
	enemy_instance.global_position = random_spawn_position.global_position
	enemy_spawned.emit(enemy_instance)

func spawn_path_enemy():
	var path_enemy_instance = path_enemy_scene.instantiate() as Node2D
	path_enemy_spawned.emit(path_enemy_instance)

func on_enemy_spawn_timer_timeout():
	spawn_enemy()

func on_path_enemy_spawn_timer_timeout():
	spawn_path_enemy()
