extends Sprite3D

export var speed = 0.004


func _physics_process(delta):
	rotate(Vector3.FORWARD, speed)
