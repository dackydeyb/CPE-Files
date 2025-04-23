extends Control

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS  # Godot 4 equivalent
	$AnimationPlayer.process_mode = Node.PROCESS_MODE_ALWAYS
	$AnimationPlayer.play("RESET")
	hide()

func pause_game():
	show()
	$AnimationPlayer.play("blur")
	await $AnimationPlayer.animation_finished
	get_tree().paused = true

func resume_game():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	await $AnimationPlayer.animation_finished
	hide()

func _on_resume_button_pressed():
	resume_game()

func _on_restart_button_pressed():
	resume_game()
	get_tree().reload_current_scene()

func _on_quit_button_pressed():
	get_tree().quit()

func _unhandled_input(event):
	if event.is_action_pressed("esc"):
		if get_tree().paused:
			resume_game()
		else:
			pause_game()
