extends TileMap

signal end_game
signal game_won
signal flag_placed
signal flag_removed

#grid variables
const ROWS : int = 6
const COLS : int = 13
const CELL_SIZE : int = 50

#tilemap variables
var tile_id : int = 0

#layer variables
var background_layer : int = 0 # New background layer
var mine_layer : int = 1
var number_layer : int = 2
var grass_layer : int = 3
var flag_layer : int = 4
var hover_layer : int = 5

#atlas coordinates
var mine_atlas := Vector2i(4, 0)
var flag_atlas := Vector2i(5, 0)
var hover_atlas := Vector2i(6, 0)
var number_atlas : Array = generate_number_atlas()
# Atlas coordinates for the revealed background tiles (assuming 0,0 and 1,0)
var background_atlas_light := Vector2i(0, 0)
var background_atlas_dark := Vector2i(1, 0)


#array to store mine coordinates
var mine_coords := []

#toggle variale scan nearby mines (repurposed for tracking if both buttons are pressed)
var chording := false # Renamed for clarity

func generate_number_atlas():
	var a := []
	for i in range(8):
		a.append(Vector2i(i, 1))
	return a

func _ready():
	new_game()

#reset game
func new_game():
	clear()
	mine_coords.clear()
	generate_background() # Generate the background layer
	generate_mines()
	generate_numbers()
	generate_grass()

# Function to generate the checkered background layer
func generate_background():
	for y in range(ROWS):
		for x in range(COLS):
			var toggle = ((x + y) % 2)
			# Use atlas coordinates (0,0) and (1,0) for the background
			var background_tile = background_atlas_light if toggle == 0 else background_atlas_dark
			set_cell(background_layer, Vector2i(x, y), tile_id, background_tile)

func generate_mines():
	for i in range(get_parent().TOTAL_MINES):
		var mine_pos = Vector2i(randi_range(0, COLS - 1), randi_range(0, ROWS - 1))
		while mine_coords.has(mine_pos):
			mine_pos = Vector2i(randi_range(0, COLS - 1), randi_range(0, ROWS - 1))
		mine_coords.append(mine_pos)
		#add mine to tilemap
		set_cell(mine_layer, mine_pos, tile_id, mine_atlas)

func generate_numbers():
	#clear previous number in case the mine is moved
	clear_layer(number_layer)
	for i in get_empty_cells():
		var mine_count : int = 0
		for j in get_all_surrounding_cells(i):
				#check if there is a min in the cell
			if is_mine(j):
				mine_count += 1
		if mine_count > 0 :
			set_cell(number_layer, i, tile_id, number_atlas[mine_count - 1])

func generate_grass():
	for y in range(ROWS):
		for x in range(COLS):
			var toggle = ((x + y) % 2)
			# Assuming (3,0) and (2,0) are your grass tiles based on your previous code
			set_cell(grass_layer, Vector2i(x, y), tile_id, Vector2i(3 - toggle, 0))

func get_empty_cells():
	var empty_cells := []
	for y in range(ROWS):
		for x in range(COLS):
			#check if the cell is empty and add it to the array
			if not is_mine(Vector2i(x, y)):
				empty_cells.append(Vector2i(x, y))
	return empty_cells

func get_all_surrounding_cells(middle_cell):
	var surrounding_cells := []
	var target_cell
	for y in range(3):
		for x in range(3):
			target_cell = middle_cell + Vector2i(x - 1, y - 1)
			#skip cell if it is the one in the middle
			if target_cell != middle_cell:
				#check that the cell is on the grid
				if (target_cell.x >= 0 and target_cell.x < COLS
					and target_cell.y >= 0 and target_cell.y < ROWS):
						surrounding_cells.append(target_cell)
	return surrounding_cells

func _input(event):
	if event is InputEventMouseButton:
		# Get the mouse position relative to the TileMap
		var local_mouse_position = get_local_mouse_position()
		var map_pos = local_to_map(local_mouse_position)

		# Check if the map_pos is within your grid dimensions
		if map_pos.x >= 0 and map_pos.x < COLS and map_pos.y >= 0 and map_pos.y < ROWS:
			# Check for left click release to trigger chord action if chording was active
			if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed and chording:
				# Process chord action (reveal surrounding or end game)
				scan_mines(map_pos)
				chording = false # Reset chording state

			# Check for left click press
			elif event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				# Only process left click if not currently chording
				if not Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
					#check that there is no flag there
					if not is_flag(map_pos):
						#check if it is a mine
						if get_parent().first_click:
							# Ensure first click is safe and surrounded by no mines
							clear_safe_area(map_pos)
							generate_numbers()
							process_left_click(map_pos)
						else:
							if is_mine(map_pos):
								end_game.emit()
								show_mines()
							else:
								process_left_click(map_pos)


			# Check for right click press
			elif event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
				# Only process right click if not currently chording
				if not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
					process_right_click(map_pos)

			# Check for right click release to trigger chord action if chording was active
			elif event.button_index == MOUSE_BUTTON_RIGHT and not event.pressed and chording:
				# Process chord action (reveal surrounding or end game)
				scan_mines(map_pos)
				chording = false # Reset chording state


func process_left_click(pos):
	#no longer first click
	get_parent().first_click = false
	var revealed_cells := []
	var cells_to_reveal := [pos]
	while not cells_to_reveal.is_empty():
		var current_cell = cells_to_reveal.pop_front() # Use pop_front for queue behavior

		# Skip if already revealed
		if revealed_cells.has(current_cell):
			continue

		#clear cell and mark it cleared
		erase_cell(grass_layer, current_cell)
		revealed_cells.append(current_cell)

		#if the cell had a flag then clear it
		if is_flag(current_cell):
			erase_cell(flag_layer, current_cell)
			flag_removed.emit()

		# If the cell is not a number (empty), reveal surrounding cells
		if not is_number(current_cell):
			for neighbor in get_all_surrounding_cells(current_cell):
				# Only add to cells_to_reveal if it's grass and not already in the list or revealed
				if is_grass(neighbor) and not cells_to_reveal.has(neighbor) and not revealed_cells.has(neighbor):
					cells_to_reveal.append(neighbor)


	# After revealing, check for win condition
	check_win_condition()


func process_right_click(pos):
	#check if it is a grass cell
	if is_grass(pos):
		if is_flag(pos):
			erase_cell(flag_layer, pos)
			flag_removed.emit()
		else:
			# Only place flag if the total number of flags is less than total mines
			# Corrected function name from get_cells_used to get_used_cells
			if get_used_cells(flag_layer).size() < get_parent().TOTAL_MINES:
				set_cell(flag_layer, pos, tile_id, flag_atlas)
				flag_placed.emit()

func show_mines():
	for mine in mine_coords:
		# Ensure it's still a mine and not potentially overwritten
		if get_cell_source_id(mine_layer, mine) != -1:
			erase_cell(grass_layer, mine)

func move_mine(old_pos):
	# Find a new random position that is not a mine
	var new_pos = Vector2i(randi_range(0, COLS - 1), randi_range(0, ROWS - 1))
	while mine_coords.has(new_pos):
		new_pos = Vector2i(randi_range(0, COLS - 1), randi_range(0, ROWS - 1))

	# Update the mine_coords array
	var mine_index = mine_coords.find(old_pos)
	if mine_index != -1:
		mine_coords[mine_index] = new_pos
		# Clear the mine from the old position
		erase_cell(mine_layer, old_pos)
		# Place the mine at the new position
		set_cell(mine_layer, new_pos, tile_id, mine_atlas)

func _process(_delta):
	# Clear hover tiles at the beginning of each frame
	clear_layer(hover_layer)

	var mouse_map_pos := local_to_map(get_local_mouse_position())

	# Check if the mouse is within the grid bounds
	if mouse_map_pos.x >= 0 and mouse_map_pos.x < COLS and mouse_map_pos.y >= 0 and mouse_map_pos.y < ROWS:
		# Check if both left and right mouse buttons are currently pressed
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
			chording = true
			# If the center cell is a revealed number, highlight surrounding grass cells
			if is_number(mouse_map_pos):
				highlight_surrounding_grass(mouse_map_pos)
			# Optionally, highlight the center cell too
			# set_cell(hover_layer, mouse_map_pos, tile_id, hover_atlas) # Uncomment to highlight center

		else:
			chording = false
			# Single cell highlighting for grass or revealed numbers when not chording
			if is_grass(mouse_map_pos) or is_number(mouse_map_pos):
				set_cell(hover_layer, mouse_map_pos, tile_id, hover_atlas)

# New function to highlight surrounding grass cells
func highlight_surrounding_grass(center_cell_map_pos):
	# We assume center_cell_map_pos is a number tile based on the _process check
	for cell in get_all_surrounding_cells(center_cell_map_pos):
		if is_grass(cell):
			set_cell(hover_layer, cell, tile_id, hover_atlas)

func scan_mines(pos):
	# This function is triggered on mouse button release after chording
	# It implements the logic for revealing/ending game based on surrounding flags and mines

	var surrounding_flags = 0
	var _surrounding_mines = 0
	var unflagged_mines_nearby = false

	for i in get_all_surrounding_cells(pos):
		if is_flag(i):
			surrounding_flags += 1
			if not is_mine(i):
				unflagged_mines_nearby = true # Flag on a non-mine

		if is_mine(i):
			_surrounding_mines += 1

	# Game over if there's an unflagged mine nearby when chording
	if unflagged_mines_nearby:
		end_game.emit()
		show_mines()
		return

	# If the number of surrounding flags matches the number in the center cell
	# and there are no unflagged non-mines, reveal surrounding cells
	if is_number(pos):
		var required_flags = get_cell_atlas_coords(number_layer, pos).x + 1 # Number is atlas x + 1
		if surrounding_flags == required_flags:
			for cell in get_all_surrounding_cells(pos):
				if is_grass(cell) and not is_flag(cell):
					# Recursively process left click on unflagged grass cells
					process_left_click(cell)
		else:
			# Optionally, provide feedback that the flag count doesn't match
			print("Incorrect number of flags around cell ", pos)


# Helper function to check for win condition
func check_win_condition():
	var grass_cells_left = 0
	for y in range(ROWS):
		for x in range(COLS):
			if is_grass(Vector2i(x, y)):
				grass_cells_left += 1

	# Win condition: Number of grass cells left equals the number of mines
	if grass_cells_left == mine_coords.size():
		game_won.emit()
		# Optionally flag all remaining mines
		for mine in mine_coords:
			if not is_flag(mine):
				set_cell(flag_layer, mine, tile_id, flag_atlas)
				flag_placed.emit()

func clear_safe_area(center_pos):
	var safe_zone = get_all_surrounding_cells(center_pos)
	safe_zone.append(center_pos)  # include center in safe area

	for safe_cell in safe_zone:
		if is_mine(safe_cell):
			move_mine(safe_cell)


#helper functions
func is_mine(pos):
	return get_cell_source_id(mine_layer, pos) != -1

func is_grass(pos):
	return get_cell_source_id(grass_layer, pos) != -1

func is_number(pos):
	return get_cell_source_id(number_layer, pos) != -1

func is_flag(pos):
	return get_cell_source_id(flag_layer, pos) != -1
