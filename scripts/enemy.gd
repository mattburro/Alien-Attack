extends Area2D

signal enemy_died

@export var speed: float = 300


func _physics_process(delta):
	global_position += Vector2(-speed, 0) * delta


func die():
	enemy_died.emit()
	queue_free()


func _on_body_entered(other_body):
	other_body.take_damage()
	queue_free()
