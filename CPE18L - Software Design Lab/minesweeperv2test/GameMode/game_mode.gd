extends Control


func _on_single_player_button_pressed():
	get_tree().change_scene_to_file("res://GameMode/difficulty.tscn")

func _on_multi_player_button_pressed():
	get_tree().change_scene_to_file("res://GameMode/multiplayer.tscn")

func _on_button_pressed():
	get_tree().change_scene_to_file("res://MainMenuAssets/menu.tscn")
