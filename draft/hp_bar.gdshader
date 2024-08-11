shader_type canvas_item;

void vertex() {
	COLOR = vec4(255.0,0.0,0.0,1.0);
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
