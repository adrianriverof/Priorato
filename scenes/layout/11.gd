extends Spatial


var from = 0
var current_room = 11



func _ready():
	$RichTextLabel.text = "ROOM "+str(current_room)
	#$escenario.visible = false
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

