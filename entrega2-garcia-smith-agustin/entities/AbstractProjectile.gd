extends Sprite
class_name Projectile

signal delete_requested(projectile)

export var speed:float

var direction:Vector2

func _ready():
	set_physics_process(false)

func _physics_process(delta):
	position += self.direction * speed * delta

func set_starting_values(starting_position:Vector2, direction:Vector2):
	global_position = starting_position
	self.direction = direction
	set_physics_process(true)

func _on_VisibilityNotifier2D_screen_exited():
	emit_signal("delete_requested", self)
