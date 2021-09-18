extends Sprite

export var projectile_scene:PackedScene

var projectile_container:Node
var player:Sprite
onready var fire_position:Position2D = $FirePosition
onready var timer:Timer = $Timer

# Hay que llamar a esta funcion antes de que se pueda usar la torreta
func initialize(player, projectile_container):
	self.projectile_container = projectile_container
	self.player = player
	self.timer.start()
	
	
func fire():
	var projectile:Projectile = projectile_scene.instance()
	projectile_container.add_child(projectile)
	projectile.set_starting_values(
		fire_position.global_position, 
		(player.global_position - fire_position.global_position).normalized()
	)

	projectile.connect("delete_requested", self, "_on_projectile_delete_request")

func _on_Timer_timeout():
	fire()

func _on_projectile_delete_request(projectile):
	projectile_container.remove_child(projectile)
	projectile.queue_free()
