extends Spatial


var from = 4
var current_room = 6



func _ready():
	
	$RichTextLabel.text = "ROOM "+str(current_room)
	#$escenario.visible = false
	match from:
		
		3:
			$player.transform = $playerspawn3.transform
			$compa.transform = $compaspawn3.transform
		8:
			$player.transform = $playerspawn8.transform
			$compa.transform = $compaspawn8.transform
		



func _on_Puerta8_body_entered(body):
	if body.name == $player.name:
		get_parent().get_parent().change_room_from_to(current_room,8)

func _on_Puerta3_body_entered(body):
	if body.name == $player.name:
		get_parent().get_parent().change_room_from_to(current_room,3)

