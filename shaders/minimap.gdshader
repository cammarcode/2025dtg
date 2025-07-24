shader_type canvas_item;
uniform vec2 position;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment(){
	if(COLOR.a == 0.0){
		COLOR = vec4(0.0,0.3,0.0,1.0);
		if (((fract((UV.y+position.y)/0.125) <= 0.1)||(fract((UV.x+position.x)/0.125) <= 0.1))){
		COLOR = COLOR + vec4(0.1,0.1,0.1,1.0);
		}
	}
	else{
		COLOR = vec4(0.2,0.5,0.2,1.0);
		
	}
	if (pow(UV.x-0.5,2) + pow(UV.y-0.5,2) >= 0.2){
		COLOR.a=0.0;
	}
	

}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
