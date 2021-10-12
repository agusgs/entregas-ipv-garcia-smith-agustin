extends "./AbstractState.gd"

func enter():
	parent._stop_moving()

func update(delta):
	parent._apply_movement(delta)
	parent._handle_fire()

func character_in_range(_character):
	pass
	
func character_out_of_range(character):
	if parent.target == character:
		emit_signal("finished", "idle")

func exit():
	parent.target = null
