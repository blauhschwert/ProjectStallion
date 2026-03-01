extends Control

const HEART = preload("res://assets/etc/Heart.png")

var hearts_container = [] 

@onready var hearts: HBoxContainer = %Hearts


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(3):
		var new_heart = TextureRect.new()
		new_heart.texture = HEART
		new_heart.EXPAND_FIT_WIDTH_PROPORTIONAL
		hearts.add_child(new_heart)
		hearts_container.append(new_heart)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
