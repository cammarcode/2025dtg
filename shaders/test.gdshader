shader_type canvas_item;
uniform float level;
varying float amplitude;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	if (UV.y < 0.5){
		COLOR.a = 0.0;
	}
	UV;
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
