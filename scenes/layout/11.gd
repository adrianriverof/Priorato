extends Spatial


var from = 0
var current_room = 11

onready var general = get_parent().get_parent()

func _ready():
	$RichTextLabel.text = "ROOM "+str(current_room)
	#$escenario.visible = false
	
	change_after_ritual()
	
	match from:
		
		10:
			$player.transform = $playerspawn10.transform
			$compa.transform = $compaspawn10.transform
		12:
			$player.transform = $playerspawn12.transform
			$compa.transform = $compaspawn12.transform
		

func _on_Puerta10_body_entered(body):
	if body.name == $player.name:
		get_parent().get_parent().change_room_from_to(current_room,10)

func _on_Puerta12_body_entered(body):
	if body.name == $player.name:
		get_parent().get_parent().change_room_from_to(current_room,12)


func change_after_ritual():
	
	if general.ritual_happened():
		audio_set_ritual()
		$Camera/PostRitual.visible = true
		
	else:
		$Camera/PostRitual.visible = false

func audio_set_ritual():
	print($AudioStreamPlayer)
	$AudioStreamPlayer.stop()
	$AudioStreamPlayer.autoplay = false
	$AudioStreamPlayer.playing = false
	$SonidoPostirrtoruto.playing = true
	
	$AudioStreamPlayer.playing = false
