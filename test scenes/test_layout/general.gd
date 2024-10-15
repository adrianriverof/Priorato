extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var room1scene = preload("res://test scenes/test_layout/1.tscn")
var room2scene = preload("res://test scenes/test_layout/2.tscn")




# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func change_room_from_to(from,to):
	print("venimos de la sala "+ str(from)+ " y vamos a la sala "+str(to))
	
	var roomtoinstance
	
	match to:
		1:
			roomtoinstance = room1scene.instance()
		2:
			roomtoinstance = room2scene.instance()

	roomtoinstance.from = from
	#print(get_children())
	get_child(0).queue_free()
	get_tree().get_root().get_node("general").add_child(roomtoinstance, true)
	
	
	
