class_name MainMenu
extends Control

signal game_starded

@export_category("Main Menu Theme")
@export_enum("base","modern","retro") var theme_behavoir : String

@export var main_color : Color = Color.ROYAL_BLUE
@export var sub_color : Color = Color.LIME_GREEN
@export var background_color : Color = Color.SLATE_GRAY

var bg_panels_theme : Dictionary = {
	"base" : "res://scenes/ui/theme/panel/bg_panel_base.tres",
	"modern" : "res://scenes/ui/theme/panel/bg_panel_modern.tres",
	"retro" : "res://scenes/ui/theme/panel/bg_panel_retro.tres"
}

@onready var background = $BackGround

func _ready():
	_create_main_menu_theme()
	$Options.set_theme_bahaivor(theme_behavoir)
	#$Options.set_background_panel()

func _create_main_menu_theme() -> void:
	# Backgorund theme
	var new_panel_stlye : StyleBoxFlat = load(bg_panels_theme[theme_behavoir])
	new_panel_stlye.bg_color = background_color
	new_panel_stlye.border_color = sub_color
	background.add_theme_stylebox_override("panel",new_panel_stlye)

func _on_game_started():
	$TitleScreenMain.hide()
	background.hide()
	game_starded.emit()


func _on_options_button_pressed():
	$Options.show()


func _on_options_closed():
	$TitleScreenMain.show()
