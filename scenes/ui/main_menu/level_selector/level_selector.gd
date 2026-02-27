class_name LevelSelector
extends Control

func _on_level_moon_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/moon_level.tscn")

func _on_level_helloween_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/helloween_level.tscn")
