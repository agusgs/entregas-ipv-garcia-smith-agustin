extends "./AbstractState.gd"

func enter():
	parent._stop_moving()
	
func update(delta):
	parent._apply_movement(delta)

func idle_timer_timeout():
	emit_signal("finished", "moving")
