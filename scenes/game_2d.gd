class_name Game2D
extends Node2D

enum GameState {TITLE, OPTIONS, GAME}

var game_mode : GameState = GameState.TITLE 

@onready var player: Player = $Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.set_physics_process(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match game_mode:
		GameState.TITLE:
			pass
		GameState.OPTIONS:
			pass
		GameState.GAME:
			player.set_physics_process(true)
		_:
			pass


func _on_main_menu_game_starded() -> void:
	game_mode = GameState.GAME
