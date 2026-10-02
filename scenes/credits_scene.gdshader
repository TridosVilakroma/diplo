shader_type canvas_item;

// Pseudo-random function
float random(vec2 uv) {
    return fract(sin(dot(uv.xy, vec2(12.9898, 78.233))) * 43758.5453123);
}

void fragment() {
    vec2 uv_random_offset = vec2(0.0+random(UV+TIME),0.0+random(UV+TIME));
	COLOR=texture(TEXTURE, UV+uv_random_offset);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
