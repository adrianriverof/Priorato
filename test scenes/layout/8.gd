extends Spatial


var from = 4
var current_room = 8



func _ready():
	$RichTextLabel.text = "ROOM "+str(current_room)
	print($RichTextLabel.text)
	#$escenario.visible = false
	match from:
		
		6:
			$player.transform = $playerspawn6.transform
			$compa.transform = $compaspawn6.transform
		9:
			$player.transform = $playerspawn9.transform
			$compa.transform = $compaspawn9.transform
		



func _on_Puerta9_body_entered(body):
	if body.name == $player.name:
		get_parent().get_parent().change_room_from_to(current_room,9)

func _on_Puerta6_body_entered(body):
	if body.name == $player.name:
		get_parent().get_parent().change_room_from_to(current_room,6)

