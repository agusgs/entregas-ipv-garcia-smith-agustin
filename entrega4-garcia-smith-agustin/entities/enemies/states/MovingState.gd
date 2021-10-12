extends "./AbstractState.gd"

func enter():
	parent._handle_movement()

func update(delta):
	parent._apply_movement(delta)

func idle_timer_timeout():
	emit_signal("finished", "idle")
