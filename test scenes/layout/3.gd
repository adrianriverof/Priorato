extends Spatial


var from = 0
var current_room = 3



# Called when the node enters the scene tree for the first time.
func _ready():
	$escenario.visible = false
	match from:
		0:
			pass
		2:
			$player.transform = $playerspawn2.transform
			$compa.transform = $compaspawn2.transform
		4:
			$player.transform = $playerspawn4.transform
			$compa.transform = $compaspawn4.transform

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area_body_entered(body):
	print("algo detectado Puerta 2")
	if body.name == $player.name:
		print("player entra Puerta 2")
		
		#print(get_parent())
		#print(get_parent().get_parent())
		get_parent().get_parent().change_room_from_to(current_room,2)


func _on_Puerta4_body_entered(body):
	if body.name == $player.name: get_parent().get_parent().change_room_from_to(current_room,4)


func _on_Puerta6_body_entered(body):
	if body.name == $player.name: get_parent().get_parent().change_room_from_to(current_room,6)
