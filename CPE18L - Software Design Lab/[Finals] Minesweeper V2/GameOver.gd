extends CanvasLayer

signal restart

func _on_restart_button_pressed():
	restart.emit()


func _on_restart_button_mouse_entered():
	$Hover.play()
