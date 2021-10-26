extends Tween

onready var player = $Environment/Player

func _ready():
	randomize()
	player.initialize(self)
	GameState.connect(GameState.PLAYER_DEAD, self, "_on_player_dead")
	GameState.connect(GameState.LEVEL_WON, self, "_on_lavel_won")

func _on_player_won():
	pass

func _on_player_dead():
	pass

func _unhandled_input(event):
	if event.is_action("restart"):
		_restart_level()

func _restart_level():
	get_tree().reload_current_scene()
	

