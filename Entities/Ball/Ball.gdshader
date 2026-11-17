shader_type canvas_item;

const vec2 center = vec2(0.5);
uniform float radius: hint_range(0.0, 1.0) = 0.5;
uniform float outline_size: hint_range(0.0, 1.0) = 0.5;
uniform vec2 direction = vec2(0.0, 0.0);
uniform vec2 offset = vec2(0.0, 0.0);
uniform float time: hint_range(0.0, 3600.0);

void fragment() {
	COLOR = texture(TEXTURE, mod(UV + (time * direction + offset), 1.0));
	COLOR.rgb = COLOR.rgb * step(distance(UV, center), radius - outline_size * 0.1);
	COLOR.a = step(distance(UV, center), radius);
}
