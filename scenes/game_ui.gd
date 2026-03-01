class_name GameUI
extends CanvasLayer

@export var combo_activation_kills: int = 2
@export var combo_base_duration: float = 2.5
@export var combo_min_duration: float = 0.8
@export var combo_duration_step: float = 0.18
@export var base_kill_score: int = 100

var combo_kill_count: int = 0
var combo_time_remaining: float = 0.0
var score: int = 0

@onready var score_label: Label = $GameUI/BoxContainer/Score
@onready var multiplier_label: Label = $GameUI/BoxContainer/Multiplier
@onready var combo_row: HBoxContainer = $GameUI/BoxContainer/ComboRow
@onready var combo_bar: ProgressBar = $GameUI/BoxContainer/ComboRow/ComboBar


func _ready() -> void:
	_update_score_label()
	_update_multiplier_label()
	_reset_combo()


func _process(delta: float) -> void:
	if combo_kill_count == 0:
		return

	combo_time_remaining = maxf(combo_time_remaining - delta, 0.0)
	_update_combo_ui()

	if combo_time_remaining <= 0.0:
		_reset_combo()


func register_kill() -> void:
	combo_kill_count += 1
	score += base_kill_score * _get_score_multiplier()
	combo_time_remaining = _get_combo_duration(combo_kill_count)
	_update_score_label()
	_update_combo_ui()


func _get_combo_duration(kill_count: int) -> float:
	var extra_kills: int = max(kill_count - combo_activation_kills, 0)
	var duration: float = combo_base_duration - float(extra_kills) * combo_duration_step
	return maxf(duration, combo_min_duration)


func _get_score_multiplier() -> int:
	if combo_kill_count < combo_activation_kills:
		return 1

	return combo_kill_count - combo_activation_kills + 2


func _update_combo_ui() -> void:
	_update_multiplier_label()

	if combo_kill_count < combo_activation_kills:
		combo_row.hide()
		return

	combo_row.show()
	combo_bar.max_value = _get_combo_duration(combo_kill_count)
	combo_bar.value = combo_time_remaining


func _reset_combo() -> void:
	combo_kill_count = 0
	combo_time_remaining = 0.0
	combo_bar.value = 0.0
	_update_multiplier_label()
	combo_row.hide()


func _update_score_label() -> void:
	score_label.text = "%08d" % score


func _update_multiplier_label() -> void:
	multiplier_label.text = "x%d" % _get_score_multiplier()
