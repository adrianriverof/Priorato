shader_type canvas_item;

// Uniforms
uniform float grain_amount : hint_range(0.0, 1.0) = 0.05; // Adjust the amount of grain
uniform float grain_size : hint_range(0.1, 10.0) = 1.0; // Adjust the size of the grain
uniform float speed : hint_range(0.0, 10.0) = 1.0;


void fragment() {
    // Sample the original screen texture
    vec4 original_color = texture(SCREEN_TEXTURE, SCREEN_UV);


	float time_noise = TIME * speed;
    // Generate random noise
    //float noise = (fract(sin(dot(UV, vec2(12.9898, 78.233))) * 43758.5453) - 0.5) * 2.0;
	float noise = (fract(sin(dot(UV + time_noise, vec2(12.9898, 78.233))) * 43758.5453) - 0.5) * 2.0;


    // Add noise to the original color
    original_color.rgb += noise * grain_amount * grain_size;

    // Clamp the final color to make sure it stays in the valid range
    COLOR = clamp(original_color, 0.0, 1.0);
}