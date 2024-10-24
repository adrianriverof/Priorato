extends Spatial


var from = 0
var current_room = 12

onready var general = get_parent().get_parent()

func _ready():
	$RichTextLabel.text = "ROOM "+str(current_room)
	#$escenario.visible = false
	
	change_after_ritual()
	
	match from:
		
		10:
			$player.transform = $playerspawn11.transform
			$compa.transform = $compaspawn11.transform
		14: # nos saltamos el 13
			$player.transform = $playerspawn14.transform
			$compa.transform = $compaspawn14.transform
	
	general.trigger_ending_si_toca()

func _on_Puerta11_body_entered(body):
	if body.name == $player.name:
		get_parent().get_parent().change_room_from_to(current_room,11)


func _on_Puerta13_body_entered(body):
	if body.name == $player.name:
		get_parent().get_parent().change_room_from_to(current_room,14)#!!! no hay 13



func change_after_ritual():
	if general.ritual_happened():
		$Camera/PostRitual.visible = true
		
	else:
		$Camera/PostRitual.visible = false

