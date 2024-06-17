extends Node

func sprint(txt):
	if multiplayer.is_server():
		print(txt)
