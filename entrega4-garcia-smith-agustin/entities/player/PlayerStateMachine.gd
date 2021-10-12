extends "res://entities/AbstractStateMachine.gd"


func _ready():
	states_map = {
		"idle": $Idle,
		"walk": $Walk,
		"jump": $Jump,
		"dead": $Dead
	}

func notify_hit(amount):
	PlayerData.current_health += min(amount, PlayerData.max_health)
	if PlayerData.current_health <= 0:
		_change_state("dead")
	print(PlayerData.current_health)
