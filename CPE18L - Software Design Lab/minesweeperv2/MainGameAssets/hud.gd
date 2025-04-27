# HUD script:
extends Panel

const shield_active_texture = preload("res://MainGameAssets/shieldActivated.png")     # Up arrow
const shield_inactive_texture = preload("res://MainGameAssets/shieldDeactivated.png") # Inactive texture
const shield_active_flagged_texture = preload("res://MainGameAssets/shieldDeactivated.png") # Down arrow

@onready var shield_status_indicator: TextureRect = $ShieldStatusTextureRect

var current_display_state: String = "inactive" # Keep track of the current visual state
var shield_tween: Tween = null # Variable to hold the active tween for fades

func _set_shield_texture_by_state(state: String):
	match state:
		"active":
			shield_status_indicator.texture = shield_active_texture
		"active_flagged":
			shield_status_indicator.texture = shield_active_flagged_texture
		"inactive":
			shield_status_indicator.texture = shield_inactive_texture
		_: shield_status_indicator.texture = shield_inactive_texture

func update_shield_display(state: String):
	if shield_status_indicator == null:
		print("Error: ShieldStatusTextureRect not found in HUD.")
		return
	if state == current_display_state:
		return
	if shield_tween:
		shield_tween.kill()
	shield_tween = create_tween()

	# --- Fade Out ---
	# Tween the alpha channel of the modulate property to 0 (transparent)
	# Duration is 0.15 seconds (adjust as needed)
	shield_tween.tween_property(shield_status_indicator, "modulate:a", 0.0, 0.35)
	shield_tween.tween_callback(_set_shield_texture_by_state.bind(state))

	# --- Fade In ---
	# Then, tween the alpha channel back to 1 (opaque)
	# Duration is also 0.15 seconds
	shield_tween.tween_property(shield_status_indicator, "modulate:a", 1.5, 0.35)
	# Update the tracker variable to the new state
	current_display_state = state


func _ready():
	add_to_group("hud")
	shield_status_indicator.modulate.a = 1.5 
	update_shield_display("inactive")
