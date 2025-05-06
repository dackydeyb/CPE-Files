# MultiplayerManager.gd
extends Node

var peer: ENetMultiplayerPeer

# Signals to inform other nodes
signal server_created
signal connection_succeeded
signal connection_failed
signal peer_connected(id) # Emitted when a peer connects to *us* (host) or *we* connect to a peer (client)
signal peer_disconnected(id) # Emitted when a peer disconnects

func host_game(port: int = 12345, max_players: int = 2):
	peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(port, max_players)
	if error != OK:
		print("Failed to start server: ", error)
		connection_failed.emit() # Emit failure signal
		return
	multiplayer.multiplayer_peer = peer
	print("Hosting on port ", port)
	server_created.emit() # Emit success signal

func join_game(ip: String, port: int = 12345):
	peer = ENetMultiplayerPeer.new()
	var error = peer.create_client(ip, port)
	if error != OK:
		print("Failed to connect to server: ", error)
		connection_failed.emit() # Emit failure signal
		return
	multiplayer.multiplayer_peer = peer
	print("Joining ", ip, ":", port)

func _ready():
	# Use the built-in signals from the MultiplayerAPI
	multiplayer.peer_connected.connect(_on_peer_connected)
	multiplayer.peer_disconnected.connect(_on_peer_disconnected)
	multiplayer.connected_to_server.connect(_on_connected_to_server)
	multiplayer.connection_failed.connect(_on_connection_failed)

# --- Built-in MultiplayerAPI signal handlers ---
func _on_peer_connected(id):
	print("Player connected (peer_connected): ", id)
	peer_connected.emit(id) # Re-emit with our signal

func _on_peer_disconnected(id):
	print("Player disconnected (peer_disconnected): ", id)
	peer_disconnected.emit(id) # Re-emit with our signal

func _on_connected_to_server():
	print("Successfully connected to host (connected_to_server)")
	# This signal is emitted on the client when it connects to the server.
	connection_succeeded.emit()

func _on_connection_failed():
	print("Failed to connect to host (connection_failed)")
	# This signal is emitted on the client when connection fails.
	connection_failed.emit()

# Function to get the local non-loopback IPv4 address
func get_local_ipv4():
	var addresses = IP.get_local_addresses()
	for address in addresses:
		# Check for non-loopback and IPv4 addresses
		if address != "127.0.0.1" and address.contains(".") and not address.contains(":"):
			return address
	return "" # Return empty string if no suitable address found
