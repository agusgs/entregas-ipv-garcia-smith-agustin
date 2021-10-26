extends "res://entities/AbstractState.gd"

func enter():
	parent.play_animation("DEAD")
	GameState.notify_player_dead()
	yield(get_tree().create_timer(0.98), "timeout")
	parent._remove()


func update(delta):
	parent._handle_deacceleration()
	parent._apply_movement()
