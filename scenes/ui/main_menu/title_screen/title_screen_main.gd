class_name TitleScreenMain
extends Control

signal select_levels
signal show_options


@onready var title_screen = %TitleScreen

# Called when the node enters the scene tree for the first time.
func _ready():
	title_screen.text = ProjectSettings.get_setting("application/config/name")


func _on_start_button_pressed():
	hide()
	select_levels.emit()


func _on_options_button_pressed():
	hide()
	show_options.emit()


func _on_exit_button_pressed():
	get_tree().quit()
