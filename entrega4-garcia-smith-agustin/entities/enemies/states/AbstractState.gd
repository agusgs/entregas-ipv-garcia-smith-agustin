extends "res://entities/AbstractState.gd"

func hit():
	emit_signal("finished", "dead")

func character_in_range(character):
	parent.target = character
	emit_signal("finished", "attack")
	
func character_out_of_range(_character):
	pass

func idle_timer_timeout():
	pass
