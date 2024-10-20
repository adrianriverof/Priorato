extends Spatial



var room1scene = preload("res://test scenes/layout/1.tscn")
var room2scene = preload("res://test scenes/layout/2.tscn")




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
	get_node("RoomManager").get_child(0).queue_free()
	get_tree().get_root().get_node("general").get_node("RoomManager").add_child(roomtoinstance, true)
	
	
	
