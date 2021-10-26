extends Node

const LEVEL_WON = "level_won"
const PLAYER_DEAD = "player_dead"

signal level_won
signal player_dead

func notify_level_won():
	emit_signal(LEVEL_WON)

func notify_player_dead():
	emit_signal(PLAYER_DEAD)
