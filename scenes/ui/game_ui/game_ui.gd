extends Control

signal score_updated(amount)
signal remove_hearth
signal game_over

const HEART = preload("res://assets/etc/Heart.png")

var hearts_container = []
var game_score : int = 0

@onready var hearts: HBoxContainer = %Hearts
@onready var score: Label = %Score


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score_updated.connect(_increase_game_score)
	remove_hearth.connect(_remove_health)
	
	for i in range(3):
		var new_heart = TextureRect.new()
		new_heart.texture = HEART
		new_heart.EXPAND_FIT_WIDTH_PROPORTIONAL
		hearts.add_child(new_heart)
		hearts_container.append(new_heart)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	update_game_score()
	
	if hearts.get_child_count() <= 0:
		game_over.emit()


func update_game_score():
	score.text = str(game_score).pad_zeros(6)

func _increase_game_score(p_amount) -> void:
	game_score += p_amount

func _remove_health() -> void:
	var health_change : TextureRect
	health_change = hearts.get_children().pop_back()
	health_change.queue_free()
