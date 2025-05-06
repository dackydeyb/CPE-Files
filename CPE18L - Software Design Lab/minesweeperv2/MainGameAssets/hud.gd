# HUD script:
extends Panel

const shield_active_texture = preload("res://MainGameAssets/shieldActivated.png")        # Up arrow
const shield_inactive_texture = preload("res://MainGameAssets/shieldDeactivated.png") # Inactive texture
const shield_active_flagged_texture = preload("res://MainGameAssets/shieldDeactivated.png") # Down arrow

@onready var shield_status_indicator: TextureRect = $ShieldStatusTextureRect

var current_display_state: String = "inactive" # Keep track of the current visual state
var shield_tween: Tween = null # Variable to hold the active tween for fades

# Define the delay before the initial fade-in
const INITIAL_FADE_IN_DELAY = 1.0 # Adjust this value to control the delay duration in seconds

func update_shield_display(state: String):
	if shield_status_indicator == null:
		print("Error: ShieldStatusTextureRect not found in HUD.")
		return
	# Allow fading to the same state if it's the initial fade-in (from alpha 0)
	if state == current_display_state and shield_status_indicator.modulate.a > 0.0:
		return
	if shield_tween:
		shield_tween.kill()
	shield_tween = create_tween()

	# --- Fade Out (only if currently visible and not the initial state) ---
	if shield_status_indicator.modulate.a > 0.0:
		shield_tween.tween_property(shield_status_indicator, "modulate:a", 0.0, 0.35)

	shield_tween.tween_callback(_set_shield_texture_by_state.bind(state))

	# --- Fade In ---
	# If the target state is "inactive", fade to alpha 1.0. Otherwise, fade to 1.5 for active states.
	var target_alpha = 1.0 if state == "inactive" else 1.5
	shield_tween.tween_property(shield_status_indicator, "modulate:a", target_alpha, 0.35)
	shield_tween.tween_callback(func(): _on_shield_tween_completed(state))
	current_display_state = state

func _on_shield_tween_completed(state: String):
	if state != current_display_state:
		return  # State changed again before tween finished

	if state == "active_fast":
		if shield_tween:
			shield_tween.kill()
		shield_tween = create_tween()
		shield_tween.set_loops()
		shield_tween.tween_property(shield_status_indicator, "modulate:a", 0.0, 0.3)
		shield_tween.tween_property(shield_status_indicator, "modulate:a", 1.5, 0.3)
	elif state == "active_steady":
		shield_status_indicator.modulate.a = 1.5 # Ensure full visibility after initial fade-in

func _set_shield_texture_by_state(state: String):
	match state:
		"active", "active_fast", "active_steady":
			shield_status_indicator.texture = shield_active_texture
		"active_flagged":
			shield_status_indicator.texture = shield_active_flagged_texture
		"inactive":
			shield_status_indicator.texture = shield_inactive_texture
		_:
			shield_status_indicator.texture = shield_inactive_texture


func _ready():
	add_to_group("hud")
	# Set initial alpha to 0.0 so it starts invisible
	shield_status_indicator.modulate.a = 0.0
	# Wait for the defined delay before triggering the initial fade-in
	await get_tree().create_timer(INITIAL_FADE_IN_DELAY).timeout
	# Trigger the initial fade-in
	update_shield_display("inactive")

func reset_display():
	# Kill any running tween
	if shield_tween:
		shield_tween.kill()
		shield_tween = null
	# Force it back to invisible
	shield_status_indicator.modulate.a = 0.0
	# Clear the “last seen” state so update_shield_display will run
	current_display_state = ""
