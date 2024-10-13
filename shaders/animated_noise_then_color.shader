shader_type canvas_item;

// Uniforms
uniform float grain_amount : hint_range(0.0, 1.0) = 0.05; // Adjust the amount of grain
uniform float grain_size : hint_range(0.1, 10.0) = 1.0; // Adjust the size of the grain
uniform float speed : hint_range(0.0, 10.0) = 1.0;

uniform sampler2D palette : hint_black; // Insert a palette from lospec for instance
uniform int palette_size = 16;


void fragment() {
	vec4 color = texture(SCREEN_TEXTURE, SCREEN_UV);
	vec4 new_color = vec4(.0);
	
	float time_noise = TIME * speed;
    float noise = (fract(sin(dot(UV + time_noise, vec2(12.9898, 78.233))) * 43758.5453) - 0.5) * 2.0;
	
	color.rgb += noise * grain_amount * grain_size;
	
	
	for (int i = 0; i < palette_size; i++) {
		vec4 palette_color = texture(palette, vec2(1.0 / float(palette_size) * float(i), .0));
		if (distance(palette_color, color) < distance(new_color, color)) {
			new_color = palette_color;
		}
	}
	
	
	
	COLOR = new_color;
}