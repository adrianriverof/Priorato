extends Sprite3D

export var rotation_speed = 0.004
export var oscillation_speed = 1.0
export var oscillation_magnitude = 0.1
export var scale_magnitude = 0.05
export var randomness_factor = 0.2

var time = 0.0

func _physics_process(delta):
	# Rotar alrededor del eje Z (FORWARD) como lo tenías antes
	rotate(Vector3.FORWARD, rotation_speed)

	# Actualizar el tiempo para usarlo en las oscilaciones y la escala
	time += delta

	# Movimiento oscilante en círculos (usamos sin y cos con un poco de aleatoriedad)
	var oscillation_x = sin(time * oscillation_speed + randf() * randomness_factor) * oscillation_magnitude
	var oscillation_y = cos(time * oscillation_speed + randf() * randomness_factor) * oscillation_magnitude
	var new_position = Vector3(oscillation_x, oscillation_y, translation.z)

	# Actualizar la posición para simular el movimiento en círculos
	set_position(new_position)

	# Oscilación del tamaño (scale) para que se estire y contraiga levemente
	var new_scale = 2.0 + sin(time * oscillation_speed) * scale_magnitude
	set_scale(Vector3(new_scale, new_scale, 1.0))  # Estiramiento en X e Y



func _old_rotate():
	rotate(Vector3.FORWARD, rotation_speed)

func set_position(_position):
	translation = _position
