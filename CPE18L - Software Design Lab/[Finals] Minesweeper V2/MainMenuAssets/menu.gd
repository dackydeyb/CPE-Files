extends Control

func _on_exit_pressed():
	get_tree().quit()
func _on_exit_mouse_entered():
	$Hover.play()

func _on_play_pressed():
	get_tree().change_scene_to_file("res://GameMode/game_mode.tscn")
func _on_play_mouse_entered():
	$Hover.play()

func _on_credits_pressed():
	get_tree().change_scene_to_file("res://MainMenuAssets/creditsMenu.tscn")
func _on_credits_mouse_entered():
	$Hover.play()
