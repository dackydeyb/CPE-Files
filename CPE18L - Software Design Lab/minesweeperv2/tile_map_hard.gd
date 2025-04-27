extends TileMap

signal end_game
signal game_won
signal flag_placed
signal flag_removed

# Grid variables
const ROWS : int = 14
const COLS : int = 32
const CELL_SIZE : int = 50

# Tilemap variables
var tile_id : int = 0

# Layer variables
var background_layer : int = 0
var powerup_layer : int = 1
var number_layer : int = 2
var mine_layer : int = 3
var grass_layer : int = 4
var flag_layer : int = 5
var hover_layer : int = 6

# Atlas coordinates
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

# Array to store mine coordinates
var mine_coords := []
var chording := false
var shield_count: int = 0

var shield_active : bool = false
var has_flag_been_placed_while_shield_active : bool = false

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

func new_game():
	clear()
	mine_coords.clear()
	generate_background()
	generate_mines()
	generate_numbers()
	generate_grass()
	generate_powerups()
	shield_active = false
	shield_count = 0
	has_flag_been_placed_while_shield_active = false
	update_hud()

func generate_background():
	for y in range(ROWS):
		for x in range(COLS):
			var toggle = ((x + y) % 2)
			var background_tile = background_atlas_light if toggle == 0 else background_atlas_dark
			set_cell(background_layer, Vector2i(x, y), tile_id, background_tile)

func generate_powerups():
	clear_layer(powerup_layer)
	var num_shields = 5
	var placed = 0
	var attempts = 0
	while placed < num_shields and attempts < 1000:
		var pos = Vector2i(randi_range(0, COLS - 1), randi_range(0, ROWS - 1))
		if is_grass(pos) and not is_mine(pos) and get_cell_source_id(number_layer, pos) == -1:
			set_cell(powerup_layer, pos, tile_id, shield_atlas)
			placed += 1
		attempts += 1
	if placed < num_shields:
		print("Warning: Could not place all %d shields. Placed %d." % [num_shields, placed])

func generate_mines():
	for i in range(get_parent().TOTAL_MINES):
		var mine_pos = Vector2i(randi_range(0, COLS - 1), randi_range(0, ROWS - 1))
		while mine_coords.has(mine_pos):
			mine_pos = Vector2i(randi_range(0, COLS - 1), randi_range(0, ROWS - 1))
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
	for y in range(ROWS):
		for x in range(COLS):
			var toggle = ((x + y) % 2)
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
				if (target_cell.x >= 0 and target_cell.x < COLS and target_cell.y >= 0 and target_cell.y < ROWS):
					surrounding_cells.append(target_cell)
	return surrounding_cells

func _input(event):
	if event is InputEventMouseButton:
		var local_mouse_position = get_local_mouse_position()
		var map_pos = local_to_map(local_mouse_position)
		if map_pos.x >= 0 and map_pos.x < COLS and map_pos.y >= 0 and map_pos.y < ROWS:
			if event.button_index == MOUSE_BUTTON_LEFT:
				if event.pressed:
					if is_grass(map_pos) and not is_flag(map_pos):
						if not Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
							if get_parent().first_click:
								clear_safe_area(map_pos)
								generate_numbers()
								process_left_click(map_pos)
							else:
								if is_mine(map_pos):
									if shield_active:
										print("Shield saved you!")
										set_cell(flag_layer, map_pos, tile_id, flag_atlas)
										flag_placed.emit()
										shield_count -= 1 # <--- Decrement shield count
										has_flag_been_placed_while_shield_active = false # <--- Reset the flagged state when a shield is used
										update_hud() # <--- Update HUD based on new count and state
										print("Shield used. Count: ", shield_count) # Debug print
									else:
										end_game.emit()
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
	if total_clicks > 3:
		try_revert_variants()
	get_parent().first_click = false
	var revealed_cells := []
	var cells_to_reveal := [pos]
	while not cells_to_reveal.is_empty():
		var current_cell = cells_to_reveal.pop_front()
		if revealed_cells.has(current_cell) or not is_grass(current_cell):
			continue
		if is_mine(current_cell):
			continue
		erase_cell(grass_layer, current_cell)
		revealed_cells.append(current_cell)
		if is_shield(current_cell):
			print("Shield found at: ", current_cell)
			activate_shield()
			erase_cell(powerup_layer, current_cell)
		if is_flag(current_cell):
			erase_cell(flag_layer, current_cell)
			flag_removed.emit()
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
		flag_removed.emit()
		if is_mine(pos) and shield_count > 0:
			shield_count -= 1
			has_flag_been_placed_while_shield_active = false
		update_hud()
		return
	if get_used_cells(flag_layer).size() >= get_parent().TOTAL_MINES:
		return
	set_cell(flag_layer, pos, tile_id, flag_atlas)
	flag_placed.emit()
	if shield_count > 0 and not has_flag_been_placed_while_shield_active and not is_mine(pos):
		has_flag_been_placed_while_shield_active = true
	update_hud()

func show_mines():
	# Reveal all mines
	for mine_pos in get_used_cells(mine_layer):
		if is_grass(mine_pos):
			erase_cell(grass_layer, mine_pos)

	for shield_pos in get_used_cells(powerup_layer):
		if is_grass(shield_pos):
			erase_cell(grass_layer, shield_pos)

func show_uncollected_powerups():
	print("Showing uncollected shields...")
	for y in range(ROWS):
		for x in range(COLS):
			var pos = Vector2i(x, y)
			if is_shield(pos):
				if is_grass(pos):
					erase_cell(grass_layer, pos)

func move_mine(old_pos):
	var new_pos = Vector2i(randi_range(0, COLS - 1), randi_range(0, ROWS - 1))
	while mine_coords.has(new_pos):
		new_pos = Vector2i(randi_range(0, COLS - 1), randi_range(0, ROWS - 1))
	var mine_index = mine_coords.find(old_pos)
	if mine_index != -1:
		mine_coords[mine_index] = new_pos
		erase_cell(mine_layer, old_pos)
		set_cell(mine_layer, new_pos, tile_id, mine_atlas)

func _process(_delta):
	clear_layer(hover_layer)
	var mouse_map_pos := local_to_map(get_local_mouse_position())
	if mouse_map_pos.x >= 0 and mouse_map_pos.x < COLS and mouse_map_pos.y >= 0 and mouse_map_pos.y < ROWS:
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
	if shield_active:
		for i in get_all_surrounding_cells(pos):
			if is_flag(i):
				surrounding_flags += 1
				if not is_mine(i):
					flag_on_non_mine_nearby = true
			# Check specifically for an adjacent unflagged mine
			if is_mine(i) and not is_flag(i):
				unflagged_mine_cell_nearby = i 
	if unflagged_mine_cell_nearby != Vector2i(-1, -1):
		if shield_active:
			print("Shield saved you from chording into an unflagged mine!")
			set_cell(flag_layer, unflagged_mine_cell_nearby, tile_id, flag_atlas)
			flag_placed.emit()
			shield_count -= 1
			has_flag_been_placed_while_shield_active = false
			update_hud()
			print("Chording Shield used. Count: ", shield_count)
			return
		else:
			print("Chording failed - hit an unflagged mine!")
			end_game.emit()
			show_mines()
			return
	if flag_on_non_mine_nearby:
		print("Chording failed - flag placed on a non-mine!")
		end_game.emit()
		show_mines()
		return
	if is_number(pos):
		var required_flags = get_cell_atlas_coords(number_layer, pos).x + 1
		if surrounding_flags == required_flags:
			for cell in get_all_surrounding_cells(pos):
				if is_grass(cell) and not is_flag(cell):
					process_left_click(cell) # Reveal safe surrounding cells
		else:
			print("Incorrect number of flags around cell ", pos)
func clear_safe_area(center_pos):
	var safe_zone = get_all_surrounding_cells(center_pos)
	safe_zone.append(center_pos)
	for safe_cell in safe_zone:
		if is_mine(safe_cell):
			move_mine(safe_cell)

func activate_shield():
	shield_count += 1
	update_hud()
	print("Shield activated! Count: ", shield_count)

func deactivate_shield():
	shield_active = false
	has_flag_been_placed_while_shield_active = false
	get_tree().call_group("hud", "update_shield_display", "inactive")

#helper functions
func update_hud():
	var hud_state = "inactive"
	if shield_count > 0:
		shield_active = true
		if has_flag_been_placed_while_shield_active:
			hud_state = "active_flagged" 
		else:
			hud_state = "active"
	else:
		shield_active = false
	get_tree().call_group("hud", "update_shield_display", hud_state)

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
	for y in range(ROWS):
		for x in range(COLS):
			if is_grass(Vector2i(x, y)):
				grass_cells_left += 1
	if grass_cells_left == mine_coords.size():
		game_won.emit()
		for mine in mine_coords:
			if not is_flag(mine):
				set_cell(flag_layer, mine, tile_id, flag_atlas)
				flag_placed.emit()
