extends Area2D

export var acceleration = 20
export var friccion = 0.1
export var max_speed = 400

var velocity:Vector2 = Vector2.ZERO

onready var cannon:Sprite = $Cannon
onready var player_sprite:Sprite = $PlayerSprite

var projectile_container:Node

var screen_size

func _ready():
	screen_size = get_viewport().get_visible_rect().size

# El player necesita que se llame a esta funcion antes de empezar a usarlo
func set_projectile_container(container:Node):
	cannon.projectile_container = container
	projectile_container = container

func _physics_process(delta):	
	# Mover el cañon adonde esta el puntero del mouse
	var mouse_position:Vector2 = get_global_mouse_position()	
	cannon.look_at(mouse_position)
	
	# Disparar el cañon
	if Input.is_action_just_pressed("fire"):
		cannon.fire()

	# Mover el jugador
	var direction:int = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))

	if direction != 0:
		velocity.x = clamp(velocity.x + (direction * acceleration), -max_speed, max_speed)
	elif abs(velocity.x) > 1:
		velocity.x = lerp(velocity.x, 0, friccion)
	else:
		 velocity.x = 0

	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

func get_border_top_position():
	return Vector2(position.x, position.y - player_sprite.texture.get_height()/2)
