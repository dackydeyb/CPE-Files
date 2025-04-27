extends Node2D

#Game variables
const TOTAL_MINES : int = 10
var high_score : int = 0
var time_elapsed : float
var remaining_mines : int
var first_click : bool

enum GameState { PLAYING, PAUSED, GAME_OVER }
var current_state = GameState.PLAYING

# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()
	# Connect signals from the PauseMenu
	$PauseMenu.requested_pause.connect(_on_pause_menu_requested_pause)
	$PauseMenu.requested_resume.connect(_on_pause_menu_requested_resume)
	$PauseMenu.requested_restart_game.connect(_on_pause_menu_requested_restart_game)

func new_game():
	current_state = GameState.PLAYING # Set state to playing
	first_click = true
	time_elapsed = 0
	remaining_mines = TOTAL_MINES
	$TileMap.new_game()
	$GameOver.hide()
	$PauseMenu.hide() # Ensure pause menu is hidden
	get_tree().paused = false
	# Update Highscore display even if unchanged, for consistency
	$HUD.get_node("Highscore").text = str(high_score)

func _process(delta):
	# Only update timer if the game is in the PLAYING state
	if current_state == GameState.PLAYING:
		if !first_click:
			time_elapsed += delta
		$HUD.get_node("Stopwatch").text = str(int(time_elapsed))
		$HUD.get_node("RemainingMines").text = str(remaining_mines)

func end_game(result):
	# Set state to game over before pausing
	current_state = GameState.GAME_OVER
	get_tree().paused = true
	$GameOver.show()
	$PauseMenu.hide() # Ensure pause menu is hidden if it was somehow open
	if result == 1:
		$GameOver.get_node("Label").text = "YOU WIN!"
		var time_taken = int(time_elapsed)
		if high_score == 0 or time_taken < high_score:
			high_score = time_taken
		$HUD.get_node("Highscore").text = str(high_score)
	else:
		$GameOver.get_node("Label").text = "SABOG!"

func get_current_state():
	return current_state

func _on_tile_map_flag_placed():
	remaining_mines -= 1
func _on_tile_map_flag_removed():
	remaining_mines += 1
func _on_tile_map_end_game():
	end_game(-1)
func _on_tile_map_game_won():
	end_game(1)
func _on_game_over_restart():
	new_game()
func _on_pause_button_pressed():
	if current_state == GameState.PLAYING and !$PauseMenu.is_visible_in_tree():
		current_state = GameState.PAUSED
		get_tree().paused = true
		$PauseMenu.show_pause_menu_animation()
func _on_pause_menu_requested_pause():
	_on_pause_button_pressed() 


func _on_pause_menu_requested_resume():
	if current_state == GameState.PAUSED:
		current_state = GameState.PLAYING
		get_tree().paused = false
		$PauseMenu.hide_pause_menu_animation()

func _on_pause_menu_requested_restart_game():
	new_game()
	
func _on_pause_menu_resumed():
	current_state = GameState.PLAYING
