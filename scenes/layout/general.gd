extends Spatial


var language = "English"

export var test_room_mode = false
export var starting_test_room = 1

var start_room = 1


var room_scenes = [
	preload("res://scenes/layout/1.tscn"),
	preload("res://scenes/layout/2.tscn"),
	preload("res://scenes/layout/3.tscn"),
	preload("res://scenes/layout/4.tscn"),
	preload("res://scenes/layout/5.tscn"),
	preload("res://scenes/layout/6.tscn"),
	preload("res://scenes/layout/default.tscn"),
	preload("res://scenes/layout/8.tscn"), 
	preload("res://scenes/layout/9.tscn"),
	preload("res://scenes/layout/10.tscn"), # 10
	preload("res://scenes/layout/11.tscn"),
	preload("res://scenes/layout/12.tscn"),
	preload("res://scenes/layout/default.tscn"),
	preload("res://scenes/layout/14.tscn"),
	preload("res://scenes/layout/15.tscn"),
	preload("res://scenes/layout/16.tscn")#  16
]


onready var dialoguescene = preload("res://addons/dialogic/Dialog.tscn")


func _ready():
	print("aa")
	print(dialoguescene)
	if test_room_mode: change_room_from_to(0,starting_test_room)
	else: 
		change_room_from_to(0,start_room)


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

func toggle_shader():
	$"GLES2 anim noise color".visible = !$"GLES2 anim noise color".visible

func start_dialogue(event=null):
	# aquí meteré tremendo switch
	var timeline_string : String =_select_timeline_string_for(event, language)
	print(timeline_string)
	_add_dialogue_scene(timeline_string)


func _select_timeline_string_for(event, language):
	var string = ""
	match language:
		"English":
			string += "/English/"
	match event:
		"first conversation": 
			string += "1 conversacion"
		"final":
			string += "Final"
	match language:
		"English":
			string += " ENG"
	
	return string


func _add_dialogue_scene(timeline = ""):
	
	dialoguescene = preload("res://addons/dialogic/Dialog.tscn")
	var dialogue = dialoguescene.instance()
	dialogue.timeline = timeline
	dialogue.connect("timeline_start", self, "_on_dialogic_started")
	dialogue.connect("timeline_end", self, "_on_dialogic_ended")
	
	add_child(dialogue)
	






