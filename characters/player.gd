extends KinematicBody


# Velocidad del personaje
export var speed = 120.0 * 10

# Donde el personaje tiene que ir
var destination = Vector3()
var altitude = self.translation.y

# Para detectar cuando hay un clic
var moving = false
export var is_dialog_active = false

onready var camera = get_parent().get_node("Camera")
onready var ball = get_parent().get_node("ball")
onready var dialoguescene = preload("res://addons/dialogic/Dialog.tscn")


func _ready():
	
	print("player aparece")
	
	altitude = self.translation.y
	
	var general = get_tree().get_root().get_node("general")
	general.player = self # esto es una virguería horrible porque mi arquitectura es una mierda
	
	$player/AnimationPlayer.play("Iddle")

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		
		
		var ray_origin = camera.project_ray_origin(get_viewport().get_mouse_position())
		var ray_direction = camera.project_ray_normal(get_viewport().get_mouse_position())
		
		
		# Usamos una intersección para determinar donde está el suelo
		var space_state = get_world().direct_space_state
		var collision = space_state.intersect_ray(ray_origin, ray_origin + ray_direction * 1000, [self])
		#print("¿Considera el jugador que hay diálogo?", is_dialog_active)
		if collision and !is_dialog_active:
			print("colisión con: ", collision.get("collider").name)
			if collision.get("collider").name == "floor":
				destination = collision.position
				destination.y = global_transform.origin.y #!!!
				moving = true

			elif  collision.get("collider").name == "compa":
				#print("has tocado a compa") #!!! hay que hacer la hitbox de compa mas grande entonces
				
				talk_to_compa()
				#print(is_dialog_active)
				#print(Dialogic.load())
			elif collision.get("collider").name == "padre":
				talk_to_padre()




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

func talk_to_padre():
	talk_to_compa()
	#general.talk_to_padre()




# Función llamada cuando el diálogo comienza
func _on_dialogic_started(_timeline = null):
	print("dialogo empieza")
	aware_of_dialogue_started()
	

# Función llamada cuando el diálogo termina
func _on_dialogic_ended(_timeline = null):
	print("dialogo acaba")
	aware_of_dialogue_ended()
	

func aware_of_dialogue_started():
	print("----- se avisa de que ha EMPEZADO un diálogo")
	is_dialog_active = true

func aware_of_dialogue_ended():
	print("----- se avisa de que ha terminado un diálogo")
	is_dialog_active = false




