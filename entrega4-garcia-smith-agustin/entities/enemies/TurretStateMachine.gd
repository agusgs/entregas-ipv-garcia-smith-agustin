extends "res://entities/AbstractStateMachine.gd"


func _ready():
	states_map = {
		"idle": $Idle,
		"moving": $Moving,
		"attack": $Attacking,
		"dead": $Dead
	}

func notify_hit():
	current_state.hit()

func idle_timer_timeout():
	current_state.idle_timer_timeout()

func character_on_range(character):
	current_state.character_in_range(character)

func character_out_of_range(character):
	current_state.character_out_of_range(character)
