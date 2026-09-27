shader_type canvas_item;

uniform sampler2D paper_texture;
uniform sampler2D paper_normal : hint_normal;
uniform float paper_influence : hint_range(0.0, 1.0) = 0.5;

void fragment() {
	vec4 original_color = texture(TEXTURE, UV);

	// Paper colour
	vec3 paper_color = texture(paper_texture, UV).rgb;

	COLOR = vec4(
		mix(original_color.rgb, paper_color, paper_influence),
		original_color.a
	);

	// Paper normal
	vec3 paper_normal_color = texture(paper_normal, UV).rgb;
	paper_normal_color = paper_normal_color * 2.0 - 1.0;

	NORMAL_MAP = mix(
		NORMAL,
		paper_normal_color,
		paper_influence
	);
}