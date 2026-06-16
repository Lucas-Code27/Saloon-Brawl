shader_type canvas_item;

uniform sampler2D screentex : hint_screen_texture;

void fragment() {
	vec4 dat = texture(screentex,SCREEN_UV);
	vec3 datrgb = dat.rgb;
	datrgb = round(datrgb*6.34960408)/6.34960408;
	COLOR = vec4(datrgb,dat.a);
}