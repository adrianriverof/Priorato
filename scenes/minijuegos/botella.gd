extends Node2D

onready var player = $player
onready var videoplayer = $video/VideoPlayer


var already_won = false
var current_dialog


func _ready():
	Input.warp_mouse_position(player.position)
	start_dialog()

func start_dialog():
	var dialog
	if Language.language == "English":
		dialog = Dialogic.start("minijuego botella ENG")
	else:
		dialog = Dialogic.start("minijuego botella")
		
	dialog.connect("dialogic_signal", self, "dialog_listener")
	current_dialog = dialog
	add_child(dialog)

func dialog_listener(string):
	match string:
		"tres":
			_tres()


func _on_lock_body_entered(body):
	print("abierto")
	if !$OpenWindow.is_stopped():
		_win()
	else:
		print("bad")
		reset()

func _win():
	
	already_won = true
	videoplayer.visible = true
	
	get_tree().get_root().get_node("general").resume_game()
	queue_free()
	


func reset():
	if !already_won: 
		
		print("reiniciando minijuego")
		print(current_dialog)
		if is_instance_valid(current_dialog):
			current_dialog.queue_free()
		$compa/AnimationPlayer.play("idle")
		start_dialog()
		
	
		



func _tres():
	print("tres")
	$compa/AnimationPlayer.play("open")
	#$OpenWindow.start() # ya lo inicia la animación




func _on_VideoPlayer_finished():
	videoplayer.play()


func _on_ResetTimer_timeout():
	reset()
