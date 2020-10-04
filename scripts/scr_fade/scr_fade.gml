
function fade_initializeFade(targetRoom, targetCol, spd) {
	// instanciate new fade object
	fadeObj = instance_create_layer(0, 0, "Instances_Foreground", obj_fade);
	
	// set fade values
	fadeObj.a = 0;
	fadeObj.targetRoom = targetRoom;
	fadeObj.targetCol = targetCol;
	fadeObj.spd = spd;
	fadeObj.fadingUp = true;
	
	// destroy if a fade is already happening, calculate internal values otherwise
	with (fadeObj) {
		if (instance_number(obj_fade) > 1) {
			instance_destroy();
		} else {
			fade_calculateInternalValues();
		}
	}
}

function fade_calculateInternalValues() {
	// calculate internal fading speed.
	// fade speed in change per frame is (ms/s) / spd / fps * 2
	// (final value is doubled because fade down and fade up should
	// take half of specified time each
	fadeSpeed = (1000 / spd / room_speed) * 2;
}

/**
	Fade to the given room using the given color as the fade color
	and the given speed as the fading speed in ms.
**/
function fade_updateFade() {
	// first phase
	if (fadingUp) {
		if (a < 1) {
			a += fadeSpeed;
		} else {
			room_goto(targetRoom);
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

/**
	Draw the actual fade (drawn as a rectangle overlaying the entire room)
**/
function fade_drawFade() {
	draw_set_alpha(a);
	draw_rectangle_color(0, 0, room_width, room_height, targetCol, targetCol, targetCol, targetCol, false);
	draw_set_alpha(1);
}

function fade_triggerRoomChange() {
	// lock player in place
	with (obj_player) {
		xx = 0;
		yy = 0;
		
		canMove = false;
		visible = false;
	}
	
	var targetRoom;
	switch (room) {
		case rm_intro:
			targetRoom = rm_level_01
			break;
		case rm_level_01:
			targetRoom = rm_level_02;
			break;
		case rm_level_02:
			targetRoom = rm_level_03;
			break;
		case rm_level_03:
			targetRoom = rm_quote2;
			break;
		case rm_level_04:
			targetRoom = rm_level_05;
			break;
		case rm_level_05:
			targetRoom = rm_quote3;
			break;
		case rm_level_06:
			targetRoom = rm_level_07;
			break;
		case rm_level_07:
			targetRoom = rm_level_08;
			break;
		case rm_level_08:
			targetRoom = rm_level_09;
			break;
		case rm_level_09:
			targetRoom = rm_quote4;
			break;
		default:
			targetRoom = rm_error;
			break;
	}
	
	fade_initializeFade(targetRoom, c_black, 1000);
}
