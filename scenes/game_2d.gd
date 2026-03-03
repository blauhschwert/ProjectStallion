class_name Game2D
extends Node2D

enum GameState {TITLE, OPTIONS, GAME, GAME_OVER}

var game_mode: GameState = GameState.TITLE

var score_rewards = [5, 10, 25]

@onready var player: Player = $Player
@onready var spawner: Spawner = $Spawner

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AudioStreamPlayer.play()
	player.set_physics_process(false)
	spawner.enemy_spawned.connect(_on_spawner_enemy_spawned)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	match game_mode:
		GameState.TITLE:
			pass
		GameState.OPTIONS:
			pass
		GameState.GAME:
			$GameUI.show()
			player.set_physics_process(true)
		GameState.GAME_OVER:
			$GameOver.show()
		_:
			pass


func _on_main_menu_game_starded() -> void:
	game_mode = GameState.GAME


func _on_spawner_enemy_spawned(enemy: EnemyBase) -> void:
	enemy.enemy_defeated.connect(_on_enemy_defeated)


func _on_enemy_defeated() -> void:
	if game_mode == GameState.GAME:
		$GameUI/GameUI.score_updated.emit(score_rewards.pick_random())


func _on_player_take_damage() -> void:
	$GameUI/GameUI.remove_hearth.emit()


func _on_game_ui_game_over() -> void:
	player.set_physics_process(false)
	$Spawner.end_game()
	game_mode = GameState.GAME_OVER
