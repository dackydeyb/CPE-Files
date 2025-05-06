# difficulty.gd
extends Control

func _on_basic_pressed():
	get_tree().change_scene_to_file("res://main.tscn")

func _on_just_right_pressed():
	get_tree().change_scene_to_file("res://MainGameAssets/medium.tscn")

func _on_god_pressed():
	get_tree().change_scene_to_file("res://MainGameAssets/hard.tscn")


func _on_button_pressed():
	get_tree().change_scene_to_file("res://GameMode/game_mode.tscn")
