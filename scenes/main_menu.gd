extends Node2D



func _on_StartButton_pressed():
	get_tree().change_scene("res://scenes/layout/general.tscn")

func _on_CloseButton_pressed():
	get_tree().quit()
	#OS.kill(0)
	
