extends Spatial


var progress_manager = ProgressManager.new()


var language = "English"


export var test_room_mode = false
export var starting_test_room = 1
export var skip_dialogue = false

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
	preload("res://scenes/layout/16.tscn"),#  16
	preload("res://scenes/minijuegos/ritual.tscn")  # 17 = ritual
]

var bottleminigamescene = preload("res://scenes/minijuegos/botella.tscn")
var daggersminigamescene = preload("res://scenes/minijuegos/dagas.tscn")
var ritualminigamescene = preload("res://scenes/minijuegos/ritual.tscn")
var handsminigamescene = preload("res://scenes/minijuegos/manos.tscn")

var player

var dialoguescene = preload("res://addons/dialogic/Dialog.tscn")

func _ready():
	print("general aparece")
	
	
	language = Language.language
	
	print(language)
	
	
	if test_room_mode: change_room_from_to(0,starting_test_room)
	else: 
		change_room_from_to(0,start_room)


func change_room_from_to(from, to):
	#print("venimos de la sala " + str(from) + " y vamos a la sala " + str(to))
	
	
	if to < 1 or to > room_scenes.size():
		print("Error: Sala destino fuera de rango")
		return

	var roomtoinstance = room_scenes[to - 1].instance()
	roomtoinstance.from = from
	get_node("RoomManager").get_child(0).queue_free()
	get_tree().get_root().get_node("general").get_node("RoomManager").add_child(roomtoinstance, true)



func toggle_shader():
	$"GLES2 anim noise color".visible = !$"GLES2 anim noise color".visible


func talk_to_padre():
	start_dialogue(progress_manager.corresponding_padre_conversation())
	
func entrar_en_cobertizo():
	if progress_manager.ritual_happened():
		progress_manager.talked_with_compa()
		start_dialogue("cobertizo 2")
	elif progress_manager.tienen_llave():
		progress_manager.consiguen_dagas()
		start_dialogue("cobertizo 1")
	


func salir_de_iglesia():
	if ritual_happened():
		$SoundPostRitual.stop()
	start_dialogue("salir_de_iglesia")

func entrar_en_bodega():
	if progress_manager.tienen_llave():
		progress_manager.consiguen_botella()
		start_dialogue("bodega")
		
		

func trigger_ending_si_toca():
	if progress_manager.ending_momento():
		start_dialogue("ending")




func start_dialogue(event=null):
	if progress_manager.is_dialogue_exhausted(event): 
		return
	else:
		progress_manager.exhaust_dialogue(event)
	if skip_dialogue: return
	# aquí meteré tremendo switch
	var timeline_string : String =_select_timeline_string_for(event)
	#print(timeline_string)
	_add_dialogue_scene(timeline_string)


func _select_timeline_string_for(event, custom_language = language):
	var string = ""
	if custom_language == "English": string += "/English/"
	
	match event:
		"first conversation": 
			string += "1a conversacion"
		"final":
			string += "Final"
		"first father conversation":
			string += "Padre 1"
		"father cant start":
			string += "hablar Padre incompleto"
		"father conversation to start ritual":
			string += "Padre 2"
		"cobertizo 1":
			string += "Cobertizo"
		"bodega":
			string += "Bodega"
		"cobertizo 2":
			string += "Cobertizo 2"
		"ending":
			string += "Final"
		"salir_de_iglesia":
			string += "1a Conv Fuera"
	
	
	if custom_language == "English": string += " ENG"
	
	return string


func _add_dialogue_scene(timeline = ""):
	
	
	dialoguescene = preload("res://addons/dialogic/Dialog.tscn")
	var dialogue = dialoguescene.instance()
	dialogue.timeline = timeline
	dialogue.connect("timeline_start", self, "_on_dialogic_started")
	dialogue.connect("timeline_end", self, "_on_dialogic_ended")
	dialogue.connect("dialogic_signal", self, "dialog_listener")
	
	add_child(dialogue)
	
func _on_dialogic_started(_timeline = null):
	print("SEÑAL RECIBIDA STARTED")
	
	player.aware_of_dialogue_started()

	

func _on_dialogic_ended(_timeline = null):
	
	player.aware_of_dialogue_ended()


func dialog_listener(string):
	match string:
		"start minigame bottle":
			print("empezaríamos minijuego botella")
			start_minigame(string)
		"start minigame daggers":
			print("empezaríamos minijuego dagas")
			start_minigame(string)
		"start minigame ritual":
			print("empezaríamos minijuego ritual")
			start_minigame(string)
		"start minigame hands":
			print("empezaríamos minijuego manos")
			start_minigame(string)
			

func start_minigame(string):
	pause_player()
	match string:
		"start minigame bottle":
			var minigameinstance = bottleminigamescene.instance()
			get_tree().get_root().add_child(minigameinstance)
			
		"start minigame daggers":
			var minigameinstance = daggersminigamescene.instance()
			get_tree().get_root().add_child(minigameinstance)
		"start minigame ritual":
			$FadeToRitual.play("fadeout")
			#change_to_ritual()
			
			#var minigameinstance = ritualminigamescene.instance()
			#get_tree().get_root().add_child(minigameinstance)
		"start minigame hands":
			var minigameinstance = handsminigamescene.instance()
			get_tree().get_root().add_child(minigameinstance)
	

func change_to_ritual():
	change_room_from_to(8,17)


func pause_player():
	player.aware_of_minigame_started()
func resume_game():
	player.aware_of_minigame_ended()

func post_ritual_sound():
	$SoundPostRitual.play()


func tienen_botella():
	return progress_manager.tienen_botella()
	
func abrir_armario_en_5():
	get_node("RoomManager").get_child(0).abrir_armario()

func esta_compa():
	return progress_manager.esta_compa()

func ritual_happened():
	return progress_manager.ritual_happened()

func is_compa_back():
	return progress_manager.is_compa_back()

