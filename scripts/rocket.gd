extends Area2D

@export var speed: float = 200
@export var acceleration: float = 30

@onready var movement_vector = Vector2(speed, 0)


func _ready():
	$VisibleOnScreenEnabler2D.screen_exited.connect(on_screen_exited)
	area_entered.connect(on_area_entered)


func _physics_process(delta):
	movement_vector.x += acceleration
	global_position += movement_vector * delta


func on_screen_exited():
	queue_free()


func on_area_entered(other_area: Area2D):
	other_area.die()
	queue_free()
