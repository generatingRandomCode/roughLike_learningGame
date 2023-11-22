shader_type spatial;
render_mode blend_mix,depth_draw_always,cull_back,diffuse_burley,specular_schlick_ggx;

uniform vec2 direction_and_speed = vec2(0.25, 0.00);
uniform vec2 scale = vec2(1.0);
uniform bool flip = false;
uniform sampler2D albedo: source_color;
uniform float emission_amount: hint_range(0.0, 16.0) = 5.0f; 



void fragment() {
	vec2 uv = UV * scale - direction_and_speed * TIME;
	if(flip) {uv = 1.0 - uv; }
	ALBEDO = vec3(0.2,0.2,1.0);
	ALPHA = texture(albedo, uv).r * 0.1;
	EMISSION = vec3(0.0,0.1,1.0).rgb * emission_amount;
	
	
	// Place fragment code here.
}
