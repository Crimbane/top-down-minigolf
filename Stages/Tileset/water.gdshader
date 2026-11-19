shader_type canvas_item;
uniform vec2 direction1 = vec2(0.05, 0.01);
uniform vec2 direction2 = vec2(0.03, -0.02);
uniform float layer2Scale: hint_range(0.0, 2.0) = 1.15;

void fragment() {
	vec2 uv1 = UV + TIME * direction1;
	vec4 tex1 = texture(TEXTURE, uv1);
	
	vec2 uv2 = (UV * layer2Scale) + TIME * direction2;
	vec4 tex2 = texture(TEXTURE, uv2);
	
	COLOR = mix(tex1, tex2, 0.35);
	//COLOR = texture(TEXTURE, UV + (TIME * direction1), 1.0);
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
