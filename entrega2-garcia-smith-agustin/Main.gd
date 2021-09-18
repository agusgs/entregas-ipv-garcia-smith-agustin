extends Node

func _ready():
	var player = $Player
	player.set_projectile_container(self)
	$Turret.initialize(player, self)
