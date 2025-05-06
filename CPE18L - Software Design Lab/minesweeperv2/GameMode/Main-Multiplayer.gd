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

@onready var game_over_canvas_layer = $GameOver
# References to the win banners and restart button
# Now, get the banners and button as children of the CanvasLayer node
@onready var game_over_banner : Sprite2D = game_over_canvas_layer.get_node("GameOverBanner")
@onready var you_win_banner : Sprite2D = game_over_canvas_layer.get_node("YouWinBanner")

@onready var player1_wins_banner: Sprite2D = game_over_canvas_layer.get_node("Player1Wins")
@onready var player2_wins_banner: Sprite2D = game_over_canvas_layer.get_node("Player2Wins")
@onready var restart_button: Button = game_over_canvas_layer.get_node("RestartButton")

@onready var mul_hud = $MulHUD

func _ready():
	randomize()
	tile_map_player1.player_id = 1
	tile_map_player1.mines_count = player_data[1].mines

	tile_map_player2.player_id = 2
	tile_map_player2.mines_count = player_data[2].mines

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

	$PauseMenu.requested_pause.connect(_on_pause_menu_requested_pause)
	$PauseMenu.requested_resume.connect(_on_pause_menu_requested_resume)
	$PauseMenu.requested_restart_game.connect(_on_pause_menu_requested_restart_game)
	new_game()

func new_game():
	current_state = GameState.PLAYING

	for player_id in player_data:
		player_data[player_id].remaining_mines = player_data[player_id].mines
		player_data[player_id].first_click = true
		player_data[player_id].time_elapsed = 0.0
		player_data[player_id].shield_count = 0
		player_data[player_id].game_over = false
		player_data[player_id].game_won = false

	tile_map_player1.new_game()
	tile_map_player2.new_game()

	game_over_banner.hide()
	you_win_banner.hide()
	player1_wins_banner.hide()
	player2_wins_banner.hide()
	restart_button.hide()

	mul_hud.reset_display(1)
	mul_hud.reset_display(2)

	await get_tree().create_timer(0.1).timeout
	update_all_huds()

	$GameOver.hide()
	$PauseMenu.hide()
	get_tree().paused = false

func _process(delta):
	if current_state == GameState.PLAYING:
		if !player_data[1].first_click:
			player_data[1].time_elapsed += delta
		if !player_data[2].first_click:
			player_data[2].time_elapsed += delta

		mul_hud.update_mines_display(1, player_data[1].remaining_mines)
		mul_hud.update_mines_display(2, player_data[2].remaining_mines)

# Modified end_game to handle per-player game end
func end_game(player_id: int, result: int):
	current_state = GameState.GAME_OVER
	get_tree().paused = true
	$PauseMenu.hide()
	$GameOver.show()

	var winning_player_id: int
	if result == 1:
		winning_player_id = player_id
	else:
		if player_id == 1:
			winning_player_id = 2
		else:
			winning_player_id = 1
	var show_timer = get_tree().create_timer(2.0)
	show_timer.timeout.connect(func():
		restart_button.show()
		if winning_player_id == 1:
			player1_wins_banner.show()
			player2_wins_banner.hide()
		else:
			player2_wins_banner.show()
			player1_wins_banner.hide()
		var hide_timer = get_tree().create_timer(3.0)
		hide_timer.timeout.connect(func():
			player1_wins_banner.hide()
			player2_wins_banner.hide()
		)
	)
	if result == -1:
		# reveal mines on the loser’s board immediately
		if player_id == 1:
			tile_map_player1.show_mines()
			tile_map_player1.show_uncollected_powerups()
		else:
			tile_map_player2.show_mines()
			tile_map_player2.show_uncollected_powerups()

func get_current_state():
	return current_state

func _on_board_flag_placed(player_id: int):
	player_data[player_id].remaining_mines -= 1

func _on_board_flag_removed(player_id: int):
	player_data[player_id].remaining_mines += 1

func _on_board_end_game(player_id: int):
	print("Game Over for Player ", player_id)
	end_game(player_id, -1)
	if player_id == 1:
		tile_map_player1.show_mines()
		tile_map_player1.show_uncollected_powerups()
	elif player_id == 2:
		tile_map_player2.show_mines()
		tile_map_player2.show_uncollected_powerups()

func _on_board_game_won(player_id: int):
	print("Player ", player_id, " won!")
	end_game(player_id, 1)

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

func update_all_huds():
	for player_id in player_data:
		mul_hud.update_mines_display(player_id, player_data[player_id].remaining_mines)
		update_player_shield_hud(player_id)
