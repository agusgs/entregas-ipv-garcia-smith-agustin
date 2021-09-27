extends StaticBody2D
class_name Turret

onready var fire_position = $FirePosition
onready var fire_timer = $FireTimer
onready var ray = $RayCast2D

export (PackedScene) var projectile_scene

var target:Node2D
var projectile_container

func initialize(container, turret_pos, projectile_container):
	container.add_child(self)
	position = turret_pos
	self.projectile_container = projectile_container
	fire_timer.connect("timeout", self, "fire_at_player")
	fire_timer.start()

func fire_at_player():
	if target != null:
		var direction_to_cast = global_position.direction_to(
			target.global_position
		)
		ray.set_cast_to(direction_to_cast * get_viewport().size.y)
		ray.force_raycast_update()

		if ray.get_collider() == target:
			var proj_instance = projectile_scene.instance()
			proj_instance.initialize(
				projectile_container, 
				fire_position.global_position, 
				fire_position.global_position.direction_to(target.global_position)
			)


func _on_Area2D_body_entered(body):
	if target == null:
		target = body
		fire_timer.start()


func _on_DetectionArea_body_exited(body):
	if body == target:
		target = null
		fire_timer.stop()

func hit_by_projectile():
	queue_free()
