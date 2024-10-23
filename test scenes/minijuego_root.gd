extends Spatial


var bottleminigamescene = preload("res://scenes/minijuegos/botella.tscn")




func _ready():
	start_minigame("start minigame bottle")



func start_minigame(string):
	#get_tree().paused = true
	match string:
		"start minigame bottle":
			print("iniciamos")
			var minigameinstance = bottleminigamescene.instance()
			get_tree().get_root().add_child(minigameinstance)
		"start minigame daggers":
			
			add_child(bottleminigamescene)
		"start minigame ritual":
			
			add_child(bottleminigamescene)
		"start minigame hands":
			
			add_child(bottleminigamescene)
