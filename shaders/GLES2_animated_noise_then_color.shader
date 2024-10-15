shader_type canvas_item;

uniform bool flip ;
uniform sampler2D gradient : hint_black; // It can be whatever palette you want
uniform float bit_depth = 4.0;

uniform float grain_amount : hint_range(0.0, 1.0) = 0.05; // Adjust the amount of grain
uniform float grain_size : hint_range(0.1, 10.0) = 1.0; // Adjust the size of the grain
uniform float speed : hint_range(0.0, 10.0) = 1.0;



void fragment(){ 
	
	vec4 color = texture(SCREEN_TEXTURE, SCREEN_UV);
	vec4 new_color = vec4(.0);
	
	float time_noise = TIME * speed;
    float noise = (fract(sin(dot(UV + time_noise, vec2(12.9898, 78.233))) * 43758.5453) - 0.5) * 2.0;
	
	color.rgb += noise * grain_amount * grain_size;
	
	
	//vec4 col = texture(SCREEN_TEXTURE,SCREEN_UV);
	
	float lum = dot(color.rgb,vec3(0.2126,0.7152,0.0722)); // luminance
	lum = floor(lum*bit_depth)/bit_depth;
	color = texture(gradient,vec2(abs(float(flip) - lum),0));
	
	COLOR = color;
}

