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
@onready var gameOverSound : AudioStreamPlayer2D = get_node("GameOver/GameOverSound")
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
	tile_map_player1.shield_count_changed.connect($MulHUD._on_shield_count_changed)

	tile_map_player2.flag_placed.connect(_on_board_flag_placed)
	tile_map_player2.flag_removed.connect(_on_board_flag_removed)
	tile_map_player2.end_game.connect(_on_board_end_game)
	tile_map_player2.game_won.connect(_on_board_game_won)
	tile_map_player2.shield_count_changed.connect(_on_board_shield_count_changed)
	tile_map_player2.shield_count_changed.connect($MulHUD._on_shield_count_changed)

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
	gameOverSound.play()

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
		# Reveal bombs and powerups on the losing player's board immediately
		if player_id == 1:
			tile_map_player1.show_mines()
			tile_map_player1.show_uncollected_powerups()
			await get_tree().create_timer(6.0).timeout
			tile_map_player2.show_mines()
			tile_map_player2.show_uncollected_powerups()
		else:
			tile_map_player2.show_mines()
			tile_map_player2.show_uncollected_powerups()
			await get_tree().create_timer(6.0).timeout
			tile_map_player1.show_mines()
			tile_map_player1.show_uncollected_powerups()

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

func try_transfer_bomb(from_player_id: int) -> bool:
	# Public interface called by TileMapPlayer scripts when middle-click is used.
	# Returns true if a bomb was successfully transferred, false otherwise.
	if current_state != GameState.PLAYING:
		return false

	var from_board: TileMap
	var to_board: TileMap
	var to_player_id: int = 2 if from_player_id == 1 else 1

	if from_player_id == 1:
		from_board = tile_map_player1
		to_board = tile_map_player2
	else:
		from_board = tile_map_player2
		to_board = tile_map_player1

	# Pick a random mine from the source board that is not flagged
	var available_mines := []
	for pos in from_board.mine_coords:
		if not from_board.is_flag(pos):
			available_mines.append(pos)
	if available_mines.is_empty():
		print("All mines on Player %d board are already flagged; cannot transfer." % from_player_id)
		return false

	var bomb_pos: Vector2i = available_mines.pick_random()
	# Remove mine from source board
	from_board.erase_cell(from_board.mine_layer, bomb_pos)
	from_board.mine_coords.erase(bomb_pos)
	from_board.mines_count -= 1

	# Update numbers on source board
	from_board.generate_numbers()

	# Find a random empty cell on the destination board
	var target_pos: Vector2i = Vector2i(-1, -1)
	var attempts := 0
	while attempts < 1000 and target_pos == Vector2i(-1, -1):
		var rand_cell := Vector2i(randi_range(0, to_board.board_cols - 1), randi_range(0, to_board.board_rows - 1))
		if not to_board.is_mine(rand_cell) and to_board.is_grass(rand_cell):
			target_pos = rand_cell
		else:
			attempts += 1

	if target_pos == Vector2i(-1, -1):
		print("Failed to find empty cell on destination board for bomb transfer.")
		# Revert the removal to keep game consistent
		from_board.mine_coords.append(bomb_pos)
		from_board.set_cell(from_board.mine_layer, bomb_pos, from_board.tile_id, from_board.mine_atlas)
		from_board.mines_count += 1
		from_board.generate_numbers()
		return false

	# Place bomb on destination board
	to_board.mine_coords.append(target_pos)
	to_board.set_cell(to_board.mine_layer, target_pos, to_board.tile_id, to_board.mine_atlas)
	to_board.mines_count += 1

	# Update numbers on destination board
	to_board.generate_numbers()

	# Update HUD / player data counts
	if player_data.has(from_player_id):
		player_data[from_player_id].remaining_mines -= 1
	if player_data.has(to_player_id):
		player_data[to_player_id].remaining_mines += 1

	update_all_huds()
	print("Bomb transferred from Player %d to Player %d" % [from_player_id, to_player_id])
	return true

func try_transfer_bomb_to_cell(from_player_id: int, target_pos: Vector2i) -> bool:
	# Only allow if the target cell is covered and not a bomb
	var from_board: TileMap
	var to_board: TileMap
	var to_player_id: int = 2 if from_player_id == 1 else 1
	if from_player_id == 1:
		from_board = tile_map_player1
		to_board = tile_map_player2
	else:
		from_board = tile_map_player2
		to_board = tile_map_player1

	# Check if the target cell is covered and not a bomb
	if not to_board.is_grass(target_pos) or to_board.is_mine(target_pos):
		return false

	# Find a random unflagged bomb on the eligible player's board
	var available_mines := []
	for pos in from_board.mine_coords:
		if not from_board.is_flag(pos):
			available_mines.append(pos)
	if available_mines.is_empty():
		return false
	var removed_bomb_pos: Vector2i = available_mines.pick_random()

	# Remove the bomb from the eligible player's board
	from_board.erase_cell(from_board.mine_layer, removed_bomb_pos)
	from_board.mine_coords.erase(removed_bomb_pos)
	from_board.mines_count -= 1

	# Add a bomb to the requested cell on the opponent's board
	to_board.mine_coords.append(target_pos)
	to_board.set_cell(to_board.mine_layer, target_pos, to_board.tile_id, to_board.mine_atlas)
	to_board.mines_count += 1

	# Update numbers for the 8 surrounding tiles of both the new and removed bomb
	_update_numbers_around(from_board, removed_bomb_pos)
	_update_numbers_around(to_board, target_pos)

	# Update HUD / player data counts
	if player_data.has(from_player_id):
		player_data[from_player_id].remaining_mines -= 1
	if player_data.has(to_player_id):
		player_data[to_player_id].remaining_mines += 1

	update_all_huds()
	# Blink the mines label for both players
	mul_hud.blink_mines_label(from_player_id)
	mul_hud.blink_mines_label(to_player_id)
	return true

func _update_numbers_around(board, bomb_pos: Vector2i):
	# Only update the 8 surrounding number tiles
	for cell in board.get_all_surrounding_cells(bomb_pos):
		if not board.is_mine(cell) and board.is_grass(cell):
			var cnt := 0
			for nb in board.get_all_surrounding_cells(cell):
				if board.is_mine(nb):
					cnt += 1
			if cnt > 0:
				board.set_cell(board.number_layer, cell, board.tile_id, board.number_atlas[cnt - 1])
			else:
				board.erase_cell(board.number_layer, cell)
