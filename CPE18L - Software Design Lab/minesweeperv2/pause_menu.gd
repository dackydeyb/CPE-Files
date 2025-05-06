extends Control

signal requested_pause
signal requested_resume
signal requested_restart_game 

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	$AnimationPlayer.process_mode = Node.PROCESS_MODE_ALWAYS
	$AnimationPlayer.play("RESET")
	hide()

func show_pause_menu_animation():
	show()
	$AnimationPlayer.play("blur")

func hide_pause_menu_animation():
	$AnimationPlayer.play_backwards("blur")
	await $AnimationPlayer.animation_finished
	hide()

func _on_resume_button_pressed():
	requested_resume.emit()

func _on_restart_button_pressed():
	$AnimationPlayer.play_backwards("blur")
	await $AnimationPlayer.animation_finished
	hide()
	requested_restart_game.emit()

func _on_quit_button_pressed():
	get_tree().paused = false # Ensure tree is unpaused before changing scene
	get_tree().change_scene_to_file("res://MainMenuAssets/menu.tscn")

func _unhandled_input(event):
	if event.is_action_pressed("esc"):
		var main_node = get_parent()
		if main_node and main_node.has_method("get_current_state"):
			var game_state = main_node.get_current_state()
			if game_state == main_node.GameState.GAME_OVER:
				return
			if is_visible_in_tree() and game_state == main_node.GameState.PAUSED:
				requested_resume.emit()
			elif !is_visible_in_tree() and game_state == main_node.GameState.PLAYING:
				requested_pause.emit()
