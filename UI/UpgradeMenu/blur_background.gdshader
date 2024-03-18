shader_type canvas_item;

uniform sampler2D screen_texture: hint_screen_texture, filter_linear_mipmap;
uniform float lod = 1.5;

void fragment() {
	vec4 color = texture(screen_texture, SCREEN_UV, lod);
	COLOR = vec4(color.rgb, 1.0);
}
