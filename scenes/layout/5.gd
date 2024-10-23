extends Spatial


var from = 4
var current_room = 5

onready var general = get_parent().get_parent()

func _ready():
	
	if general.tienen_botella():
		abrir_armario()
		
	
	$RichTextLabel.text = "ROOM "+str(current_room)
	#$escenario.visible = false
	match from:
		
		4:
			$player.transform = $playerspawn4.transform
			$compa.transform = $compaspawn4.transform
		
	general.entrar_en_bodega()

func _on_Puerta4_body_entered(body):
	if body.name == $player.name:
		get_parent().get_parent().change_room_from_to(current_room,4)

func abrir_armario():
	$Camera/Sprite3D3.visible = true

