extends Spatial

export var starting_room = 1


var room_scenes = [
	preload("res://test scenes/layout/1.tscn"),
	preload("res://test scenes/layout/2.tscn"),
	preload("res://test scenes/layout/3.tscn"),
	preload("res://test scenes/layout/4.tscn"),
	preload("res://test scenes/layout/5.tscn"),
	preload("res://test scenes/layout/6.tscn"),
	preload("res://test scenes/layout/default.tscn"),
	preload("res://test scenes/layout/8.tscn"), 
	preload("res://test scenes/layout/9.tscn"),
	preload("res://test scenes/layout/10.tscn"), # 10
	preload("res://test scenes/layout/11.tscn"),
	preload("res://test scenes/layout/12.tscn"),
	preload("res://test scenes/layout/default.tscn"),
	preload("res://test scenes/layout/default.tscn"),
	preload("res://test scenes/layout/default.tscn"),
	preload("res://test scenes/layout/default.tscn"), # 16
]

func _ready():
	change_room_from_to(0,starting_room)


func change_room_from_to(from, to):
	print("venimos de la sala " + str(from) + " y vamos a la sala " + str(to))
	
	
	if to < 1 or to > room_scenes.size():
		print("Error: Sala destino fuera de rango")
		return

	# Instanciar la nueva sala basándote en el índice del array (ajustado por 'to - 1')
	var roomtoinstance = room_scenes[to - 1].instance()
	
	roomtoinstance.from = from

	# Elimina la sala actual
	get_node("RoomManager").get_child(0).queue_free()
	
	# Añadir la nueva sala
	get_tree().get_root().get_node("general").get_node("RoomManager").add_child(roomtoinstance, true)

	
