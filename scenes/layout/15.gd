extends Spatial


var from = 0
var current_room = 15



func _ready():
	$RichTextLabel.text = "ROOM "+str(current_room)
	#$escenario.visible = false
	match from:
		
		14:
			$player.transform = $playerspawn14.transform
			$compa.transform = $compaspawn14.transform
		16:
			$player.transform = $playerspawn16.transform
			$compa.transform = $compaspawn16.transform
		

func _on_Puerta14_body_entered(body):
	if body.name == $player.name:
		get_parent().get_parent().change_room_from_to(current_room,14)


func _on_Puerta16_body_entered(body):
	if body.name == $player.name:
		get_parent().get_parent().change_room_from_to(current_room,16)


