
shader_type canvas_item;

uniform float random_rate: hint_range(1, 200, 1) = 1.;
uniform float brightness: hint_range(0, 1, 0.01) = .5;
uniform float flash_frequency: hint_range(0, 10, 0.1) = 0;

float rand(vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.7321, 78.1249))) * 43758.8131);
}

void fragment() {
	float color = 0.0;
	if (rand(SCREEN_UV.xy / (random_rate * 20.)) > .996) {

		float r = rand(SCREEN_UV.xy);
		color = r * (brightness * sin(TIME * (r * flash_frequency) + 720.0 * r));
	}
	COLOR.rgb = vec3(color);
}