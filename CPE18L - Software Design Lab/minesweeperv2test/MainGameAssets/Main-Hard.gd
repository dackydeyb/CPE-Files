extends Node2D

#Game variables
const TOTAL_MINES : int = 60
var high_score : int = 0
var time_elapsed : float
var remaining_mines : int
var first_click : bool

# Slowdown Power-up Variables
var slowdown_active : bool = false
var slowdown_duration : float = 5.0 # Duration of slowdown in seconds
var slowdown_timer : float = 0.0 # Timer for active slowdown
var slowdown_probability : float = 0.05 # 50% chance to activate
var guaranteed_slowdowns_remaining : int = 5
var original_stopwatch_color : Color
var slowdown_tween : Tween # For fade effect

enum GameState { PLAYING, PAUSED, GAME_OVER }
var current_state = GameState.PLAYING

# References to the banner sprites and the restart button
@onready var game_over_banner : Sprite2D = get_node("GameOver/GameOverBanner")
@onready var you_win_banner : Sprite2D = get_node("GameOver/YouWinBanner")
@onready var player1_banner : Sprite2D = get_node("GameOver/Player1Wins")
@onready var player2_banner : Sprite2D = get_node("GameOver/Player2Wins")
@onready var restart_button : Button = get_node("GameOver/RestartButton") # Get reference to the RestartButton
@onready var gameOverSound : AudioStreamPlayer2D = get_node("GameOver/GameOverSound")
@onready var stopwatch_label : Label # Reference to the stopwatch label in HUD
@onready var freeze_effect_player : AudioStreamPlayer2D # Reference to the FreezeEffect sound player

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

	# Connect signals from the TileMap
	$TileMap.flag_placed.connect(_on_tile_map_flag_placed)
	$TileMap.flag_removed.connect(_on_tile_map_flag_removed)
	$TileMap.end_game.connect(_on_tile_map_end_game)
	$TileMap.game_won.connect(_on_tile_map_game_won)

	$GameOver.restart.connect(_on_game_over_restart_signal) # Connect to the restart signal from GameOver

	# Get the stopwatch label and store its original color
	stopwatch_label = $HUD.get_node("Stopwatch3")
	if stopwatch_label:
		original_stopwatch_color = stopwatch_label.modulate
	else:
		push_warning("Stopwatch label node not found in HUD. Color changes will not work.")

	# Setup FreezeEffect player
	freeze_effect_player = get_node("FreezeEffect")
	if freeze_effect_player:
		freeze_effect_player.stream = load("res://Musics/Freeze_Spell.ogg")
	else:
		push_warning("FreezeEffect node not found. Sound will not play.")

func new_game():
	current_state = GameState.PLAYING
	first_click = true
	time_elapsed = 0
	remaining_mines = TOTAL_MINES
	$TileMap.new_game()
	# Hide both banners and the restart button when starting a new game
	game_over_banner.hide()
	you_win_banner.hide()
	restart_button.hide()
	player1_banner.hide()
	player2_banner.hide()
	$PauseMenu.hide()
	get_tree().paused = false
	$HUD.get_node("Highscore3").text = str(high_score)
	# Reset slowdown power-up
	slowdown_active = false
	slowdown_timer = 0.0
	guaranteed_slowdowns_remaining = 3 # Reset guaranteed uses
	if stopwatch_label:
		stopwatch_label.modulate = original_stopwatch_color # Reset color
	if slowdown_tween and slowdown_tween.is_valid():
		slowdown_tween.kill() # Stop any active tween

func activate_slowdown_powerup():
	if !slowdown_active:
		slowdown_active = true
		slowdown_timer = slowdown_duration
		
		if stopwatch_label:
			if slowdown_tween and slowdown_tween.is_valid():
				slowdown_tween.kill() # Kill existing tween before creating a new one
			
			slowdown_tween = create_tween()
			slowdown_tween.set_loops() # Make the fade pulse repeat
			# Fade to blue
			slowdown_tween.tween_property(stopwatch_label, "modulate", Color.BLUE, 0.5).from(original_stopwatch_color).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
			# Fade back to original color
			slowdown_tween.tween_property(stopwatch_label, "modulate", original_stopwatch_color, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
			
		print("Slowdown activated with fade effect!") # For debugging
		if freeze_effect_player:
			freeze_effect_player.play()

func end_game(result):
	current_state = GameState.GAME_OVER
	get_tree().paused = true
	$PauseMenu.hide() # Ensure pause menu is hidden
	player1_banner.hide()
	player2_banner.hide()
	gameOverSound.play()

	if slowdown_tween and slowdown_tween.is_valid():
		slowdown_tween.kill()
	if stopwatch_label:
		stopwatch_label.modulate = original_stopwatch_color

	var timer = get_tree().create_timer(2.0) # 2-second delay
	timer.timeout.connect(func():
		restart_button.show()
		if result == 1: # Game Won
			you_win_banner.show()
			game_over_banner.hide() # Ensure the other banner is hidden
			var time_taken = int(time_elapsed)
			if high_score == 0 or time_taken < high_score:
				high_score = time_taken
			$HUD.get_node("Highscore3").text = str(high_score) # Update highscore display
		else: # Game Over
			game_over_banner.show()
			you_win_banner.hide() # Ensure the other banner is hidden
			$TileMap.show_mines()
			$TileMap.show_uncollected_powerups()
		var hide_timer = get_tree().create_timer(3.0)
		hide_timer.timeout.connect(func():
			you_win_banner.hide()
			game_over_banner.hide()
		)
	)

func _process(delta):
	if current_state == GameState.PLAYING:
		if !first_click:
			if slowdown_active:
				time_elapsed += delta / 2 # Timer slows down by half
				slowdown_timer -= delta

				if slowdown_timer <= 0:
					slowdown_active = false
					if slowdown_tween and slowdown_tween.is_valid():
						slowdown_tween.kill()
					if stopwatch_label:
						stopwatch_label.modulate = original_stopwatch_color
					print("Slowdown ended.") # For debugging
			else:
				time_elapsed += delta
				# Potentially trigger slowdown powerup if not first click and not already active
				# This is a placeholder for actual trigger logic (e.g., on mine reveal or item pickup)
				if guaranteed_slowdowns_remaining > 0:
					if randf() < 0.01: # Small chance to use a guaranteed one automatically, or tie to an event
						activate_slowdown_powerup()
						guaranteed_slowdowns_remaining -= 1
				elif randf() < slowdown_probability / 60.0: # Spread probability over a minute roughly
					activate_slowdown_powerup()

		$HUD.get_node("RemainingMines3").text = str(remaining_mines)
		$HUD.get_node("Stopwatch3").text = str(int(time_elapsed))

# Function to handle restart signal from the CanvasLayer named "GameOver"
func _on_game_over_restart_signal():
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
