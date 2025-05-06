# HostJoinHUD.gd
extends Control

# Game port (must match in host and join)
const GAME_PORT = 12345
# Port for broadcasting/listening for host IP
const BROADCAST_PORT = 12346
# Broadcast address (255.255.255.255 for limited broadcast)
const BROADCAST_ADDRESS = "255.255.255.255"

var udp_peer = PacketPeerUDP.new()
var is_hosting = false
var is_listening = false
var host_ip = "" # Store discovered host IP

@onready var host_button = $Panel/HostButton
@onready var join_button = $Panel/JoinButton
@onready var back_button = $Panel/backButton
@onready var status_label = $StatusLabel

func _ready():
	# Connect signals from the MultiplayerManager (the Autoload)
	MultiplayerManager.server_created.connect(_on_server_created)
	MultiplayerManager.connection_succeeded.connect(_on_connection_succeeded)
	MultiplayerManager.connection_failed.connect(_on_connection_failed)

	status_label.text = "Select Host or Join"

func _process(_delta):
	if is_listening: # Renamed from is_listening_udp
		listen_for_host_ip()

func _on_host_button_pressed():
	status_label.text = "Hosting..."
	host_button.disabled = true
	join_button.disabled = true
	back_button.disabled = true # Disable back while attempting

	# Get local IP
	host_ip = MultiplayerManager.get_local_ipv4()
	if host_ip == "":
		status_label.text = "Error: Could not get local IP."
		reset_ui()
		return
	MultiplayerManager.host_game(GAME_PORT)

func _on_join_button_pressed():
	status_label.text = "Listening for hosts..."
	host_button.disabled = true
	join_button.disabled = true
	back_button.disabled = true
	start_listening() # Renamed function

func _on_back_button_pressed():
	stop_networking()
	get_tree().change_scene_to_file("res://GameMode/game_mode.tscn")

# --- Host Logic (UDP Broadcast) ---
func _on_server_created():
	print("Server created successfully (ENet). Broadcasting IP once (UDP)...")
	status_label.text = "Server started. Broadcasting IP..."
	if not setup_broadcast_socket(): # New function to prepare socket
		status_label.text = "Error starting UDP broadcast."
		MultiplayerManager.close_connection()
		reset_ui()
		return
	# Broadcast IMMEDIATELY
	broadcast_host_ip_once()
	# Clean up UDP socket AFTER broadcasting
	stop_networking() # Close UDP peer
	# Change scene
	get_tree().change_scene_to_file("res://GameMode/multiplayer.tscn")

# New function to set up the socket for broadcasting
func setup_broadcast_socket() -> bool:
	# Enable broadcasting on the socket
	# Note: Broadcasting might require specific permissions or firewall rules
	udp_peer.set_broadcast_enabled(true)

	# Set the destination for UDP broadcast
	var error = udp_peer.set_dest_address(BROADCAST_ADDRESS, BROADCAST_PORT)
	if error != OK:
		printerr("Error setting broadcast destination: ", error)
		return false
	return true

func start_broadcasting() -> bool:
	var error = udp_peer.set_dest_address(BROADCAST_ADDRESS, BROADCAST_PORT)
	if error != OK:
		printerr("Error setting broadcast destination: ", error)
		is_hosting = false
		return false
	return true

# Renamed function - broadcasts once
func broadcast_host_ip_once():
	if udp_peer == null or host_ip == "":
		printerr("Cannot broadcast: UDP peer null or host IP empty.")
		return

	var data = host_ip + ":" + str(GAME_PORT)
	var data_bytes = data.to_utf8_buffer()
	print("Broadcasting: ", data) # Debugging

	var result = udp_peer.put_packet(data_bytes)
	if result != OK:
		printerr("Error sending broadcast packet: ", result)
	else:
		print("Broadcast packet sent successfully.")

# --- Join Logic (UDP Listen) ---
# Renamed function
func start_listening():
	# Bind to ANY address on the broadcast port
	var error = udp_peer.bind(BROADCAST_PORT, "0.0.0.0") # Bind to all interfaces
	if error != OK:
		printerr("Error binding UDP listener: ", error)
		status_label.text = "Error starting listener."
		reset_ui()
		return

	is_listening = true # Renamed variable
	print("Started listening for broadcasts on port ", BROADCAST_PORT)

# host_join_hud.gd

func listen_for_host_ip():
	if not is_listening or udp_peer == null:
		return

	while udp_peer.get_available_packet_count() > 0:
		var packet = udp_peer.get_packet()
		var sender_ip = udp_peer.get_packet_ip() # Get sender IP

		# print("Received packet from ", sender_ip) # Debugging
		var data = packet.get_string_from_utf8()
		# print("Received data: ", data) # Debugging

		# Avoid connecting to self if also hosting/broadcasting somehow
		var my_local_ip = MultiplayerManager.get_local_ipv4() # Get own IP if needed
		if my_local_ip != "" and sender_ip == my_local_ip:
			# print("Ignoring own broadcast.")
			continue

		var parts = data.split(":")
		if parts.size() == 2:
			var received_ip = parts[0]
			var received_port_str = parts[1]

			# --- Fix: Simplified Validation ---
			# Basic check: Ensure IP is not empty and port is an integer matching the game port
			if received_ip != "" and received_port_str.is_valid_int():
				var received_port = int(received_port_str)
				if received_port == GAME_PORT:
			# --- End Fix ---
					print("Found potential host at ", received_ip, ":", received_port)
					status_label.text = "Host found! Connecting..."
					is_listening = false # Stop listening

					# Attempt to connect via MultiplayerManager (ENet)
					MultiplayerManager.join_game(received_ip, received_port)

					# Stop processing more packets once connection attempt starts
					return # Exit the loop and function
		# else:
			# print("Received malformed packet.")


# --- Common Network Signal Handlers ---
# REMOVE: _on_peer_connected_discovery() - No longer needed

func _on_connection_succeeded():
	print("Successfully connected to host (ENet). Changing scene.")
	status_label.text = "Connected!"
	is_listening = false # Ensure listening stops
	stop_networking() # Clean up UDP peer before scene change
	get_tree().change_scene_to_file("res://GameMode/multiplayer.tscn")

func _on_connection_failed():
	print("Network connection/host setup failed.")
	status_label.text = "Connection Failed."
	stop_networking() # Clean up UDP
	reset_ui()

# --- Helper Functions ---
func reset_ui():
	host_button.disabled = false
	join_button.disabled = false
	back_button.disabled = false
	status_label.text = "Select Host or Join"

# Renamed function - now only handles UDP peer
func stop_networking():
	# Clean up UDP peer regardless of host/join state
	is_listening = false # Renamed variable
	if udp_peer != null:
		udp_peer.close()
		udp_peer = null # Ensure it's nullified
		print("UDP peer closed.")

func _exit_tree():
	stop_networking()
	# Remove connections if they weren't automatically handled by object freeing
	if MultiplayerManager.server_created.is_connected(_on_server_created):
		MultiplayerManager.server_created.disconnect(_on_server_created)
	if MultiplayerManager.connection_succeeded.is_connected(_on_connection_succeeded):
		MultiplayerManager.connection_succeeded.disconnect(_on_connection_succeeded)
	# ... disconnect other signals ...
