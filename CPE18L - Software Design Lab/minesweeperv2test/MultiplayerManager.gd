# MultiplayerManager.gd (Autoload Singleton)
extends Node

signal server_created
signal connection_succeeded
signal connection_failed
signal peer_connected(id)
signal peer_disconnected(id)

const DEFAULT_PORT = 12345 # Same as GAME_PORT in HostJoinHUD

var peer: MultiplayerPeer

func _ready():
	# Connect signals from the MultiplayerAPI
	multiplayer.peer_connected.connect(_on_peer_connected)
	multiplayer.peer_disconnected.connect(_on_peer_disconnected)
	multiplayer.connected_to_server.connect(_on_connection_succeeded)
	multiplayer.connection_failed.connect(_on_connection_failed)
	multiplayer.server_disconnected.connect(_on_server_disconnected)

# Host function
func host_game(port = DEFAULT_PORT):
	peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(port)
	if error != OK:
		print("Error creating server: ", error)
		connection_failed.emit() # Use the same signal for simplicity here
		return

	multiplayer.multiplayer_peer = peer
	print("Server started on port ", port)
	server_created.emit()

# Join function
func join_game(ip_address, port = DEFAULT_PORT):
	peer = ENetMultiplayerPeer.new()
	var error = peer.create_client(ip_address, port)
	if error != OK:
		print("Error creating client: ", error)
		connection_failed.emit()
		return

	multiplayer.multiplayer_peer = peer
	print("Attempting to connect to ", ip_address, ":", port)
	# Connection result handled by signals (_on_connection_succeeded / _on_connection_failed)

# Close connection/server
func close_connection():
	if multiplayer.multiplayer_peer:
		multiplayer.multiplayer_peer.close()
		multiplayer.multiplayer_peer = null
	print("Network connection closed.")


# --- Signal Handlers ---

func _on_peer_connected(id):
	print("Peer connected: ", id)
	peer_connected.emit(id)

func _on_peer_disconnected(id):
	print("Peer disconnected: ", id)
	peer_disconnected.emit(id)
	# Optional: Handle game state changes on disconnect (e.g., pause, show message)
	# Consider ending the game if the opponent disconnects

func _on_connection_succeeded():
	print("Connection succeeded!")
	connection_succeeded.emit()

func _on_connection_failed():
	print("Connection failed!")
	multiplayer.multiplayer_peer = null # Clean up peer
	connection_failed.emit()

func _on_server_disconnected():
	print("Disconnected from server!")
	close_connection()
	connection_failed.emit() # Or a specific "disconnected" signal
	# Optional: Transition back to main menu or show error


# Helper to get local IPv4 address (you already have this, ensure it's reliable)
func get_local_ipv4() -> String:
	for address in IP.get_local_addresses():
		if address.begins_with("192.168.") or address.begins_with("10.") or \
		   (address.begins_with("172.") and range(16, 32).has(int(address.split(".")[1]))):
			if address.count(".") == 3: # Basic IPv4 check
				print("Found local IPv4: ", address)
				return address
	print("Warning: Could not determine reliable local IPv4 address.")
	return "" # Return empty if no suitable address found
