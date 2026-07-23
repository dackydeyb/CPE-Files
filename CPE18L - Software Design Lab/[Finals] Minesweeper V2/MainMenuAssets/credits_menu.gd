extends Control


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://MainMenuAssets/menu.tscn")


func _on_back_button_mouse_entered():
	$Hover.play()
