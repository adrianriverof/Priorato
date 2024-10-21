extends Control

func _ready():
	visible = false

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().paused = !get_tree().paused
		visible = !visible
		



func _on_ContinueButton_pressed():
	get_tree().paused = false
	visible = false


func _on_ExitButton_pressed():
	$ConfirmExit.visible = true
	

func _on_ConfirmExit_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://scenes/main_menu.tscn")
