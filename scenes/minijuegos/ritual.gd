extends Node2D

onready var player = $player
onready var videoplayer = $video/VideoPlayer


var already_won = false
var current_dialog


func _ready():
	pass
	
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
	end_ritual()


func _tres():
	print("tres")
	$compa/AnimationPlayer.play("kill")
	#$OpenWindow.start() # ya lo inicia la animación

func end_ritual():
	print("se acabó el ritual")



func _on_VideoPlayer_finished():
	#$video.visible = false
	$video.z_index = -3
	Input.warp_mouse_position(player.position)
	start_dialog()
