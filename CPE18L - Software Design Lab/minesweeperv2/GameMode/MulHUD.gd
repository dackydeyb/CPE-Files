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

	# Set initial alpha to 0.0 and trigger fade-in after delay for both players
	for player_id in player_hud_elements:
		var shield_indicator = player_hud_elements[player_id].shield_indicator
		if shield_indicator:
			shield_indicator.modulate.a = 0.0

	# Wait for the defined delay before triggering the initial fade-in
	await get_tree().create_timer(INITIAL_FADE_IN_DELAY).timeout

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
		print("Error: HUD elements for player ", player_id, " not found.")
		return

	var player_data = player_hud_elements[player_id]
	var shield_indicator = player_data.shield_indicator

	if shield_indicator == null:
		print("Error: ShieldStatusTextureRect not found for player ", player_id, " in HUD.")
		return

	if state == player_data.current_display_state and shield_indicator.modulate.a > 0.0:
		return

	if player_data.shield_tween:
		player_data.shield_tween.kill()
	player_data.shield_tween = create_tween()
	if shield_indicator.modulate.a > 0.0:
		player_data.shield_tween.tween_property(shield_indicator, "modulate:a", 0.0, 0.35)
	player_data.shield_tween.tween_callback(_set_shield_texture_by_state.bind(player_id, state))
	var target_alpha = 1.0 if state == "inactive" else 1.5
	player_data.shield_tween.tween_property(shield_indicator, "modulate:a", target_alpha, 0.35)
	player_data.shield_tween.tween_callback(func(): _on_shield_tween_completed(player_id, state))
	player_data.current_display_state = state

# Modified to accept player_id
func _on_shield_tween_completed(player_id: int, state: String):
	if not player_hud_elements.has(player_id) or state != player_hud_elements[player_id].current_display_state:
		return
	var player_data = player_hud_elements[player_id]
	var shield_indicator = player_data.shield_indicator
	if state == "active_fast":
		if player_data.shield_tween:
			player_data.shield_tween.kill()
		player_data.shield_tween = create_tween()
		player_data.shield_tween.set_loops()
		player_data.shield_tween.tween_property(shield_indicator, "modulate:a", 0.0, 0.3)
		player_data.shield_tween.tween_property(shield_indicator, "modulate:a", 1.5, 0.3)
	elif state == "active_steady":
		shield_indicator.modulate.a = 1.5

# Modified to accept player_id
func _set_shield_texture_by_state(player_id: int, state: String):
	if not player_hud_elements.has(player_id) or player_hud_elements[player_id].shield_indicator == null:
		return
	var shield_indicator = player_hud_elements[player_id].shield_indicator

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

# Modified to accept player_id
func reset_display(player_id: int):
	if not player_hud_elements.has(player_id):
		return
	var player_data = player_hud_elements[player_id]
	if player_data.shield_tween:
		player_data.shield_tween.kill()
		player_data.shield_tween = null
	if player_data.shield_indicator:
		player_data.shield_indicator.modulate.a = 0.0
	player_data.current_display_state = ""
