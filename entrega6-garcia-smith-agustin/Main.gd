extends Node

onready var player = $Environment/Player
onready var backgroung_player = $Background
onready var game_over_player = $GameOver

func _ready():
	randomize()
	GameState.connect("player_dead", self, "_game_over")
	player.initialize(self)

func _unhandled_input(event):
	if event.is_action("restart"):
		_restart_level()

func _restart_level():
	get_tree().reload_current_scene()

func _game_over():
	backgroung_player.stop()
	game_over_player.play()
