extends Node

export (PackedScene) var turret_scene
export (int) var turrets_amount = 3

onready var player:Sprite = $Player
onready var turret_location:PathFollow2D = $TurretPath/TurretSpawnLocation

export var player_turret_min_distance:int = 10

var screen_size

func _ready():
	screen_size = get_viewport().get_visible_rect().size

	player.set_projectile_container(self)
	create_turrets()

func create_turrets():
	randomize()
	for n in self.turrets_amount:
		var turret = turret_scene.instance()
		
		# Con estas dos lineas nos aseguramos que nunca van a quedar encimadas 
		# las torres con el jugador
		var turret_border_button_offset = turret.get_height() / 2
		var limit_altitude = player.get_border_top_position().y - turret_border_button_offset - player_turret_min_distance
		
		turret.position = Vector2(
			randi() % int(screen_size.x), 
			randi() % int(limit_altitude)
		)

		turret.initialize(player, self)
		add_child(turret)
