extends Spatial

var from = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area_body_entered(body):
	if body.name == $player.name:
		print("player entra")
		
		print(get_tree().get_root())
		#print(get_parent().get_parent())
		get_tree().get_root().get_node("general").change_room_from_to(1,2)
