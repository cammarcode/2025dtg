shader_type canvas_item;
uniform float level;
uniform float amplitude;
uniform float k;


void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {

	if (UV.y < level + amplitude * sin(k*(TIME+UV.x))){
		COLOR.a = 0.0;
	}
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
