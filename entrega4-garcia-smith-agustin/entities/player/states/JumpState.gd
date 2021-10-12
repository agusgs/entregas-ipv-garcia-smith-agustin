extends "res://entities/AbstractState.gd"

func enter():
	parent._handle_jump()

func update(delta:float):
	parent._handle_cannon_actions()
	parent._handle_move_input()
	
	if !parent.is_willing_to_move():
		parent._handle_deacceleration()

	parent._apply_movement()
	
	if parent.is_on_floor():
		if parent.is_willing_to_move():
			emit_signal("finished", "walk")
		else:
			emit_signal("finished", "idle")
