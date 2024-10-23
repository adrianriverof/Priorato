extends Node2D

onready var player = $player
onready var videoplayer = $video/VideoPlayer


var already_won = false
var current_dialog


func _ready():
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
		"end":
			print("recibimos señal end")
			_end()


func _on_lock_body_entered(body):
	print("abierto")
	if !$OpenWindow.is_stopped():
		_win()
	else:
		print("bad")
		reset()

func _win():
	
	already_won = true
	$WinTimer.start()
	
	#get_tree().get_root().get_node("general").resume_game()
	#queue_free()


func _on_WinTimer_timeout():
	$video.visible = true
	dialogue_got_bottle()
	#$EndTimer.start()



func _on_EndTimer_timeout():
	_end()

func _end():
	
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	print("cerramos minijuego")
	get_tree().get_root().get_node("general").resume_game()
	get_tree().get_root().get_node("general").abrir_armario_en_5()
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


func dialogue_got_bottle():
	var bottledialog = Dialogic.start("got the bottle")
	bottledialog.connect("dialogic_signal", self, "dialog_listener")
	add_child(bottledialog)
	

