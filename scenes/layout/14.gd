extends Spatial


var from = 0
var current_room = 14

onready var general = get_parent().get_parent()

func _ready():
	$RichTextLabel.text = "ROOM "+str(current_room)
	#$escenario.visible = false
	match from:
		
		12:
			$player.transform = $playerspawn12.transform
			$compa.transform = $compaspawn12.transform
		15:
			$player.transform = $playerspawn15.transform
			$compa.transform = $compaspawn15.transform
	
	general.salir_de_iglesia()

func _on_Puerta11_body_entered(body):
	if body.name == $player.name:
		get_parent().get_parent().change_room_from_to(current_room,12)


func _on_Puerta13_body_entered(body):
	if body.name == $player.name:
		get_parent().get_parent().change_room_from_to(current_room,15)


