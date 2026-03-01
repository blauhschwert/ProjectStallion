class_name Spawner
extends Node2D

@export var bandit_00: PackedScene
@export var bandit_01: PackedScene
@export var bandit_02: PackedScene

@export var spawn_interval: float = 1.5

var bandits : Array[PackedScene] = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bandits.append(bandit_00)
	bandits.append(bandit_01)
	bandits.append(bandit_02)
	spawn_loop()

func spawn_loop():
	while true:
		spawn_obstacle()
		await get_tree().create_timer(spawn_interval).timeout

func spawn_obstacle():
	var enemy = bandits.pick_random().instantiate()
	var screen_size = get_viewport_rect().size
	
	enemy.global_position = Vector2(
		randf_range(0+30, screen_size.x-135),
		randf_range(0+85, screen_size.y-100)
	)
	
	add_child(enemy)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
