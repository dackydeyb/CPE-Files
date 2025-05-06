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
@onready var status_label = $StatusLabel # Add a Label node to display status

func _ready():
	# Connect signals from the MultiplayerManager (the Autoload)
	MultiplayerManager.server_created.connect(_on_server_created)
	MultiplayerManager.connection_succeeded.connect(_on_connection_succeeded)
	MultiplayerManager.connection_failed.connect(_on_connection_failed)
	# We only need peer_connected for the host to know when someone joined
	MultiplayerManager.peer_connected.connect(_on_peer_connected)

	status_label.text = "Select Host or Join"

func _process(_delta):
	if is_hosting:
		# Host broadcasts its IP periodically
		# You might want to limit how often this happens,
		# but for simplicity, we'll do it in process for now.
		# A timer is better for production.
		broadcast_host_ip()

	if is_listening:
		# Joiner listens for broadcasts
		listen_for_host_ip()

func _on_host_button_pressed():
	status_label.text = "Hosting..."
	host_button.disabled = true
	join_button.disabled = true

	# Get local IP
	host_ip = MultiplayerManager.get_local_ipv4()
	if host_ip == "":
		status_label.text = "Error: Could not get local IP."
		reset_buttons()
		return

	# Start hosting the game server
	MultiplayerManager.host_game(GAME_PORT)

	# The scene change happens in _on_server_created if hosting is successful.

func _on_join_button_pressed():
	status_label.text = "Listening for hosts..."
	host_button.disabled = true
	join_button.disabled = true

	# Start listening for broadcasted IPs
	start_listening()

	# Scene change happens in _on_connection_succeeded if joining is successful.

func _on_back_button_pressed():
	# Clean up network peers before changing scene
	stop_networking()
	get_tree().change_scene_to_file("res://GameMode/game_mode.tscn")

# --- Host Logic ---
func _on_server_created():
	print("Server created successfully in HostJoinHUD.")
	status_label.text = "Server started. Broadcasting IP..."
	is_hosting = true
	start_broadcasting()

	# Change scene immediately after starting the server
	# The multiplayer.tscn scene will then wait for player 2
	get_tree().change_scene_to_file("res://GameMode/multiplayer.tscn")


func start_broadcasting():
	# Set the destination for UDP broadcast
	var error = udp_peer.set_dest_address(BROADCAST_ADDRESS, BROADCAST_PORT)
	if error != OK:
		print("Error setting broadcast destination: ", error)
		# Handle error, maybe stop hosting?
		is_hosting = false
		status_label.text = "Error starting broadcaster."
		reset_buttons()

func broadcast_host_ip():
	if !is_hosting:
		return

	# Prepare the data to send (e.g., "IP:PORT")
	var data = host_ip + ":" + str(GAME_PORT)
	# Convert string to bytes
	var data_bytes = data.to_utf8_buffer()

	# Send the data
	udp_peer.put_packet(data_bytes)
	# print("Broadcasting: ", data) # Optional: uncomment for debugging


# --- Join Logic ---
func start_listening():
	var error = udp_peer.listen(BROADCAST_PORT)
	if error != OK:
		print("Error starting UDP listener: ", error)
		status_label.text = "Error starting listener."
		reset_buttons()
		return

	is_listening = true
	print("Started listening for broadcasts on port ", BROADCAST_PORT)

func listen_for_host_ip():
	if !is_listening:
		return

	while udp_peer.get_available_packet_count() > 0:
		var packet = udp_peer.get_packet()
		var sender_address = udp_peer.get_packet_address()
		var sender_port = udp_peer.get_packet_port()

		print("Received packet from ", sender_address, ":", sender_port)
		var data = packet.get_string_from_utf8()
		print("Received data: ", data)

		# Parse the data (expecting "IP:PORT")
		var parts = data.split(":")
		if parts.size() == 2:
			var received_ip = parts[0]
			var received_port_str = parts[1]
			var received_port = int(received_port_str)

			if received_port == GAME_PORT:
				print("Found potential host at ", received_ip, ":", received_port)
				status_label.text = "Host found! Connecting..."
				is_listening = false # Stop listening once a host is found

				# Attempt to connect to the found host
				MultiplayerManager.join_game(received_ip, received_port)

				# Scene change happens in _on_connection_succeeded
				return # Stop processing packets for this frame after attempting connection
		else:
			print("Received malformed packet.")


# --- Common Network Signal Handlers ---
func _on_peer_connected(id):
	# This is called on the host when a peer connects.
	# If player 2 connects, you can confirm and maybe stop broadcasting.
	print("Peer ", id, " connected. Stopping broadcast.")
	is_hosting = false # Stop broadcasting once a player has joined


func _on_connection_succeeded():
	# This is called on the client when it successfully connects to the host.
	print("Successfully connected to host in HostJoinHUD. Changing scene.")
	status_label.text = "Connected!"
	is_listening = false # Stop listening after successful connection
	stop_networking() # Clean up UDP peers
	get_tree().change_scene_to_file("res://GameMode/multiplayer.tscn")


func _on_connection_failed():
	# This is called on the client if connection fails or on the host if server creation fails.
	print("Network connection failed.")
	status_label.text = "Connection Failed."
	reset_buttons()
	stop_networking() # Clean up any peers


# --- Helper Functions ---
func reset_buttons():
	host_button.disabled = false
	join_button.disabled = false
	status_label.text = "Select Host or Join"

func stop_networking():
	# Clean up UDP peers regardless of host/join state
	is_hosting = false
	is_listening = false
	if udp_peer != null:
		udp_peer.close()
		print("UDP peer closed.")
	# Note: The ENetMultiplayerPeer is managed by the MultiplayerManager Autoload.
	# It will persist across scene changes, which is what we want.
