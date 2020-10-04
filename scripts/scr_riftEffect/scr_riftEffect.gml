function rift_drawFade() {
	draw_set_alpha(a);
	draw_rectangle_color(0, 0, room_width, room_height, c_white, c_white, c_white, c_white, false);
	draw_set_alpha(1);
}

function rift_updateFade() {
	// first phase
	if (fadingUp) {
		if (a < 1) {
			a += fadeSpeed;
		} else {
			fadingUp = false;
		}
	} else {
		// second phase
		if (a > 0) {
			a -= fadeSpeed;
		} else {
			instance_destroy();
		}
	}
}

function rift_initializeFade() {
	// instanciate new fade object
	
	// set fade values
	a = 0;
	fadeSpeed = 0.4;
	fadingUp = true;
}
