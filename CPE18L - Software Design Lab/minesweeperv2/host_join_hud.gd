extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_host_button_pressed():
	get_tree().change_scene_to_file("res://GameMode/multiplayer.tscn")
	MultiplayerManager.host_game()


func _on_join_button_pressed():
	MultiplayerManager.join_game(ip_field.text)
