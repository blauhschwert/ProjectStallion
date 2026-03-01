class_name Spawner
extends Node2D

@export var obstacle: PackedScene
@export var spawn_interval: float = 1.5


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_loop()

func spawn_loop():
	while true:
		spawn_obstacle()
		await get_tree().create_timer(spawn_interval).timeout

func spawn_obstacle():
	var obstacle = obstacle.instantiate()
	var screen_size = get_viewport_rect().size
	
	obstacle.global_position = Vector2(
		randf_range(0+30, screen_size.x-30),
		randf_range(0+85, screen_size.y-50)
	)
	
	add_child(obstacle)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
