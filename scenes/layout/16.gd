extends Spatial


var from = 0
var current_room = 16

onready var general = get_parent().get_parent()


func _ready():
	$RichTextLabel.text = "ROOM "+str(current_room)
	#$escenario.visible = false
	match from:
		
		15:
			$player.transform = $playerspawn15.transform
			$compa.transform = $compaspawn15.transform
	
	general.entrar_en_cobertizo() 
	
	

func _on_Puerta15_body_entered(body):
	if body.name == $player.name:
		get_parent().get_parent().change_room_from_to(current_room,15)


