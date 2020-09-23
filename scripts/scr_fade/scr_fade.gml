
function fade_initializeFade(targetRoom, targetCol, spd) {
	fadeObj = instance_create_layer(0, 0, "Instances_Foreground", obj_fade);
	
	fadeObj.active = false;
	fadeObj.a = 0;
	fadeObj.targetRoom = targetRoom;
	fadeObj.targetCol = targetCol;
	fadeObj.spd = spd;
}

/**
	Fade to the given room using the given color as the fade color
	and the given speed as the fading speed in ms.
**/
function fade_fadeToRoom() {
	// destroy if a fade is already happening
	if (instance_number(obj_fade) > 1) {
		instance_destroy();
	}
	
	// calculate internal fading speed.
	// fade speed in change per frame is spd / (ms/s) / fps
	fadeSpeed = spd / 1000 / room_speed;
	
	
}
