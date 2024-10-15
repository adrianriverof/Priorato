extends Camera



func _on_Area_body_entered(body):
	print(str(body) + " entered camera view")
	if body.name == "player":
		current = true
		print("cambio de cámara")
		body.camera = self
