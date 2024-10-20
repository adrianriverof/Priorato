extends Spatial


var from = 0
var current_room = 12



func _ready():
	$RichTextLabel.text = "ROOM "+str(current_room)
	#$escenario.visible = false
	match from:
		
		10:
			$player.transform = $playerspawn11.transform
			$compa.transform = $compaspawn11.transform
		14: # nos saltamos el 13
			$player.transform = $playerspawn14.transform
			$compa.transform = $compaspawn14.transform
		

func _on_Puerta11_body_entered(body):
	if body.name == $player.name:
		get_parent().get_parent().change_room_from_to(current_room,11)


func _on_Puerta13_body_entered(body):
	if body.name == $player.name:
		get_parent().get_parent().change_room_from_to(current_room,14)#!!! no hay 13


