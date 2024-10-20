extends Spatial


var from = 0
var current_room = 10



func _ready():
	$RichTextLabel.text = "ROOM "+str(current_room)
	#$escenario.visible = false
	match from:
		
		9:
			$player.transform = $playerspawn9.transform
			$compa.transform = $compaspawn9.transform
		11:
			$player.transform = $playerspawn11.transform
			$compa.transform = $compaspawn11.transform
		



func _on_Puerta11_body_entered(body):
	if body.name == $player.name:
		get_parent().get_parent().change_room_from_to(current_room,11)


func _on_Puerta9_body_entered(body):
	if body.name == $player.name:
		get_parent().get_parent().change_room_from_to(current_room,9)


