extends TileMap

signal end_game
signal game_won
signal flag_placed
signal flag_removed
signal shield_collected
signal scanner_collected
signal freeze_collected
signal mine_triggered(pos)


#grid variables
const ROWS : int = 14
const COLS : int = 32
const CELL_SIZE : int = 50

#tilemap variables
var tile_id : int = 0 # Make sure this matches your TileSet's source ID

# !!! IMPORTANT: Ensure these layer constants match your TileMap node's layers IN ORDER !!!
# Based on your inspector order: Background, Mines, Numbers, Powerups, Grass, Flags, Hovers, Exclamation
var background_layer : int = 0
var mine_layer : int = 1
var number_layer : int = 2
var powerup_layer: int = 3 # Powerups are below Grass
var grass_layer : int = 4 # Grass is above Powerups, Numbers, Mines, etc.
var flag_layer : int = 5
var hover_layer : int = 6
var exclamation_layer: int = 7 # Exclamations are above Grass


#atlas coordinates
var mine_atlas := Vector2i(4, 0)
var flag_atlas := Vector2i(5, 0)
var hover_atlas := Vector2i(6, 0)
var number_atlas : Array = generate_number_atlas()
var blurry_atlas : Array = generate_variant_atlas(2)		# row 2
var question_atlas : Array = generate_variant_atlas(3)	# row 3
var fake_hint_atlas : Array = generate_variant_atlas(4)	# row 4
var shuffle_atlas : Array = generate_variant_atlas(5) # row 5
var total_clicks := 0
var background_atlas_light := Vector2i(0, 0)
var background_atlas_dark := Vector2i(1, 0)

# Powerup atlas coordinates
var shield_atlas := Vector2i(0, 6)
var exclamation_atlas := Vector2i(1, 6) # Used for scanner marking
var scanner_atlas := Vector2i(2, 6)
var freeze_atlas := Vector2i(3, 6)


#array to store mine coordinates
var mine_coords := []
var chording := false


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
	randomize()
	scale = Vector2(1, 1) # for Hard
	new_game()

#reset game
func new_game():
	clear() # Clears all layers
	mine_coords.clear()
	generate_background()
	generate_mines()
	# generate_numbers() # Numbers generated after first click to ensure safe start
	generate_grass()
	generate_power_ups()
	# Clear any existing flags or exclamation marks from previous game
	clear_layer(flag_layer)
	clear_layer(exclamation_layer)


func generate_background():
	for y in range(ROWS):
		for x in range(COLS):
			var toggle = ((x + y) % 2)
			var background_tile = background_atlas_light if toggle == 0 else background_atlas_dark
			set_cell(background_layer, Vector2i(x, y), tile_id, background_tile)

func generate_mines():
	for i in range(get_parent().TOTAL_MINES):
		var mine_pos = Vector2i(randi_range(0, COLS - 1), randi_range(0, ROWS - 1))
		while mine_coords.has(mine_pos):
			mine_pos = Vector2i(randi_range(0, COLS - 1), randi_range(0, ROWS - 1))
		mine_coords.append(mine_pos)
		set_cell(mine_layer, mine_pos, tile_id, mine_atlas)

func generate_power_ups():
	var empty_cells = get_empty_cells()
	empty_cells.shuffle()

	var powerup_positions = []
	# Determine positions for 2 shields, 2 scanners, and 2 freezes
	# Ensure there are enough empty cells for all powerups
	var required_cells = 2 * 3 # 2 of each powerup type
	if empty_cells.size() < required_cells:
		push_warning("Not enough empty cells for all powerups. Placing fewer.")
		required_cells = empty_cells.size()

	for i in range(required_cells):
		powerup_positions.append(empty_cells.pop_front())

	# Assign powerups to the chosen positions
	# Use modulo to cycle through powerup types
	for i in range(powerup_positions.size()):
		var pos = powerup_positions[i]
		var powerup_type = i % 3 # 0: Shield, 1: Scanner, 2: Freeze

		var atlas_coords: Vector2i
		if powerup_type == 0:
			atlas_coords = shield_atlas
		elif powerup_type == 1:
			atlas_coords = scanner_atlas
		else: # powerup_type == 2
			atlas_coords = freeze_atlas

		set_cell(powerup_layer, pos, tile_id, atlas_coords)
		print("Placed powerup ", atlas_coords, " at ", pos) # Debugging powerup placement


func generate_numbers():
	clear_layer(number_layer) # Clear existing numbers
	for cell in get_empty_cells():
		var cnt := 0
		for nb in get_all_surrounding_cells(cell):
			if is_mine(nb):
				cnt += 1
		if cnt > 0:
			var r := randf()
			var atlas_coords: Vector2i
			# Adjusted probabilities for harder variants based on your code
			if r < 0.18:	 # 18% blurry
				atlas_coords = blurry_atlas[cnt - 1]
			elif r < 0.24:	 # 6% question
				atlas_coords = question_atlas[cnt - 1]
			elif r < 0.36:	 # 12% fake
				atlas_coords = fake_hint_atlas[cnt - 1]
			elif r < 0.51:	 # 15% shuffle
				atlas_coords = shuffle_atlas[cnt - 1]
			else:			 # 49% normal
				atlas_coords = number_atlas[cnt - 1]
			set_cell(number_layer, cell, tile_id, atlas_coords)

func generate_grass():
	for y in range(ROWS):
		for x in range(COLS):
			var toggle = ((x + y) % 2)
			# Grass tiles are on grass_layer
			set_cell(grass_layer, Vector2i(x, y), tile_id, Vector2i(3 - toggle, 0))

func get_empty_cells():
	var empty_cells := []
	for y in range(ROWS):
		for x in range(COLS):
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
				if (target_cell.x >= 0 and target_cell.x < COLS
					and target_cell.y >= 0 and target_cell.y < ROWS):
						surrounding_cells.append(target_cell)
	return surrounding_cells

func _input(event):
	# Only process input if the game is not paused or over
	if get_parent().get_current_state() != get_parent().GameState.PLAYING:
		return

	if event is InputEventMouseButton and event.pressed:
		var local_mouse_position = get_local_mouse_position()
		var map_pos = local_to_map(local_mouse_position)
		if map_pos.x >= 0 and map_pos.x < COLS and map_pos.y >= 0 and map_pos.y < ROWS:

			# --- Powerup Usage and Collection (Check BEFORE standard clicks) ---

			# Check if the clicked cell reveals a powerup after grass is removed
			# This check is now primarily in process_left_click after grass is erased.
			# The direct check below is removed.

			# Handle Left Click (including Scanner use and clicking Exclamation)
			if event.button_index == MOUSE_BUTTON_LEFT:
				if is_exclamation(map_pos):
					# Left-click on an exclamation mark
					erase_cell(exclamation_layer, map_pos) # Remove the mark
					if is_mine(map_pos):
						# It was a mine marked by scanner
						mine_triggered.emit(map_pos) # Trigger the mine (shield might save the user)
					else:
						# It was not a mine, reveal the cell normally
						process_left_click(map_pos) # This will reveal number/empty and check for powerups
					return # Consume the click event

				if is_grass(map_pos) and not is_flag(map_pos):
					# Left-click on grass (normal or using scanner)
					if get_parent().scanners_available > 0:
						# Use a scanner: Place exclamation mark
						set_cell(exclamation_layer, map_pos, tile_id, exclamation_atlas)
						get_parent().scanners_available -= 1
						get_parent().get_node("HUD").get_node("ScannerCount").text = str(get_parent().scanners_available) # Update HUD # Update HUD
						print("Scanner used: Placed '!' at ", map_pos) # Debug print
						return # Consume the click event, do not reveal the grass yet

					# Normal left-click on grass
					if get_parent().first_click:
						# Handle first click to ensure safe area
						clear_safe_area(map_pos)
						generate_numbers() # Generate numbers after safe area cleared
						process_left_click(map_pos)
					else:
						# Check if it's a mine before processing left click normally
						if is_mine(map_pos):
							mine_triggered.emit(map_pos) # Trigger mine (Main handles shield)
						else:
							process_left_click(map_pos) # Reveal non-mine cell

			# Handle Right Click (including Scanner use)
			elif event.button_index == MOUSE_BUTTON_RIGHT:
				if is_grass(map_pos):
					# Right-click on grass (normal flag or using scanner)
					if get_parent().scanners_available > 0:
						# Use a scanner: Place flag
						# Note: The user requested right click places a flag with scanner, contradicting the code's original '!' on right click.
						# Implementing user request: Right click with scanner places flag.
						# It doesn't remove grass immediately, like a normal flag.
						if get_used_cells(flag_layer).size() < get_parent().TOTAL_MINES:
							set_cell(flag_layer, map_pos, tile_id, flag_atlas)
							flag_placed.emit() # Emit signal to decrement remaining mines
							get_parent().scanners_available -= 1
							get_parent().get_node("HUD").get_node("ScannerCount").text = str(get_parent().scanners_available) # Update HUD # Update HUD
							print("Scanner used: Placed flag at ", map_pos) # Debug print
							# Do NOT reveal grass or call process_right_click further
						return # Consume the click event

					# Normal right-click on grass (toggle flag)
					process_right_click(map_pos)

			# Handle Chording (Left + Right click)
			if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
				chording = true
				# Chording logic remains the same

	# Handle button releases for chording (rest of _input remains)
	if event is InputEventMouseButton:
		var local_mouse_position = get_local_mouse_position()
		var map_pos = local_to_map(local_mouse_position)
		if map_pos.x >= 0 and map_pos.x < COLS and map_pos.y >= 0 and map_pos.y < ROWS:
			# Handle left button release for chording
			if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
				if chording:
					scan_mines(map_pos)
					chording = false
			# Handle right button release for chording
			elif event.button_index == MOUSE_BUTTON_RIGHT and not event.pressed:
				if chording:
					scan_mines(map_pos)
					chording = false


func process_left_click(pos):
	# Check if the cell is already revealed or flagged
	if !is_grass(pos) or is_flag(pos):
		return # Do nothing if already revealed or flagged

	total_clicks += 1	# Increment click counter
	if total_clicks > 3: # Apply variant changes after a few clicks
		try_revert_variants()

	#no longer first click
	get_parent().first_click = false

	var revealed_cells := []
	var cells_to_reveal := [pos]

	while not cells_to_reveal.is_empty():
		var current_cell = cells_to_reveal.pop_front() # Use pop_front for queue behavior

		# Skip if already revealed (grass is gone)
		if !is_grass(current_cell):
			continue

		# If the cell had a flag then clear it (should be caught by the initial check, but good failsafe)
		if is_flag(current_cell):
			erase_cell(flag_layer, current_cell)
			flag_removed.emit()

		# Clear grass and mark as revealed
		erase_cell(grass_layer, current_cell)
		revealed_cells.append(current_cell) # Keep track of revealed cells for this cascade

		# --- CHECK FOR POWERUP AFTER GRASS IS CLEARED ---
		var powerup_atlas = get_cell_atlas_coords(powerup_layer, current_cell)
		if powerup_atlas != Vector2i(-1, -1): # Check if there's a tile on the powerup layer
			if powerup_atlas == shield_atlas:
				shield_collected.emit()
				print("Shield collected at ", current_cell)
			elif powerup_atlas == scanner_atlas:
				scanner_collected.emit()
				print("Scanner collected at ", current_cell)
			elif powerup_atlas == freeze_atlas:
				# Note: freeze_collected signal should be emitted here when collected
				freeze_collected.emit() # Signal Main to handle the freeze effect
				print("Freeze collected at ", current_cell)
			# Erase the powerup tile after collection
			erase_cell(powerup_layer, current_cell)
		# --- END POWERUP CHECK ---


		# If the cell is not a number (empty), reveal surrounding cells
		if !is_number(current_cell) and !is_mine(current_cell): # Also check if it's NOT a mine
			for neighbor in get_all_surrounding_cells(current_cell):
				# Only add to cells_to_reveal if it's grass and not already queued or revealed
				if is_grass(neighbor) and not cells_to_reveal.has(neighbor) and !revealed_cells.has(neighbor):
					cells_to_reveal.append(neighbor)
		# If it *is* a number, the cascade stops here for this branch.
		# If it was a mine, it would have triggered game over before this function was called (handled in _input now).


	# After revealing, check for win condition
	check_win_condition()


func try_revert_variants():
	for cell in get_used_cells(number_layer):
		var atlas_coords = get_cell_atlas_coords(number_layer, cell)
		var current_row = atlas_coords.y

		# Only consider variant tiles (rows 2 to 5)
		if current_row < 2 || current_row > 5:
			continue

		# Recalculate surrounding mines
		var cnt := 0
		for neighbor in get_all_surrounding_cells(cell):
			if is_mine(neighbor):
				cnt += 1

		# If count is 0, it should be an empty cell, remove the number/variant
		if cnt == 0:
			erase_cell(number_layer, cell)
			continue

		var r = randf()

		# Logic for variant transformation
		if current_row == 5:	# Shuffle tiles (row 5)
			if r < 0.95:	# 95% stay shuffled
				continue
			# The 5% chance of changing: 2.5% revert to normal, 2.5% transform variant
			elif r < 0.975: # (0.95 + 0.025) 2.5% revert to normal
				set_cell(number_layer, cell, tile_id, number_atlas[cnt - 1])
			else: # (0.975 to 1.0) 2.5% transform variant
				set_random_variant(cell, cnt)
		else:					# Other variants (rows 2, 3, 4)
			# Adjusted probabilities
			if r < 0.35:	# 35% revert normal
				set_cell(number_layer, cell, tile_id, number_atlas[cnt - 1])
			elif r < 0.75:	# 40% become shuffle (0.75 - 0.35)
				set_cell(number_layer, cell, tile_id, shuffle_atlas[cnt - 1])
			else:			# 25% random variant (0.75 to 1.0)
				set_random_variant(cell, cnt)


func set_random_variant(cell, cnt):
	# Higher chance to become shuffle variant, exclude the current row variant
	var variants = []
	if get_cell_atlas_coords(number_layer, cell).y != 5: variants.append(shuffle_atlas[cnt - 1]) # Add shuffle
	if get_cell_atlas_coords(number_layer, cell).y != 5: variants.append(shuffle_atlas[cnt - 1]) # Add shuffle again for weight
	if get_cell_atlas_coords(number_layer, cell).y != 2: variants.append(blurry_atlas[cnt - 1])
	if get_cell_atlas_coords(number_layer, cell).y != 3: variants.append(question_atlas[cnt - 1])
	if get_cell_atlas_coords(number_layer, cell).y != 4: variants.append(fake_hint_atlas[cnt - 1])

	if variants.size() > 0:
		set_cell(number_layer, cell, tile_id, variants.pick_random())


func process_right_click(pos):
	# Only process if there is grass
	if not is_grass(pos):
		return

	# 1) If there’s already a flag here, unflag it:
	if is_flag(pos):
		erase_cell(flag_layer, pos)
		flag_removed.emit()
		return

	# 2) If there’s an exclamation mark (scanner mark), convert it to a flag:
	# This logic was moved to the _input function to happen before the standard right-click.
	# Keeping it here as a failsafe, but it should be handled in _input first.
	if is_exclamation(pos):
		erase_cell(exclamation_layer, pos)
		set_cell(flag_layer, pos, tile_id, flag_atlas)
		flag_placed.emit()
		return

	# 3) Otherwise, place a flag if allowed
	# Check if the number of flags doesn't exceed the total mines
	if get_used_cells(flag_layer).size() < get_parent().TOTAL_MINES:
		set_cell(flag_layer, pos, tile_id, flag_atlas)
		flag_placed.emit()


func show_mines():
	for mine in mine_coords:
		# Make sure to remove grass or flags covering the mine
		if is_grass(mine):
			erase_cell(grass_layer, mine)
		if is_flag(mine):
			erase_cell(flag_layer, mine)
			# Don't emit flag_removed here, as this is game over state

		# Optional: Draw mine tile on top layer if needed, but mine_layer should be visible after grass removal
		# For clarity, you might want to ensure the mine tile is drawn on the mine_layer and that layer is visible.


func move_mine(old_pos):
	# Remove the mine from its old position on the mine_layer and the mine_coords array
	erase_cell(mine_layer, old_pos)
	var mine_index = mine_coords.find(old_pos)
	if mine_index != -1:
		mine_coords.remove_at(mine_index)

	# Find a new safe position
	var new_pos = Vector2i(randi_range(0, COLS - 1), randi_range(0, ROWS - 1))
	# The new position must not be a mine AND must not be within the cleared safe zone (the 3x3 area around the first click)
	# To check against the safe zone, we need to know the first click position.
	# For simplicity now, just ensure it's not already a mine.
	while mine_coords.has(new_pos):
		new_pos = Vector2i(randi_range(0, COLS - 1), randi_range(0, ROWS - 1))

	# Add the mine to the new position and update the mine_coords array
	mine_coords.append(new_pos)
	set_cell(mine_layer, new_pos, tile_id, mine_atlas)
	print("Moved mine from ", old_pos, " to ", new_pos) # Debug print


func _process(_delta):
	# Clear hover tiles at the beginning of each frame
	clear_layer(hover_layer)
	var mouse_map_pos := local_to_map(get_local_mouse_position())

	# Check if the mouse is within the grid bounds AND game is playing
	if get_parent().get_current_state() == get_parent().GameState.PLAYING and \
	   mouse_map_pos.x >= 0 and mouse_map_pos.x < COLS and mouse_map_pos.y >= 0 and mouse_map_pos.y < ROWS:

		# Check if both left and right mouse buttons are currently pressed (Chording)
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
			chording = true
			# If the center cell is a revealed number, highlight surrounding grass cells
			if is_number(mouse_map_pos):
				highlight_surrounding_grass(mouse_map_pos)
			# Optionally, highlight the center cell too
			set_cell(hover_layer, mouse_map_pos, tile_id, hover_atlas) # Uncomment to highlight center
		else:
			chording = false
			# Single cell highlighting for grass or revealed numbers when not chording
			# Only highlight if grass is present OR if it's a revealed number AND not covered by flag/exclamation
			if (is_grass(mouse_map_pos) and not is_flag(mouse_map_pos) and not is_exclamation(mouse_map_pos)) or \
			   (is_number(mouse_map_pos) and not is_grass(mouse_map_pos) and not is_flag(mouse_map_pos) and not is_exclamation(mouse_map_pos)):
				set_cell(hover_layer, mouse_map_pos, tile_id, hover_atlas)


# New function to highlight surrounding grass cells
func highlight_surrounding_grass(center_cell_map_pos):
	for cell in get_all_surrounding_cells(center_cell_map_pos):
		# Only highlight grass that is not flagged or marked with exclamation
		if is_grass(cell) and not is_flag(cell) and not is_exclamation(cell):
			set_cell(hover_layer, cell, tile_id, hover_atlas)

func scan_mines(pos):
	# Check if the cell is a revealed number before chording
	if not is_number(pos):
		return # Chording only works on revealed numbers

	var surrounding_flags = 0
	var has_unflagged_mine_nearby = false
	var cells_to_reveal_on_chording = []

	for neighbor in get_all_surrounding_cells(pos):
		if is_flag(neighbor):
			surrounding_flags += 1
			# Check if a flag is placed incorrectly on a non-mine
			if not is_mine(neighbor):
				has_unflagged_mine_nearby = true # Flag on a non-mine means game over on chording

		# Identify grass cells around the number that are not flagged or exclamation marked
		if is_grass(neighbor) and not is_flag(neighbor) and not is_exclamation(neighbor):
			cells_to_reveal_on_chording.append(neighbor)
			# Check if any of these unflagged grass cells hide a mine
			if is_mine(neighbor):
				has_unflagged_mine_nearby = true # Unflagged mine means game over on chording

	# Game over if there's a flag on a non-mine or an unflagged mine nearby when chording
	if has_unflagged_mine_nearby:
		end_game.emit()
		show_mines() # Reveal all mines
		return

	# Get the required flag count from the number tile
	var required_flags = get_cell_atlas_coords(number_layer, pos).x + 1

	# If the number of surrounding flags matches the required count, reveal unflagged grass cells
	if surrounding_flags == required_flags:
		for cell in cells_to_reveal_on_chording:
			process_left_click(cell) # Reveal the cell

	else:
		# Optional: Provide feedback for incorrect flag count
		# print("Incorrect number of flags around cell ", pos, ". Required: ", required_flags, ", Found: ", surrounding_flags)
		pass # Do nothing if flag count is incorrect


func clear_safe_area(center_pos):
	var safe_zone = get_all_surrounding_cells(center_pos)
	safe_zone.append(center_pos) # Include the center cell

	var mines_in_safe_zone = []
	for cell in safe_zone:
		if is_mine(cell):
			mines_in_safe_zone.append(cell)

	# Move any mines found in the safe zone
	for mine_pos in mines_in_safe_zone:
		move_mine(mine_pos)

	# After moving mines, regenerate numbers because mine positions have changed
	# This is done in new_game and after clear_safe_area in _input


#helper functions
func is_mine(pos):
	# Check if there is a tile on the mine layer at this position
	return get_cell_source_id(mine_layer, pos) != -1

func is_grass(pos):
	# Check if there is a tile on the grass layer at this position
	return get_cell_source_id(grass_layer, pos) != -1

func is_number(pos):
	# Check if there is a tile on the number layer at this position
	return get_cell_source_id(number_layer, pos) != -1

func is_flag(pos):
	# Check if there is a tile on the flag layer at this position
	return get_cell_source_id(flag_layer, pos) != -1

func check_win_condition():
	var grass_cells_left = 0
	for y in range(ROWS):
		for x in range(COLS):
			if is_grass(Vector2i(x, y)):
				grass_cells_left += 1

	# Win condition: The number of remaining grass cells equals the total number of mines
	if grass_cells_left == mine_coords.size():
		game_won.emit()
		# Optionally, auto-flag all mines on win
		for mine in mine_coords:
			if not is_flag(mine):
				set_cell(flag_layer, mine, tile_id, flag_atlas)
				# No need to emit flag_placed here, as game is over

# Helper function to check for powerups (moved logic to process_left_click)
# func is_powerup(pos):
#	 return get_cell_source_id(powerup_layer, pos) != -1

func is_exclamation(pos):
	# Check if there is a tile on the exclamation layer at this position
	return get_cell_source_id(exclamation_layer, pos) != -1
