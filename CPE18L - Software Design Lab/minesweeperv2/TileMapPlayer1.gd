# MinesweeperBoard.gd
extends TileMap

signal end_game(player_id)
signal game_won(player_id)
signal flag_placed(player_id)
signal flag_removed(player_id)
signal shield_count_changed(player_id, count) # Signal for shield updates


# Grid variables (can be exported if boards can be different sizes)
@export var board_rows : int = 13
@export var board_cols : int = 15
const CELL_SIZE : int = 50 # Keep as const if all boards have the same cell size

# Player Identifier
@export var player_id : int = 1 # 1 for Player 1, 2 for Player 2

# Mine count for this specific board
@export var mines_count : int = 25
var remaining_mines_on_board : int # Keep track of mines for this board

# Tilemap variables
var tile_id : int = 0

# Layer variables (Ensure these match your TileSet setup)
var background_layer : int = 0
var powerup_layer : int = 1
var number_layer : int = 2
var mine_layer : int = 3
var grass_layer : int = 4
var flag_layer : int = 5
var hover_layer : int = 6

# Atlas coordinates (Keep these as they are tile-set specific)
var mine_atlas := Vector2i(4, 0)
var flag_atlas := Vector2i(5, 0)
var hover_atlas := Vector2i(6, 0)
var number_atlas : Array = generate_number_atlas()
var blurry_atlas : Array = generate_variant_atlas(2)
var question_atlas : Array = generate_variant_atlas(3)
var fake_hint_atlas : Array = generate_variant_atlas(4)
var shuffle_atlas : Array = generate_variant_atlas(5)
var total_clicks := 0
var background_atlas_light := Vector2i(0, 0)
var background_atlas_dark := Vector2i(1, 0)
var shield_atlas := Vector2i(0, 6) # Shield is at (0, 6)

# Array to store mine coordinates for THIS board
var mine_coords := []
var chording := false
var shield_count: int = 0

var shield_active : bool = false
# Removed has_flag_been_placed_while_shield_active as it wasn't used


# Define the delay before the fade-in on game restart
const RESTART_FADE_IN_DELAY = 0.5 # Adjust this value for restart delay

func generate_number_atlas():
	var a := []
	for i in range(8):
		a.append(Vector2i(i, 1))
	return a

func generate_variant_atlas(row : int):
	var a := []
	for i in range(8):
		a.append(Vector2i(i, row))
	return a

func _ready():
	# Randomization should ideally be handled once in the main script
	# randomize()
	scale = Vector2(1, 1) # for Hard - consider if this should be per-player
	# new_game() # New game will be called by the main script

# Modified new_game to use this instance's mine count
func new_game():
	clear()
	mine_coords.clear()
	remaining_mines_on_board = mines_count # Initialize remaining mines for this board
	generate_background()
	generate_mines()
	generate_numbers()
	generate_grass()
	generate_powerups()
	shield_count = 0
	shield_active = false
	total_clicks = 0
	# Signal HUD update instead of calling directly
	shield_count_changed.emit(player_id, shield_count)


func generate_background():
	for y in range(board_rows):
		for x in range(board_cols):
			var toggle = ((x + y) % 2)
			var background_tile = background_atlas_light if toggle == 0 else background_atlas_dark
			set_cell(background_layer, Vector2i(x, y), tile_id, background_tile)

func generate_powerups():
	clear_layer(powerup_layer)
	var num_shields = 5
	var placed = 0
	var attempts = 0
	while placed < num_shields and attempts < 1000:
		var pos = Vector2i(randi_range(0, board_cols - 1), randi_range(0, board_rows - 1))
		if is_grass(pos) and not is_mine(pos) and get_cell_source_id(number_layer, pos) == -1:
			set_cell(powerup_layer, pos, tile_id, shield_atlas)
			placed += 1
		attempts += 1
	if placed < num_shields:
		print("Warning: Could not place all %d shields for Player %d. Placed %d." % [num_shields, player_id, placed])


# Modified generate_mines to use instance's mine count
func generate_mines():
	for i in range(mines_count):
		var mine_pos = Vector2i(randi_range(0, board_cols - 1), randi_range(0, board_rows - 1))
		while mine_coords.has(mine_pos):
			mine_pos = Vector2i(randi_range(0, board_cols - 1), randi_range(0, board_rows - 1))
		mine_coords.append(mine_pos)
		set_cell(mine_layer, mine_pos, tile_id, mine_atlas)

func generate_numbers():
	clear_layer(number_layer)
	for cell in get_used_cells(grass_layer):
		if not is_mine(cell) and get_cell_source_id(powerup_layer, cell) == -1:
			var cnt := 0
			for nb in get_all_surrounding_cells(cell):
				if is_mine(nb):
					cnt += 1
			if cnt > 0:
				var r := randf()
				var atlas_coords: Vector2i
				if r < 0.18:
					atlas_coords = blurry_atlas[cnt - 1]
				elif r < 0.24:
					atlas_coords = question_atlas[cnt - 1]
				elif r < 0.36:
					atlas_coords = fake_hint_atlas[cnt - 1]
				elif r < 0.51:
					atlas_coords = shuffle_atlas[cnt - 1]
				else:
					atlas_coords = number_atlas[cnt - 1]
				set_cell(number_layer, cell, tile_id, atlas_coords)

func generate_grass():
	for y in range(board_rows):
		for x in range(board_cols):
			var toggle = ((x + y) % 2)
			set_cell(grass_layer, Vector2i(x, y), tile_id, Vector2i(3 - toggle, 0))

func get_empty_cells():
	var empty_cells := []
	for y in range(board_rows):
		for x in range(board_cols):
			if not is_mine(Vector2i(x, y)):
				empty_cells.append(Vector2i(x, y))
	return empty_cells

func get_all_surrounding_cells(middle_cell):
	var surrounding_cells := []
	var target_cell
	for y in range(3):
		for x in range(3):
			target_cell = middle_cell + Vector2i(x - 1, y - 1)
			if target_cell != middle_cell:
				if (target_cell.x >= 0 and target_cell.x < board_cols and target_cell.y >= 0 and target_cell.y < board_rows):
					surrounding_cells.append(target_cell)
	return surrounding_cells

func _input(event):
	# Only process input if the game is playing and the mouse is over THIS board
	if get_parent().get_current_state() != get_parent().GameState.PLAYING:
		return

	var local_mouse_position = get_local_mouse_position()
	var map_pos = local_to_map(local_mouse_position)

	# Check if the click is within THIS board's boundaries
	if map_pos.x >= 0 and map_pos.x < board_cols and map_pos.y >= 0 and map_pos.y < board_rows:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT:
				if event.pressed:
					if is_grass(map_pos) and not is_flag(map_pos):
						if not Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
							# Interact with the main script for first click status
							if get_parent().get_player_first_click(player_id):
								clear_safe_area(map_pos)
								generate_numbers() # Regenerate numbers after moving mines
								process_left_click(map_pos)
								get_parent().set_player_first_click(player_id, false)
							else:
								if is_mine(map_pos):
									if shield_count > 0:
										print("Player ", player_id, ": Shield saved you!")
										set_cell(flag_layer, map_pos, tile_id, flag_atlas)
										flag_placed.emit(player_id)
										shield_count -= 1 # Decrement shield count
										# Signal HUD update
										shield_count_changed.emit(player_id, shield_count)
										print("Player ", player_id, ": Shield used. Count: ", shield_count) # Debug print
									else:
										end_game.emit(player_id)
										show_mines()
								else:
									process_left_click(map_pos)
				else:
					if chording:
						scan_mines(map_pos)
						chording = false
			elif event.button_index == MOUSE_BUTTON_RIGHT:
				if event.pressed:
					if is_grass(map_pos):
						if not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
							process_right_click(map_pos)
				else:
					if chording:
						scan_mines(map_pos)
						chording = false


func process_left_click(pos):
	total_clicks += 1
	if total_clicks > 3: # This logic might need refinement for two players
		try_revert_variants()
	var revealed_cells := []
	var cells_to_reveal := [pos]
	while not cells_to_reveal.is_empty():
		var current_cell = cells_to_reveal.pop_front()
		if revealed_cells.has(current_cell) or not is_grass(current_cell):
			continue
		if is_mine(current_cell):
			continue # Should not happen if shield or first click logic works

		erase_cell(grass_layer, current_cell)
		revealed_cells.append(current_cell)

		if is_shield(current_cell):
			print("Player ", player_id, ": Shield found at: ", current_cell)
			activate_shield()
			erase_cell(powerup_layer, current_cell)

		if is_flag(current_cell):
			erase_cell(flag_layer, current_cell)
			flag_removed.emit(player_id)

		if not is_number(current_cell) and not is_mine(current_cell):
			for neighbor in get_all_surrounding_cells(current_cell):
				if is_grass(neighbor) and not is_mine(neighbor) and not cells_to_reveal.has(neighbor) and not revealed_cells.has(neighbor):
					cells_to_reveal.append(neighbor)
	check_win_condition()

func try_revert_variants():
	for cell in get_used_cells(number_layer):
		var atlas_coords = get_cell_atlas_coords(number_layer, cell)
		var current_row = atlas_coords.y
		if current_row < 2 or current_row > 5:
			continue
		var cnt := 0
		for neighbor in get_all_surrounding_cells(cell):
			if is_mine(neighbor):
				cnt += 1
		if cnt == 0:
			erase_cell(number_layer, cell)
			continue
		var r = randf()
		if current_row == 5:
			if r < 0.95:
				continue
			elif r < 0.10:
				set_cell(number_layer, cell, tile_id, number_atlas[cnt - 1])
			else:
				set_random_variant(cell, cnt)
		else:
			if r < 0.35:
				set_cell(number_layer, cell, tile_id, number_atlas[cnt - 1])
			elif r < 0.75:
				set_cell(number_layer, cell, tile_id, shuffle_atlas[cnt - 1])
			else:
				set_random_variant(cell, cnt)


func set_random_variant(cell, cnt):
	var variants = [
		shuffle_atlas[cnt - 1],
		shuffle_atlas[cnt - 1],
		blurry_atlas[cnt - 1],
		question_atlas[cnt - 1],
		fake_hint_atlas[cnt - 1]
	]
	set_cell(number_layer, cell, tile_id, variants.pick_random())

func process_right_click(pos):
	if not is_grass(pos):
		return

	if is_flag(pos):
		erase_cell(flag_layer, pos)
		flag_removed.emit(player_id)
		# Shield logic when removing a flag might need review based on desired gameplay
		# if is_mine(pos) and shield_count > 0:
		# 	shield_count -= 1
		# update_hud() # Removed direct HUD call
		shield_count_changed.emit(player_id, shield_count)
		return

	if get_used_cells(flag_layer).size() >= mines_count: # Use instance's mine count
		return

	set_cell(flag_layer, pos, tile_id, flag_atlas)
	flag_placed.emit(player_id)

	# Shield consumption on non-mine flag placement - adjust if needed
	if shield_count > 0 and not is_mine(pos):
		shield_count -= 1
		print("Player ", player_id, ": Shield consumed on non-bomb tile! Remaining shields:", shield_count)

	# update_hud() # Removed direct HUD call
	shield_count_changed.emit(player_id, shield_count)


func show_mines():
	# Reveal all mines on THIS board
	for mine_pos in get_used_cells(mine_layer):
		if is_grass(mine_pos):
			erase_cell(grass_layer, mine_pos)

	# Reveal shields on THIS board
	for shield_pos in get_used_cells(powerup_layer):
		if is_grass(shield_pos):
			erase_cell(grass_layer, shield_pos)


func show_uncollected_powerups():
	print("Player ", player_id, ": Showing uncollected shields...")
	for y in range(board_rows):
		for x in range(board_cols):
			var pos = Vector2i(x, y)
			if is_shield(pos):
				if is_grass(pos):
					erase_cell(grass_layer, pos)

func move_mine(old_pos):
	var new_pos = Vector2i(randi_range(0, board_cols - 1), randi_range(0, board_rows - 1))
	while mine_coords.has(new_pos):
		new_pos = Vector2i(randi_range(0, board_cols - 1), randi_range(0, board_rows - 1))
	var mine_index = mine_coords.find(old_pos)
	if mine_index != -1:
		mine_coords[mine_index] = new_pos
		erase_cell(mine_layer, old_pos)
		set_cell(mine_layer, new_pos, tile_id, mine_atlas)

func _process(_delta):
	# Only process hover if game is playing
	if get_parent().get_current_state() != get_parent().GameState.PLAYING:
		clear_layer(hover_layer) # Clear hover if not playing
		return

	clear_layer(hover_layer)
	var local_mouse_position = get_local_mouse_position()
	var mouse_map_pos := local_to_map(local_mouse_position)

	# Check if mouse is over THIS board
	if mouse_map_pos.x >= 0 and mouse_map_pos.x < board_cols and mouse_map_pos.y >= 0 and mouse_map_pos.y < board_rows:
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
			chording = true
			if is_number(mouse_map_pos):
				highlight_surrounding_grass(mouse_map_pos)
				set_cell(hover_layer, mouse_map_pos, tile_id, hover_atlas)
		else:
			chording = false
			if is_grass(mouse_map_pos) or is_number(mouse_map_pos):
				set_cell(hover_layer, mouse_map_pos, tile_id, hover_atlas)

func highlight_surrounding_grass(center_cell_map_pos):
	for cell in get_all_surrounding_cells(center_cell_map_pos):
		if is_grass(cell):
			set_cell(hover_layer, cell, tile_id, hover_atlas)

func scan_mines(pos):
	var surrounding_flags = 0
	var flag_on_non_mine_nearby = false
	var unflagged_mine_cell_nearby: Vector2i = Vector2i(-1, -1)

	for i in get_all_surrounding_cells(pos):
		if is_flag(i):
			surrounding_flags += 1
			if not is_mine(i):
				flag_on_non_mine_nearby = true
		# Check specifically for an adjacent unflagged mine
		if is_mine(i) and not is_flag(i):
			unflagged_mine_cell_nearby = i

	# Chording logic with shields - adjust if needed for multiplayer
	if unflagged_mine_cell_nearby != Vector2i(-1, -1):
		if shield_count > 0:
			print("Player ", player_id, ": Shield saved you from chording into an unflagged mine!")
			set_cell(flag_layer, unflagged_mine_cell_nearby, tile_id, flag_atlas)
			flag_placed.emit(player_id)
			shield_count -= 1
			shield_count_changed.emit(player_id, shield_count)
			print("Player ", player_id, ": Chording Shield used. Count: ", shield_count)
			return
		else:
			print("Player ", player_id, ": Chording failed - hit an unflagged mine!")
			end_game.emit(player_id)
			show_mines()
			return

	if flag_on_non_mine_nearby:
		print("Player ", player_id, ": Chording failed - flag placed on a non-mine!")
		end_game.emit(player_id)
		show_mines()
		return

	if is_number(pos):
		var required_flags = get_cell_atlas_coords(number_layer, pos).x + 1
		if surrounding_flags == required_flags:
			for cell in get_all_surrounding_cells(pos):
				if is_grass(cell) and not is_flag(cell):
					process_left_click(cell) # Reveal safe surrounding cells
		else:
			print("Player ", player_id, ": Incorrect number of flags around cell ", pos)

func clear_safe_area(center_pos):
	var safe_zone = get_all_surrounding_cells(center_pos)
	safe_zone.append(center_pos)
	for safe_cell in safe_zone:
		if is_mine(safe_cell):
			move_mine(safe_cell)

func activate_shield():
	shield_count += 1
	shield_count_changed.emit(player_id, shield_count)
	print("Player ", player_id, ": Shield activated! Count: ", shield_count)

# Removed deactivate_shield as it's managed by shield_count

# Removed update_hud() function from here, logic moved to Main

#helper functions - Keep these for internal board checks
func is_mine(pos):
	return get_cell_source_id(mine_layer, pos) != -1

func is_grass(pos):
	return get_cell_source_id(grass_layer, pos) != -1

func is_number(pos):
	return get_cell_source_id(number_layer, pos) != -1

func is_flag(pos):
	return get_cell_source_id(flag_layer, pos) != -1

func is_shield(pos):
	return get_cell_source_id(powerup_layer, pos) != -1

func has_adjacent_mines(pos):
	for neighbor in get_all_surrounding_cells(pos):
		if is_mine(neighbor):
			return true
	return false

func check_win_condition():
	var grass_cells_left = 0
	for y in range(board_rows):
		for x in range(board_cols):
			if is_grass(Vector2i(x, y)):
				grass_cells_left += 1

	# Win condition: Number of grass cells left equals the number of mines
	if grass_cells_left == mines_count:
		game_won.emit(player_id)
		# Auto-flag remaining mines on win
		for mine in mine_coords:
			if not is_flag(mine):
				set_cell(flag_layer, mine, tile_id, flag_atlas)
				flag_placed.emit(player_id) # Emit flag placed for win state
