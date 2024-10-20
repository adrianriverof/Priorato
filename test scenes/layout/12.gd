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
		12:
			$player.transform = $playerspawn13.transform
			$compa.transform = $compaspawn13.transform
		

func _on_Puerta11_body_entered(body):
	if body.name == $player.name:
		get_parent().get_parent().change_room_from_to(current_room,11)


func _on_Puerta13_body_entered(body):
	if body.name == $player.name:
		get_parent().get_parent().change_room_from_to(current_room,13)


