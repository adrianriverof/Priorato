extends Node2D

onready var player = $player
onready var videoplayer = $video/VideoPlayer


var already_won = false
var current_dialog


func _ready():
	$credits.modulate = "00ffffff"
	Input.warp_mouse_position(player.position)
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
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
	print("recibimos señal de dialogic: ", string)
	match string:
		"tres":
			_tres()
		


func _on_lock_body_entered(body):
	print("abierto")
	if !$OpenWindow.is_stopped() and body.name == "player":
		_win()
	

func _win():
	
	already_won = true
	player.speed = 0
	$Blackout.play("end")
	


func _on_WinTimer_timeout():
	print("end_game")
	#$EndTimer.start()



func _on_EndTimer_timeout():
	pass

func _end():
	get_tree().change_scene("res://scenes/main_menu.tscn")

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



