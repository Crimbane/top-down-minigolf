shader_type canvas_item;
uniform sampler2D streaks_Texture: repeat_enable;
uniform sampler2D foamBorders_Texture: repeat_enable;

//uniform vec2 foam_speed = vec2(-0.25, 0.0);
uniform vec2 streak_speed = vec2(-0.6, 0.0);

void fragment() {
	vec4 streak_color = texture(streaks_Texture, UV + TIME * streak_speed);
	vec4 border_color = texture(foamBorders_Texture, UV + TIME * (streak_speed * 0.25));
	
	COLOR = mix(streak_color, border_color, border_color.a);
}
