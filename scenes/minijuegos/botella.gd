extends Node2D

onready var player = $player




func _ready():
	Input.warp_mouse_position(player.position)

func _physics_process(delta):
	if Input.is_action_just_pressed("left_mouse"):
		$compa/AnimationPlayer.play("open")
	


func _on_lock_body_entered(body):
	print("abierto")
	if !$OpenWindow.is_stopped():
		print("win")
	else:
		print("bad")
		reset()


func reset():
	pass
