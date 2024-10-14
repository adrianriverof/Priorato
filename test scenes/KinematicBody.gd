
extends KinematicBody

# Velocidad del personaje
export var speed = 500.0

# Donde el personaje tiene que ir
var destination = Vector3()

# Para detectar cuando hay un clic
var moving = false

onready var camera = get_parent().get_node("Camera")

func _ready():
	#var camera = get_parent().get_node("Camera")
	pass

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		var ray_origin = camera.project_ray_origin(get_viewport().get_mouse_position())
		var ray_direction = camera.project_ray_normal(get_viewport().get_mouse_position())
		
		# Usamos una intersección para determinar donde está el suelo
		var space_state = get_world().direct_space_state
		var collision = space_state.intersect_ray(ray_origin, ray_origin + ray_direction * 1000, [self])
		
		if collision:
			destination = collision.position
			moving = true

func _physics_process(delta):
	if moving:
		var direction = (destination - global_transform.origin).normalized()
		var distance_to_target = global_transform.origin.distance_to(destination)

		if distance_to_target > 0.1:
			var motion = direction * speed * delta
			motion = move_and_slide(motion)
		else:
			moving = false
