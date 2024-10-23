extends KinematicBody




func _physics_process(delta):
	$Padre/AnimationPlayer.play("Padre Iddle")


func look(destination):
	print("destination", destination)
	self.look_at(Vector3(destination.x, self.translation.y, destination.z), Vector3.UP)
