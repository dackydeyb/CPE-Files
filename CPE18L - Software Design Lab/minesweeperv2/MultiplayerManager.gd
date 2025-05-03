extends Node

var peer: ENetMultiplayerPeer

func host_game(port: int = 12345, max_players: int = 2):
	peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(port, max_players)
	if error != OK:
		print("Failed to start server: ", error)
		return
	multiplayer.multiplayer_peer = peer
	print("Hosting on port ", port)

func join_game(ip: String, port: int = 12345):
	peer = ENetMultiplayerPeer.new()
	var error = peer.create_client(ip, port)
	if error != OK:
		print("Failed to connect to server: ", error)
		return
	multiplayer.multiplayer_peer = peer
	print("Joining ", ip, ":", port)

func _ready():
	multiplayer.peer_connected.connect(_on_peer_connected)
	multiplayer.peer_disconnected.connect(_on_peer_disconnected)
	multiplayer.connected_to_server.connect(_on_connected_to_server)
	multiplayer.connection_failed.connect(_on_connection_failed)

func _on_peer_connected(id):
	print("Player connected: ", id)

func _on_peer_disconnected(id):
	print("Player disconnected: ", id)

func _on_connected_to_server():
	print("Successfully connected to host")

func _on_connection_failed():
	print("Failed to connect to host")
