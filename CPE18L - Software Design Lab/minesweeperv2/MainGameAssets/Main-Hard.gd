extends Node2D

#Game variables
const TOTAL_MINES : int = 60
var high_score : int = 0
var time_elapsed : float
var remaining_mines : int
var first_click : bool

enum GameState { PLAYING, PAUSED, GAME_OVER }
var current_state = GameState.PLAYING

# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()
	$PauseMenu.requested_pause.connect(_on_pause_menu_requested_pause)
	$PauseMenu.requested_resume.connect(_on_pause_menu_requested_resume)
	$PauseMenu.requested_restart_game.connect(_on_pause_menu_requested_restart_game)

	$TileMap.flag_placed.connect(_on_tile_map_flag_placed)
	$TileMap.flag_removed.connect(_on_tile_map_flag_removed)
	$TileMap.end_game.connect(_on_tile_map_end_game)
	$TileMap.game_won.connect(_on_tile_map_game_won)

func new_game():
	current_state = GameState.PLAYING
	first_click = true
	time_elapsed = 0
	remaining_mines = TOTAL_MINES
	$TileMap.new_game()
	$GameOver.hide()
	$PauseMenu.hide()
	get_tree().paused = false
	$HUD.get_node("Highscore3").text = str(high_score)

func _process(delta):
	if current_state == GameState.PLAYING:
		if !first_click:
			time_elapsed += delta
		$HUD.get_node("RemainingMines3").text = str(remaining_mines)
		$HUD.get_node("Stopwatch3").text = str(int(time_elapsed))

func end_game(result):
	current_state = GameState.GAME_OVER
	get_tree().paused = true
	$GameOver.show()
	$PauseMenu.hide()
	if result == 1:
		$GameOver.get_node("Label").text = "YOU WIN!"
		var time_taken = int(time_elapsed)
		if high_score == 0 or time_taken < high_score:
			high_score = time_taken
	else:
		$GameOver.get_node("Label").text = "SABOG!"

func _on_tile_map_hard_end_game():
	print("Game Over! The end_game signal was received.")
	$TileMap.show_mines()
	$TileMap.show_uncollected_powerups() # <--- Add this line

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
