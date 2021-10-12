extends KinematicBody2D

onready var fire_position = $FirePosition
onready var fire_timer = $FireTimer
onready var raycast = $FirePosition/RayCast2D
onready var idle_timer = $IdleTimer
onready var detection_area:Area2D = $DetectionArea
onready var state_machine = $StateMachine

export (PackedScene) var projectile_scene
export (Vector2) var wandering_range
export (float) var speed:float = 50
export (float) var maxspeed:float = 100
export (float) var gravity:float = 100

var target
var projectile_container
var pathfinding:PathfindAstar
var path:PoolVector2Array = []
var velocity:Vector2 = Vector2.ZERO
var move_to:Vector2 = position

func _ready():
	state_machine.set_parent(self)
	fire_timer.connect("timeout", self, "fire")
	idle_timer.start()

func initialize(container, turret_pos, projectile_container):
	container.add_child(self)
	global_position = turret_pos
	self.projectile_container = projectile_container

func fire():
	if target != null:
		var proj_instance = projectile_scene.instance()
		if projectile_container == null:
			projectile_container = get_parent()
		proj_instance.initialize(projectile_container, fire_position.global_position, fire_position.global_position.direction_to(target.global_position))


func _handle_fire():
	raycast.set_cast_to(to_local(target.global_position))
	if raycast.is_colliding() && raycast.get_collider() == target:
		if fire_timer.is_stopped():
			fire_timer.start()
	elif !fire_timer.is_stopped():
		fire_timer.stop()

func _stop_moving():
	path = []

func _handle_movement():
	var point:Vector2 = Vector2(
		rand_range(-wandering_range.x, wandering_range.x), 
		rand_range(-wandering_range.y, wandering_range.y)
	)

	path = pathfinding.get_simple_path(
		global_position, 
		global_position + point
	)

func _apply_movement(delta):
	velocity.x = 0.0
	if !path.empty():
		var distance = speed
		var starting_point = position
		for i in range(path.size()):
			var current = path[0]
			var distance_to_next = starting_point.distance_to(current)
			if distance <= distance_to_next:
				velocity = starting_point.linear_interpolate(
					current, 
					distance / distance_to_next
				)
			elif distance < 0.0:
				velocity = current
			else:
				distance -= distance_to_next
			starting_point = current
			path.remove(0)
				
	velocity.y = gravity
	velocity = move_and_slide(velocity, Vector2.UP)

func notify_hit(_amount):
	state_machine.notify_hit()


func _remove():
	hide()
	detection_area.monitorable = false
	detection_area.monitoring = false
	collision_layer = 0
	collision_mask = 0

func _on_DetectionArea_body_entered(body):
	state_machine.character_on_range(body)

func _on_DetectionArea_body_exited(body):
	state_machine.character_out_of_range(body)

func _on_IdleTimer_timeout():
	idle_timer.wait_time = randf() + randi() % 5
	state_machine.idle_timer_timeout()

