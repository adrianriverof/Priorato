extends Node2D

onready var player = $player
onready var videoplayer = $video/VideoPlayer


var already_won = false
var current_dialog


func _ready():
	$video.visible = true
	$video.z_index = 3
	
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
	end_ritual()


func _tres():
	print("tres")
	$box/Collisiongate.disabled = true
	#$compa/AnimationPlayer.play("kill")
	#$OpenWindow.start() # ya lo inicia la animación

func end_ritual():
	$compa/AnimationPlayer.play("compa_se_pira")
	print("se acabó el ritual")
	get_tree().get_root().get_node("general").resume_game()
	queue_free()



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
	start_dialog()
