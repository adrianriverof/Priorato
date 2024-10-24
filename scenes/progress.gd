extends Node
class_name ProgressManager


var exhausted_dialogues = {
	"example timeline" : false, 
	"exhausted timeline" : true, 
	"first conversation" : false, 
	"first father conversation" : false,
	"father conversation to start ritual": false,
	"bodega": false,
	"cobertizo 1": false, 
	"cobertizo 2": false,
	"ending" : false,
	"salir_de_iglesia": false
}

var story_events_happened = {
	"talked with padre" : false,
	"obtain daggers" : false,
	"obtain bottle" : false,
	"ritual happened" : false,
	"talked with compa" : false,
}


func is_dialogue_exhausted(event):
	return exhausted_dialogues[event]


func exhaust_dialogue(event):
	exhausted_dialogues[event] = true


func corresponding_padre_conversation():
	if !story_events_happened["talked with padre"]:
		
		story_events_happened["talked with padre"] = true
		return "first father conversation"
	elif we_can_start_ritual():
		story_events_happened["ritual happened"] = true
		return "father conversation to start ritual"
	else:
		exhausted_dialogues["father cant start"] = false
		return "father cant start"

func we_can_start_ritual():
	return story_events_happened["obtain daggers"] and story_events_happened["obtain bottle"]

func tienen_llave():
	return story_events_happened["talked with padre"]
func tienen_dagas():
	return story_events_happened["obtain daggers"]
func tienen_botella():
	return story_events_happened["obtain bottle"]

func ending_momento():
	return story_events_happened["talked with compa"]
	
func ritual_happened():
	return story_events_happened["ritual happened"]

func talked_with_compa():
	story_events_happened["talked with compa"] = true

func consiguen_botella():
	story_events_happened["obtain bottle"] = true

func consiguen_dagas():
	story_events_happened["obtain daggers"] = true

func esta_compa():
	return !(story_events_happened["ritual happened"] and !story_events_happened["talked with compa"])

func is_compa_back():
	return story_events_happened["talked with compa"]


