extends Spatial


var from = 0
var current_room = 2


# Called when the node enters the scene tree for the first time.
func _ready():
	$escenario.visible = false
	match from:
		0:
			pass
		1:
			$player.transform = $playerspawn1.transform
			$compa.transform = $compaspawn1.transform
		3: 
			$player.transform = $playerspawn3.transform
			$compa.transform = $compaspawn3.transform
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area_body_entered(body):
	if body.name == $player.name:
		print("player entra")
		
		#print(get_parent())
		#print(get_parent().get_parent())
		get_parent().get_parent().change_room_from_to(2,1)


func _on_Puerta3_body_entered(body):
	if body.name == $player.name:
		print("player entra")
		
		#print(get_parent())
		#print(get_parent().get_parent())
		get_parent().get_parent().change_room_from_to(current_room,3)

