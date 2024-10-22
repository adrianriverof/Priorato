extends KinematicBody2D

export var speed = 500


func _physics_process(delta):
	var target_global_position: Vector2 = get_global_mouse_position() 
	
	var desired_velocity: = (target_global_position - global_position).normalized()
	
	move_and_slide(desired_velocity * speed)


