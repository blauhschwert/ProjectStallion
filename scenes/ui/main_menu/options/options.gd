class_name Options
extends Control

signal closed
@export_category("Options Parameter")
@export_enum("base","modern","retro","mustang") var theme_behavoir : String


var bg_panels_theme : Dictionary = {
	"base" : "res://scenes/ui/main_menu/options/options/options_name_base.tres",
	"modern" : "res://scenes/ui/main_menu/options/options/options_name_modern.tres",
	"retro" : "res://scenes/ui/main_menu/options/options/options_name_retro.tres",
	"mustang" : "res://scenes/ui/main_menu/options/options/options_name_mustang.tres"
}

var group_borders_theme : Dictionary = {
	"base" : "res://scenes/ui/main_menu/options/panel/option_base.tres",
	"modern" : "res://scenes/ui/main_menu/options/panel/option_modern.tres",
	"retro" : "res://scenes/ui/main_menu/options/panel/option_retro.tres",
	"mustang" : "res://scenes/ui/main_menu/options/panel/option_mustang.tres"
}

@onready var background = $Background

@onready var back: Button = $OptionLayout/Top/Back


@onready var volume: Panel = $OptionLayout/HSplitContainer/OptionName/Volume
@onready var fullscreen: Panel = $OptionLayout/HSplitContainer/OptionName/Fullscreen
@onready var screen_resulion: Panel = $OptionLayout/HSplitContainer/OptionName/ScreenResulion



# Called when the node enters the scene tree for the first time.
func _ready():
	var new_panel_stlye : StyleBoxFlat = load(bg_panels_theme[theme_behavoir])
	var group_name_style : StyleBoxFlat = load(group_borders_theme[theme_behavoir])
	background.add_theme_stylebox_override("panel",new_panel_stlye)
	
	#back.add_theme_stylebox_override("pa")
	
	volume.add_theme_stylebox_override("panel",group_name_style)
	fullscreen.add_theme_stylebox_override("panel",group_name_style)
	screen_resulion.add_theme_stylebox_override("panel",group_name_style)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func set_theme_bahaivor(p_theme : String) -> void:
	theme_behavoir = p_theme
	
	var new_panel_stlye : StyleBoxFlat = load(bg_panels_theme[theme_behavoir])
	var group_name_style : StyleBoxFlat = load(group_borders_theme[theme_behavoir])
	
	background.add_theme_stylebox_override("panel",new_panel_stlye)
	
	#back.add_theme_stylebox_override("pa")
	
	volume.add_theme_stylebox_override("panel",group_name_style)
	fullscreen.add_theme_stylebox_override("panel",group_name_style)
	screen_resulion.add_theme_stylebox_override("panel",group_name_style)
	


func set_background_panel(p_color : Color) -> void:
	var new_panel_stlye : StyleBoxFlat = load(bg_panels_theme[theme_behavoir])
	new_panel_stlye.bg_color = p_color
	background.add_theme_stylebox_override("panel",new_panel_stlye)

func _on_back_pressed():
	hide()
	closed.emit()
