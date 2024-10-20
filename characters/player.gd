extends KinematicBody


# Velocidad del personaje
export var speed = 120.0 * 10

# Donde el personaje tiene que ir
var destination = Vector3()
var altitude = self.translation.y

# Para detectar cuando hay un clic
var moving = false
var is_dialog_active = false

onready var camera = get_parent().get_node("Camera")
onready var ball = get_parent().get_node("ball")
onready var dialoguescene = preload("res://addons/dialogic/Dialog.tscn")



func _ready():
	altitude = self.translation.y
	#var camera = get_parent().get_node("Camera")
	$player/AnimationPlayer.play("Iddle")

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		
		print("pulso")
		var ray_origin = camera.project_ray_origin(get_viewport().get_mouse_position())
		var ray_direction = camera.project_ray_normal(get_viewport().get_mouse_position())
		
		
		# Usamos una intersección para determinar donde está el suelo
		var space_state = get_world().direct_space_state
		var collision = space_state.intersect_ray(ray_origin, ray_origin + ray_direction * 1000, [self])
		#print(is_dialog_active)
		if collision and !is_dialog_active:
			print("colisión con: ", collision.get("collider").name)
			if collision.get("collider").name == "floor":
				destination = collision.position
				destination.y = global_transform.origin.y #!!!
				moving = true

			elif  collision.get("collider").name == "compa":
				print("has tocado a compa") #!!! hay que hacer la hitbox de compa mas grande entonces
				
				talk_to_compa()
				#print(is_dialog_active)
				#print(Dialogic.load())




func _physics_process(delta):
	if moving:
		var direction = (destination - global_transform.origin).normalized()
		var distance_to_target = global_transform.origin.distance_to(destination)
		
		if ball: ball.translation = destination
		
		if distance_to_target > 0.5:
			direction.y *= 0
			var motion = direction * speed * delta
			
			self.look_at(Vector3(destination.x, self.translation.y, destination.z), Vector3.UP)
			self.rotation.x= 0
			$player/AnimationPlayer.play("walkin")
			
			motion = move_and_slide(motion)
		else:
			moving = false
			
			$player/AnimationPlayer.play("Iddle")
		self.translation.y = altitude # !!! recenter
	else:
		if !$player/AnimationPlayer.is_playing():
			$player/AnimationPlayer.play("Iddle")

func talk_to_compa():
	var dialogue = dialoguescene.instance()
	dialogue.timeline = "compa hablar"
	dialogue.connect("timeline_start", self, "_on_dialogic_started")
	dialogue.connect("timeline_end", self, "_on_dialogic_ended")
	
	add_child(dialogue)
	
	# Conectamos las señales del diálogo dinámicamente
	
# Función llamada cuando el diálogo comienza
func _on_dialogic_started(timeline = null):
	print("dialogo empieza")
	is_dialog_active = true
	

# Función llamada cuando el diálogo termina
func _on_dialogic_ended(timeline = null):
	print("dialogo acaba")
	is_dialog_active = false
	

