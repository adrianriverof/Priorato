extends Node2D

onready var player = $player




func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var target_global_position: Vector2 = get_global_mouse_position() 
	
	
