class_name EnemyBase
extends Area2D

signal enemy_defeated

@export var speed: float = 150.0

var direction: Vector2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	direction = Vector2(
		randf_range(-1.0, 1.0),
		randf_range(-1.0, 1.0)
	).normalized()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += direction * speed * delta


func defeat() -> void:
	enemy_defeated.emit()
	queue_free()
