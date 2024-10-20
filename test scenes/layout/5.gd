extends Spatial


var from = 4
var current_room = 5



func _ready():
	#$escenario.visible = false
	match from:
		
		4:
			$player.transform = $playerspawn4.transform
			$compa.transform = $compaspawn4.transform
		
		

func _on_Puerta4_body_entered(body):
	if body.name == $player.name:
		get_parent().get_parent().change_room_from_to(current_room,4)


