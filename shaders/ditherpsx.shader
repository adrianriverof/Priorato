shader_type canvas_item;

uniform sampler2D dither_tex : hint_black;
uniform float col_depth = 15.0; // Controla la profundidad del color
uniform bool dither_banding = true;

void fragment() {
    // Toma el color base de la textura de pantalla
    vec4 base_color = texture(SCREEN_TEXTURE, SCREEN_UV);
    
    // Obtén el tamaño real de la pantalla
    vec2 buf_size = vec2(256,150);

    // Ajusta el tamaño de la textura de dithering, suponiendo una matriz de 4x4
    vec2 dith_size = vec2(32.0, 32.0); 
    
    // Mapea las coordenadas de la pantalla a la textura de dithering
    vec3 dith = texture(dither_tex, fract(SCREEN_UV * buf_size / dith_size)).rgb - 0.5;
    
    // Aplica el dithering al color base, controlado por la opción 'dither_banding'
    vec3 dithered_color = base_color.rgb * col_depth + dith * (dither_banding ? 1.0 : 0.0);
    
    // Redondea el color a la profundidad de color deseada y divide para normalizar
    COLOR.rgb = round(dithered_color) / col_depth;
    
    // Mantiene el canal alpha del color original
    COLOR.a = base_color.a;
}
