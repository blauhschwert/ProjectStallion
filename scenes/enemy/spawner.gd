class_name Spawner
extends Node2D

signal enemy_spawned(enemy: EnemyBase)

@export var bandit_00: PackedScene
@export var bandit_01: PackedScene
@export var bandit_02: PackedScene

@export var spawn_interval: float = 1.5

var bandits: Array[PackedScene] = []

@onready var enemys: Node2D = $Enemys



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bandits.append(bandit_00)
	bandits.append(bandit_01)
	bandits.append(bandit_02)
	spawn_loop()

func spawn_loop() -> void:
	while true:
		spawn_obstacle()
		await get_tree().create_timer(spawn_interval).timeout

func spawn_obstacle() -> void:
	var enemy: EnemyBase = bandits.pick_random().instantiate()
	var screen_size = get_viewport_rect().size
	
	enemy.global_position = Vector2(
		randf_range(0+30, screen_size.x-135),
		randf_range(0+85, screen_size.y-100)
	)
	
	enemys.add_child(enemy)
	enemy_spawned.emit(enemy)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func end_game() -> void:
	for i in enemys.get_children():
		i.queue_free()
