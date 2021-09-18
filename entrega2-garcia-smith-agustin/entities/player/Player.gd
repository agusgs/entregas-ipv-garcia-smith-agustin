extends Sprite

var speed = 200 #Pixeles

onready var cannon:Sprite = $Cannon

var projectile_container:Node

# El player necesita que se llame a esta funcion antes de empezar a usarlo
func set_projectile_container(container:Node):
	cannon.projectile_container = container
	projectile_container = container

func _physics_process(delta):	
	var direction:int = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))

	var mouse_position:Vector2 = get_global_mouse_position()	
	cannon.look_at(mouse_position)
	
	if Input.is_action_just_pressed("fire"):
		cannon.fire()
		
	position.x += direction * speed * delta

	
