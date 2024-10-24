extends Sprite

export var rotation_speed = 0.002


func _physics_process(delta):
	
	rotate(rotation_speed)
