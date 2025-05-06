extends Node2D

#Game variables
const TOTAL_MINES : int = 10
var high_score : int = 0
var time_elapsed : float
var remaining_mines : int
var first_click : bool

enum GameState { PLAYING, PAUSED, GAME_OVER }
var current_state = GameState.PLAYING

# References to the banner sprites and the restart button
@onready var game_over_banner : Sprite2D = get_node("GameOver/GameOverBanner")
@onready var you_win_banner : Sprite2D = get_node("GameOver/YouWinBanner")
@onready var player1_banner : Sprite2D = get_node("GameOver/Player1Wins")
@onready var player2_banner : Sprite2D = get_node("GameOver/Player2Wins")
@onready var restart_button : Button = get_node("GameOver/RestartButton")

# Called when the node enters the scene tree for the first time.
func _ready():
	# Ensure banners and the restart button are hidden at the start
	game_over_banner.hide()
	you_win_banner.hide()
	restart_button.hide() # Hide the restart button initially

	new_game()
	# Connect signals from the PauseMenu
	$PauseMenu.requested_pause.connect(_on_pause_menu_requested_pause)
	$PauseMenu.requested_resume.connect(_on_pause_menu_requested_resume)
	$PauseMenu.requested_restart_game.connect(_on_pause_menu_requested_restart_game)
	$GameOver.restart.connect(_on_game_banners_restart)


func new_game():
	current_state = GameState.PLAYING # Set state to playing
	first_click = true
	time_elapsed = 0
	remaining_mines = TOTAL_MINES
	$TileMap.new_game()
	game_over_banner.hide()
	you_win_banner.hide()
	restart_button.hide()
	player1_banner.hide()
	player2_banner.hide()
	$PauseMenu.hide()
	get_tree().paused = false
	$HUD.get_node("Highscore").text = str(high_score)

func _process(delta):
	# Only update timer if the game is in the PLAYING state
	if current_state == GameState.PLAYING:
		if !first_click:
			time_elapsed += delta
		$HUD.get_node("Stopwatch").text = str(int(time_elapsed))
		$HUD.get_node("RemainingMines").text = str(remaining_mines)

func end_game(result):
	current_state = GameState.GAME_OVER
	get_tree().paused = true
	player1_banner.hide()
	player2_banner.hide()
	$PauseMenu.hide()
	var timer = get_tree().create_timer(2.0) # Initial 2-second delay
	timer.timeout.connect(func():
		restart_button.show()
		if result == 1: # Game Won
			you_win_banner.show()
			game_over_banner.hide()
			var time_taken = int(time_elapsed)
			if high_score == 0 or time_taken < high_score:
				high_score = time_taken
			$HUD.get_node("Highscore").text = str(high_score)
		else: # Game Over
			game_over_banner.show()
			you_win_banner.hide()
		
		# Add a new timer to hide banners after 3 seconds
		var hide_timer = get_tree().create_timer(3.0)
		hide_timer.timeout.connect(func():
			you_win_banner.hide()
			game_over_banner.hide()
		)
	)


# Function to handle restart signal from the CanvasLayer
func _on_game_banners_restart():
	new_game()

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
