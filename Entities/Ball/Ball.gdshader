shader_type canvas_item;

const vec2 center = vec2(0.5);
uniform float radius: hint_range(0.0, 1.0) = 0.5;
uniform float outline_size: hint_range(0.0, 1.0) = 0.5;
uniform vec2 speed = vec2(0.0, 0.0);

void fragment() {
	COLOR = texture(TEXTURE, mod(UV + TIME * speed, 1.0));
	COLOR.rgb = COLOR.rgb * step(distance(UV, center), radius - outline_size * 0.1);
	COLOR.a = step(distance(UV, center), radius);
}
