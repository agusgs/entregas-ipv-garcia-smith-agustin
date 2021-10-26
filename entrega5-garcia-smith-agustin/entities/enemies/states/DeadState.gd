extends "res://entities/enemies/states/AbstractEnemyState.gd"


func enter():
	parent.play_animation("DEAD")
	yield(get_tree().create_timer(0.4), "timeout")
	parent.call_deferred("_remove")
	
