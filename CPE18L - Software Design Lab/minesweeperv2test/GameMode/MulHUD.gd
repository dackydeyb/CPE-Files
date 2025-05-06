# MulHUD.gd
extends Panel

const shield_active_texture = preload("res://MainGameAssets/shieldActivated.png")
const shield_inactive_texture = preload("res://MainGameAssets/shieldDeactivated.png")
const shield_active_flagged_texture = preload("res://MainGameAssets/shieldDeactivated.png") # This texture seems wrong for "flagged" state?

# Use dictionaries to hold references/states for each player
var player_hud_elements = {
	1: { "mines_label": null, "shield_indicator": null, "current_display_state": "inactive", "shield_tween": null },
	2: { "mines_label": null, "shield_indicator": null, "current_display_state": "inactive", "shield_tween": null }
}

# Define the delay before the initial fade-in
const INITIAL_FADE_IN_DELAY = 1.0

# --- Add Status Label Outlet ---
@onready var status_label: Label = $"../StatusLabel"# Adjust path if needed (e.g., $VBoxContainer/StatusLabel)

func _ready():
	# Get references to the player-specific HUD elements
	if has_node("Player1HUD/RemainingMinesPLayer1"):
		player_hud_elements[1].mines_label = $Player1HUD/RemainingMinesPLayer1
	if has_node("Player1HUD/ShieldStatusTextureRect"):
		player_hud_elements[1].shield_indicator = $Player1HUD/ShieldStatusTextureRect
	if has_node("Player2HUD/RemainingMinesPlayer2"):
		player_hud_elements[2].mines_label = $Player2HUD/RemainingMinesPlayer2
	if has_node("Player2HUD/ShieldStatusTextureRect"):
		player_hud_elements[2].shield_indicator = $Player2HUD/ShieldStatusTextureRect

	# --- Add check for StatusLabel ---
	if not is_instance_valid(status_label):
		print("Warning: StatusLabel node not found or invalid in MulHUD.")
	# ---------------------------------

	# Set initial alpha to 0.0 and trigger fade-in after delay for both players
	for player_id in player_hud_elements:
		var shield_indicator = player_hud_elements[player_id].shield_indicator
		if shield_indicator:
			shield_indicator.modulate.a = 0.0

	# Wait for the defined delay before triggering the initial fade-in
	await get_tree().create_timer(INITIAL_FADE_IN_DELAY).timeout
	if not is_instance_valid(self): return # Node might have been freed

	# Trigger the initial fade-in for both players
	for player_id in player_hud_elements:
		update_shield_display(player_id, "inactive")


# Modified to accept player_id
func update_mines_display(player_id: int, remaining_mines: int):
	if player_hud_elements.has(player_id) and player_hud_elements[player_id].mines_label:
		player_hud_elements[player_id].mines_label.text = str(remaining_mines)


# Modified to accept player_id
func update_shield_display(player_id: int, state: String):
	if not player_hud_elements.has(player_id):
		printerr("Error: HUD elements for player ", player_id, " not found.")
		return

	var player_data = player_hud_elements[player_id]
	var shield_indicator = player_data.shield_indicator

	if shield_indicator == null:
		printerr("Error: ShieldStatusTextureRect not found for player ", player_id, " in HUD.")
		return

	# Don't restart tween if state is the same AND it's already visible
	if state == player_data.current_display_state and shield_indicator.modulate.a > 0.0:
		# Exception: ensure steady/fast state transitions correctly if needed
		if state == "active_steady" or state == "active_fast":
			_on_shield_tween_completed(player_id, state) # Apply steady/fast visual properties
		return


	if player_data.shield_tween and player_data.shield_tween.is_valid():
		player_data.shield_tween.kill()

	player_data.shield_tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT) # Example transition

	# Fade out current if visible
	if shield_indicator.modulate.a > 0.0:
		player_data.shield_tween.tween_property(shield_indicator, "modulate:a", 0.0, 0.25) # Faster fade out

	# Change texture during fade (or instantly if starting from transparent)
	player_data.shield_tween.tween_callback(_set_shield_texture_by_state.bind(player_id, state))

	# Fade In
	var target_alpha = 1.0 # Target alpha for most states
	# You used 1.5 before, maybe for emissive effect? Let's stick to 1.0 for standard alpha.
	# target_alpha = 1.5 if (state == "active_fast" or state == "active_steady") else 1.0
	player_data.shield_tween.tween_property(shield_indicator, "modulate:a", target_alpha, 0.25) # Faster fade in

	# Set loop/final state AFTER fade in
	player_data.shield_tween.tween_callback(func(): _on_shield_tween_completed(player_id, state))

	player_data.current_display_state = state


# Modified to accept player_id
func _on_shield_tween_completed(player_id: int, state: String):
	if not player_hud_elements.has(player_id) or not is_instance_valid(self): # Check if node exists
		return
	# Check if the state is still the intended final state
	if state != player_hud_elements[player_id].current_display_state:
		return

	var player_data = player_hud_elements[player_id]
	var shield_indicator = player_data.shield_indicator
	if not is_instance_valid(shield_indicator): return

	# Kill any previous looping tween for safety
	if player_data.shield_tween and player_data.shield_tween.is_valid():
		player_data.shield_tween.kill() # Kill the fade tween
		player_data.shield_tween = null # Clear reference


	if state == "active_fast":
		# Create a NEW tween just for looping animation
		player_data.shield_tween = create_tween()
		player_data.shield_tween.set_loops()
		player_data.shield_tween.tween_property(shield_indicator, "modulate:a", 0.3, 0.3).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT) # Dim
		player_data.shield_tween.tween_property(shield_indicator, "modulate:a", 1.0, 0.3).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT) # Brighten
	elif state == "active_steady":
		shield_indicator.modulate.a = 1.0 # Ensure steady state is fully visible
	elif state == "inactive":
		shield_indicator.modulate.a = 1.0 # Ensure inactive state is fully visible (after fade)


# Modified to accept player_id
func _set_shield_texture_by_state(player_id: int, state: String):
	if not player_hud_elements.has(player_id) or player_hud_elements[player_id].shield_indicator == null:
		return
	var shield_indicator = player_hud_elements[player_id].shield_indicator
	if not is_instance_valid(shield_indicator): return

	match state:
		"active", "active_fast", "active_steady":
			shield_indicator.texture = shield_active_texture
		"active_flagged":
			# Consider if you need a different texture here
			shield_indicator.texture = shield_active_flagged_texture
		"inactive":
			shield_indicator.texture = shield_inactive_texture
		_ :
			shield_indicator.texture = shield_inactive_texture

# --- Add set_status Function ---
func set_status(message: String):
	if is_instance_valid(status_label):
		status_label.text = message
	else:
		print("MulHUD: Cannot set status, StatusLabel is invalid.")
# -----------------------------

# Modified reset_display for clarity
func reset_display(player_id: int):
	if not player_hud_elements.has(player_id):
		return

	print("Resetting HUD Display for Player: ", player_id) # Debug print

	var player_data = player_hud_elements[player_id]

	# Kill any active tween
	if player_data.shield_tween and player_data.shield_tween.is_valid():
		player_data.shield_tween.kill()
		player_data.shield_tween = null

	# Reset shield indicator visual state
	if is_instance_valid(player_data.shield_indicator):
		player_data.shield_indicator.modulate.a = 1.0 # Start visible
		player_data.shield_indicator.texture = shield_inactive_texture
	else:
		print("Warning: Shield indicator invalid for player ", player_id, " on reset.")


	# Reset mines label
	if is_instance_valid(player_data.mines_label):
		# Set to initial value (e.g., from config or default)
		# update_mines_display(player_id, initial_mine_count) # Need initial count here
		player_data.mines_label.text = "--" # Placeholder until updated
	else:
		print("Warning: Mines label invalid for player ", player_id, " on reset.")


	# Reset internal state tracking
	player_data.current_display_state = "inactive" # Should match the visual reset


	# Clear status label (maybe only if player_id is 1 or relevant?)
	# Or clear it always on reset? Let's clear it.
	if is_instance_valid(status_label):
		status_label.text = ""
