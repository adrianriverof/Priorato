extends Node2D



var language = "English"


# Create new ConfigFile object.
var config = ConfigFile.new()


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_StartButton_pressed():
	Language.language = language
	get_tree().change_scene("res://scenes/layout/general.tscn")

func _on_CloseButton_pressed():
	get_tree().quit()
	#OS.kill(0)
	

func _on_Button_pressed():
	
	if language == "English":
		language = "Spanish"
	else: 
		language = "English"
	
	$LanguageButton.text = language
	
	

# Store some values.
#config
#config.set_value("Player1", "player_name", "Steve")
#config.set_value("Player1", "best_score", 10)
#config.set_value("Player2", "player_name", "V3geta")
#config.set_value("Player2", "best_score", 9001)
#
## Save it to a file (overwrite if already exists).
#config.save("user://scores.cfg")




