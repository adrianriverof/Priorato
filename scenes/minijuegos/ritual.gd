extends Node2D

onready var player = $player
onready var videoplayer = $video/VideoPlayer


var already_won = false
var current_dialog


#func _input(event):
#	if $video/VideoPlayer.is_playing() and Input.is_action_pressed("left_mouse"):
#		$SkipButton.visible= true

func _ready():
	
	$video.visible = true
	$video.z_index = 3
	print($box/Collisiongate.disabled)
	
func start_dialog():
	var dialog
	if Language.language == "English":
		dialog = Dialogic.start("Ritual ENG")
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
			end_ritual()


func _on_lock_body_entered(body):
	print("algo entra en lock")
	if body.name == "player":
		end_ritual()


func _tres():
	print("tres")
	$box/Collisiongate.disabled = true
	#$compa/AnimationPlayer.play("kill")
	#$OpenWindow.start() # ya lo inicia la animación

func end_ritual():
	$compa/AnimationPlayer.play("compa_se_pira")
	print("se acabó el ritual")
	
	$endritualtimer.start()
	



func _on_VideoPlayer_finished():
	#$video.visible = false
	print("video termina")
	$Blackout.play("blackout")
	$video/AudioStreamPlayer.play()
	
	
#	$video.z_index = -3
#	Input.warp_mouse_position(player.position)
#	start_dialog()


func iniciar_minijuego():
	$video.z_index = -3
	Input.warp_mouse_position(player.position)
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	start_dialog()


func _on_SkipButton_pressed():
	$video/VideoPlayer.emit_signal("finished")
	$video/VideoPlayer.stop()


func _on_endritualtimer_timeout():
	
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().get_root().get_node("general").resume_game()
	get_tree().get_root().get_node("general").change_room_from_to(8,10)
	queue_free()






