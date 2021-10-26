extends Area2D

func _on_Trophy_body_entered(body):
	print("You win!")
	GameState.notify_level_won()


func _on_HealthGem_body_entered(body):
	body.recover_health()
	get_parent().remove_child(self)
	queue_free()
