extends KinematicBody


var speed = 100.0

var moving = false

onready var player = get_parent().get_node("player")
var destination = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	if player == null:
		player = get_parent().get_node("player")
	
	speed = player.speed
	#print(speed)
	#print(player)
	#print(player.translation)
	


func _physics_process(delta):
	moving = player.moving
	destination = player.translation
	#print(destination)
	
	if moving:
		
		var direction = (destination - global_transform.origin).normalized()
		var distance_to_target = global_transform.origin.distance_to(destination)

		if distance_to_target > 1:
			var motion = direction * speed * delta
			
			self.look_at(Vector3(destination.x, self.translation.y, destination.z), Vector3.UP)
			$compa/AnimationPlayer.play("walkin")
			
			motion = move_and_slide(motion)
#		else:
#			$compa/AnimationPlayer.play("Iddle")
	else:
		$compa/AnimationPlayer.play("Iddle")

