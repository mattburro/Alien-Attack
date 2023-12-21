extends CharacterBody2D

signal player_damaged

const MOVE_SPEED = 300
const ROCKET_SPAWN_OFFSET = 60

var rocket_scene: PackedScene = preload("res://scenes/rocket.tscn")


func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		shoot()


func _physics_process(delta):
	
	var velocity_x = Input.get_axis("move_left", "move_right")
	var velocity_y = Input.get_axis("move_up", "move_down")
	velocity = Vector2(velocity_x, velocity_y) * MOVE_SPEED
	
	move_and_slide()
	
	var screen_size = get_viewport_rect().size
	global_position = global_position.clamp(Vector2.ZERO, screen_size)


func shoot():
	$ShootSound.play()
	var rocket_instance = rocket_scene.instantiate() as Node2D
	get_tree().get_first_node_in_group("rocket_group").add_child(rocket_instance)
	rocket_instance.global_position = Vector2(global_position.x + ROCKET_SPAWN_OFFSET, global_position.y)


func take_damage():
	player_damaged.emit()


func die():
	queue_free()
