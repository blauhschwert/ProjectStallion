extends CanvasLayer

var highscore : int = 0

@onready var score: Label = $GameOver/Score



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_highscore()


func update_highscore() -> void:
	score.text = "Highscore : "  + str(highscore).pad_zeros(6)


func _on_game_ui_score_updated(amount: Variant) -> void:
	highscore = amount
