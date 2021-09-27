extends Container

export (PackedScene) var turret_scene

func _ready():
	call_deferred('initialize')

func initialize():
	for i in 6:
		var turret_instance = turret_scene.instance()
		
		var turret_pos:Vector2 = Vector2(
			rand_range(0, rect_size.x), 
			rand_range(0, rect_size.y)
		)
		
		turret_instance.initialize(self, turret_pos, self)
