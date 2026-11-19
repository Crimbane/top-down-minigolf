shader_type canvas_item;

const vec2 center = vec2(0.5);
uniform float radius: hint_range(0.0, 0.5) = 0.5;
uniform float outline_size: hint_range(0.0, 1.0) = 0.5;
uniform vec4 outline_color: source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec2 direction = vec2(0.0, 0.0);
uniform vec2 offset = vec2(0.0, 0.0);
uniform float time: hint_range(0.0, 3600.0);

void fragment() {
	COLOR = texture(TEXTURE, mod(UV + (time * direction + offset), 1.0));
	
	float outline_mask = step(distance(UV, center), radius - outline_size * 0.1);
	float shade_mask = smoothstep(.3, .55, distance(UV, center));
	
	COLOR.rgb = mix(outline_color.rgb, COLOR.rgb, outline_mask);
	COLOR.rgb = mix(COLOR.rgb, outline_color.rgb, shade_mask);
	COLOR.a = step(distance(UV, center), radius -0.0014);
}
