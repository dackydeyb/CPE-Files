# Main-multiplayer.gd
extends Node2D

# Game variables per player
var player_data = {
	1: {
		"mines": 25, # Variable mine count for Player 1
		"remaining_mines": 0, # Initialized in new_game
		"first_click": true,
		"time_elapsed": 0.0,
		"high_score": 0,
		"shield_count": 0,
		"game_over": false,
		"game_won": false
	},
	2: {
		"mines": 25, # Variable mine count for Player 2
		"remaining_mines": 0, # Initialized in new_game
		"first_click": true,
		"time_elapsed": 0.0,
		"high_score": 0, # Consider if high score is per-player or global
		"shield_count": 0,
		"game_over": false,
		"game_won": false
	}
}

enum GameState { PLAYING, PAUSED, GAME_OVER }
var current_state = GameState.PLAYING

# References to the TileMaps
@onready var tile_map_player1 = $TileMapPlayer1
@onready var tile_map_player2 = $TileMapPlayer2

# Reference to the HUD
@onready var mul_hud = $MulHUD

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize() # Randomize once for both boards

	# Assign player IDs and mine counts to the TileMaps
	tile_map_player1.player_id = 1
	tile_map_player1.mines_count = player_data[1].mines

	tile_map_player2.player_id = 2
	tile_map_player2.mines_count = player_data[2].mines

	# Connect signals from both TileMaps
	tile_map_player1.flag_placed.connect(_on_board_flag_placed)
	tile_map_player1.flag_removed.connect(_on_board_flag_removed)
	tile_map_player1.end_game.connect(_on_board_end_game)
	tile_map_player1.game_won.connect(_on_board_game_won)
	tile_map_player1.shield_count_changed.connect(_on_board_shield_count_changed)

	tile_map_player2.flag_placed.connect(_on_board_flag_placed)
	tile_map_player2.flag_removed.connect(_on_board_flag_removed)
	tile_map_player2.end_game.connect(_on_board_end_game)
	tile_map_player2.game_won.connect(_on_board_game_won)
	tile_map_player2.shield_count_changed.connect(_on_board_shield_count_changed)


	# Connect pause menu signals
	$PauseMenu.requested_pause.connect(_on_pause_menu_requested_pause)
	$PauseMenu.requested_resume.connect(_on_pause_menu_requested_resume)
	$PauseMenu.requested_restart_game.connect(_on_pause_menu_requested_restart_game)

	new_game()

func new_game():
	current_state = GameState.PLAYING

	# Reset player data
	for player_id in player_data:
		player_data[player_id].remaining_mines = player_data[player_id].mines
		player_data[player_id].first_click = true
		player_data[player_id].time_elapsed = 0.0
		player_data[player_id].shield_count = 0
		player_data[player_id].game_over = false
		player_data[player_id].game_won = false

	# Start new game on both boards
	tile_map_player1.new_game()
	tile_map_player2.new_game()

	# Reset HUD displays and update
	mul_hud.reset_display(1)
	mul_hud.reset_display(2)

	# Wait for a short delay before updating HUD to allow boards to initialize
	await get_tree().create_timer(0.1).timeout
	update_all_huds()


	$GameOver.hide()
	$PauseMenu.hide()
	get_tree().paused = false

func _process(delta):
	if current_state == GameState.PLAYING:
		# Update time for players who haven't made their first click yet
		if !player_data[1].first_click:
			player_data[1].time_elapsed += delta
		if !player_data[2].first_click:
			player_data[2].time_elapsed += delta

		# Update remaining mines display in HUD
		mul_hud.update_mines_display(1, player_data[1].remaining_mines)
		mul_hud.update_mines_display(2, player_data[2].remaining_mines)

# Modified end_game to handle per-player game end
func end_game(player_id: int, result: int):
	# If a player hits a mine, only their game ends
	player_data[player_id].game_over = true

	if result == 1:
		# If a player wins, the game might end for both or just that player wins the round
		player_data[player_id].game_won = true
		current_state = GameState.GAME_OVER # Example: game ends for both on one player win
		get_tree().paused = true
		$GameOver.show()
		$PauseMenu.hide()
		$GameOver.get_node("Label").text = "Player %d WINS!" % player_id
		# High score logic needs to be adapted for multiplayer

	# Check if both players are now game over (if game doesn't stop on first loss/win)
	if player_data[1].game_over and player_data[2].game_over:
		current_state = GameState.GAME_OVER
		get_tree().paused = true
		$GameOver.show()
		$PauseMenu.hide()
		if !player_data[1].game_won and !player_data[2].game_won:
			$GameOver.get_node("Label").text = "Both SABOG!"
		# You might need more complex win/loss condition checks here


# Removed _on_tile_map_hard_end_game as it's specific to one board

func get_current_state():
	return current_state

# New signal handlers that receive player_id
func _on_board_flag_placed(player_id: int):
	player_data[player_id].remaining_mines -= 1
	# HUD update is handled in _process now

func _on_board_flag_removed(player_id: int):
	player_data[player_id].remaining_mines += 1
	# HUD update is handled in _process now

func _on_board_end_game(player_id: int):
	print("Game Over for Player ", player_id)
	end_game(player_id, -1) # -1 indicates a loss

	# Show mines for the player who lost
	if player_id == 1:
		tile_map_player1.show_mines()
		tile_map_player1.show_uncollected_powerups()
	elif player_id == 2:
		tile_map_player2.show_mines()
		tile_map_player2.show_uncollected_powerups()

func _on_board_game_won(player_id: int):
	print("Player ", player_id, " won!")
	end_game(player_id, 1) # 1 indicates a win

# New signal handler for shield count changes
func _on_board_shield_count_changed(player_id: int, count: int):
	player_data[player_id].shield_count = count
	update_player_shield_hud(player_id)


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

# Helper functions for the TileMaps to access first click state
func get_player_first_click(player_id: int):
	if player_data.has(player_id):
		return player_data[player_id].first_click
	return false

func set_player_first_click(player_id: int, value: bool):
	if player_data.has(player_id):
		player_data[player_id].first_click = value


# Update a specific player's shield HUD display
func update_player_shield_hud(player_id: int):
	var hud_state = "inactive"
	if player_data.has(player_id):
		if player_data[player_id].shield_count > 0:
			hud_state = "active_steady" # Or "active_fast" based on your logic
		mul_hud.update_shield_display(player_id, hud_state)

# Update all HUDs - useful for initial setup or full refresh
func update_all_huds():
	for player_id in player_data:
		mul_hud.update_mines_display(player_id, player_data[player_id].remaining_mines)
		update_player_shield_hud(player_id)
