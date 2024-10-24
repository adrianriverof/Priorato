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
			if !general.ritual_happened():
				$compa.transform = $compaspawn15.transform
	
	general.entrar_en_cobertizo() 
	#change_after_ritual()
	

func _on_Puerta15_body_entered(body):
	if body.name == $player.name:
		get_parent().get_parent().change_room_from_to(current_room,15)



func change_after_ritual():
	print("ritual", general.ritual_happened())
	print("tenemos a compa", is_instance_valid($compa))
	if !general.ritual_happened():
		
		$dummy_compa.queue_free()

