extends Spatial


var from = 0
var current_room = 10



func _ready():
	$RichTextLabel.text = "ROOM "+str(current_room)
	#$escenario.visible = false
	match from:
		
		9:
			$player.transform = $playerspawn91.transform
			$compa.transform = $compaspawn91.transform
		11:
			$player.transform = $playerspawn11.transform
			$compa.transform = $compaspawn11.transform
		91:
			$player.transform = $playerspawn91.transform
			$compa.transform = $compaspawn91.transform
		92:
			$player.transform = $playerspawn92.transform
			$compa.transform = $compaspawn92.transform



func _on_Puerta11_body_entered(body):
	if body.name == $player.name:
		get_parent().get_parent().change_room_from_to(current_room,11)




func _on_Puerta9a_body_entered(body):
	if body.name == $player.name:
		get_parent().get_parent().change_room_from_to(102,9)



func _on_Puerta9b_body_entered(body):
	if body.name == $player.name:
		get_parent().get_parent().change_room_from_to(101,9)
