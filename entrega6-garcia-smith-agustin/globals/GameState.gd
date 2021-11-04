extends Node

signal level_won()
signal player_dead()

func notify_level_won():
	emit_signal("level_won")

func notify_player_dead():
	emit_signal("player_dead")
