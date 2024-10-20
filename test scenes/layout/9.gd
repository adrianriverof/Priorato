extends Spatial


var from = 4
var current_room = 9



func _ready():
	$RichTextLabel.text = "ROOM "+str(current_room)
	#$escenario.visible = false
	match from:
		
		8:
			$player.transform = $playerspawn8.transform
			$compa.transform = $compaspawn8.transform
		101:
			$player.transform = $playerspawn101.transform
			$compa.transform = $compaspawn101.transform
		102:
			$player.transform = $playerspawn102.transform
			$compa.transform = $compaspawn102.transform
		



func _on_Puerta8_body_entered(body):
	if body.name == $player.name:
		get_parent().get_parent().change_room_from_to(current_room,8)



func _on_Puerta10a_body_entered(body):
	if body.name == $player.name:
		get_parent().get_parent().change_room_from_to(91,10)


func _on_Puerta10b_body_entered(body):
	if body.name == $player.name:
		get_parent().get_parent().change_room_from_to(92,10)
