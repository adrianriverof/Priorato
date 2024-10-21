extends Spatial

# esto era una clase seguramente, vaya


onready var general = get_parent().get_parent()

var from = 0
var current_room = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	print("room 1 aparece")
	print(general.player)
	
	$RichTextLabel.text = "ROOM "+str(current_room)
	match from:
		0:
			pass
		2:
			$player.transform = $playerspawn2.transform
			$compa.transform = $compaspawn2.transform
	
	
	general.start_dialogue("first conversation")



func _on_Area_body_entered(body):
	if body.name == $player.name:
		general.change_room_from_to(1,2)
		

