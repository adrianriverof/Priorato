extends Spatial


var from = 0
var current_room = 4



func _ready():
	$RichTextLabel.text = "ROOM "+str(current_room)
	#$escenario.visible = false
	match from:
		0:
			pass
		3:
			$player.transform = $playerspawn3.transform
			$compa.transform = $compaspawn3.transform
		5:
			$player.transform = $playerspawn5.transform
			$compa.transform = $compaspawn5.transform



func _on_Puerta3_body_entered(body):
	if body.name == $player.name:
		get_parent().get_parent().change_room_from_to(current_room,3)


func _on_Puerta5_body_entered(body):
	print('aaaaaaaaa')
	if body.name == $player.name:
		get_parent().get_parent().change_room_from_to(current_room,5)
