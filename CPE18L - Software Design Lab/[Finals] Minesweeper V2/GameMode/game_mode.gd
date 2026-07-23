extends Control


func _on_single_player_button_pressed():
	get_tree().change_scene_to_file("res://GameMode/difficulty.tscn")

func _on_multi_player_button_pressed():
	get_tree().change_scene_to_file("res://GameMode/versus.tscn")

func _on_button_pressed():
	get_tree().change_scene_to_file("res://MainMenuAssets/menu.tscn")


func _on_single_player_button_mouse_entered():
	$Hover.play()


func _on_multi_player_button_mouse_entered():
	$Hover.play()


func _on_back_button_mouse_entered():
	$Hover.play()
