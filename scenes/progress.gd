extends Node
class_name ProgressManager


var exhausted_dialogues = {
	"example timeline" : false, 
	"exhausted timeline" : true, 
	"first conversation" : false
}



func is_dialogue_exhausted(event):
	return exhausted_dialogues[event]


func exhaust_dialogue(event):
	exhausted_dialogues[event] = true
