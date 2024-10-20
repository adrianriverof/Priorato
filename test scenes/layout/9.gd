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
		10:
			$player.transform = $playerspawn10.transform
			$compa.transform = $compaspawn10.transform
		



func _on_Puerta10_body_entered(body):
	if body.name == $player.name:
		get_parent().get_parent().change_room_from_to(current_room,10)


func _on_Puerta8_body_entered(body):
	if body.name == $player.name:
		get_parent().get_parent().change_room_from_to(current_room,8)

