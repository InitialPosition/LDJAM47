
/**
	Initializes the main menu controller variables.
**/
function optionController_initializeOptions() {
	// metadata
	TITLE = "OPTIONS";
	
	// menu options
	option[0] = "MUSIC VOLUME: " + string(round(global.VOLUME_MUSIC * 100)) + "%";
	option[1] = "SFX VOLUME: " + string(round(global.VOLUME_SFX * 100)) + "%";
	option[2] = "BACK";
	
	// internal selection handling
	selection = 0;
	selectIcon = "> ";
	canSelect = true;
}

/**
	Draws the main menu
**/
function optionController_drawOptions() {
	draw_set_halign(fa_right);
	
	// game name
	draw_set_font(fnt_mainMenu_large);
	draw_text_color(room_width / 2, 100, TITLE, c_white, c_white, c_white, c_white, 1);
	
	draw_set_font(fnt_mainMenu_medium);
	
	// loop through menu options and draw indicator next to selected one
	var i;
	for (i = 0; i < array_length(option) - 1; i++) {
		if (i == selection) {
			draw_text_color(room_width / 2, room_height / 2 + 50 * i, selectIcon + option[i], c_white, c_white, c_white, c_white, 1);
		} else {
			draw_text_color(room_width / 2, room_height / 2 + 50 * i, option[i], c_white, c_white, c_white, c_white, 1);
		}
	}
	
	// draw back button lower
	if (selection == array_length(option) - 1) {
		draw_text_color(room_width / 2, room_height / 2 + 200, selectIcon + option[array_length(option) - 1], c_white, c_white, c_white, c_white, 1);
	} else {
		draw_text_color(room_width / 2, room_height / 2 + 200, option[array_length(option) - 1], c_white, c_white, c_white, c_white, 1);
	}
}

function optionController_handleIncrease() {
	if (selection == 0) {			// MUSIC
		if (global.VOLUME_MUSIC < 1) {
			// set new gain
			global.VOLUME_MUSIC += 0.05;
			audio_group_set_gain(audiogroup_default, global.VOLUME_MUSIC, 0);
			
			// update display
			option[0] = "MUSIC VOLUME: " + string(round(global.VOLUME_MUSIC * 100)) + "%";
		}
	} else if (selection == 1) {	// SFX
		if (global.VOLUME_SFX < 1) {
			// set new gain
			global.VOLUME_SFX += 0.05;
			audio_group_set_gain(audiogroup_sfx, global.VOLUME_SFX, 0);
			
			// update display
			option[1] = "SFX VOLUME: " + string(round(global.VOLUME_SFX * 100)) + "%";
		}
	}
}

function optionController_handleDecrease() {
	if (selection == 0) {			// MUSIC
		if (global.VOLUME_MUSIC > 0) {
			// set new gain
			global.VOLUME_MUSIC -= 0.05;
			audio_group_set_gain(audiogroup_default, global.VOLUME_MUSIC, 0);
			
			// update display
			option[0] = "MUSIC VOLUME: " + string(round(global.VOLUME_MUSIC * 100)) + "%";
		}
	} else if (selection == 1) {	// SFX
		if (global.VOLUME_SFX > 0) {
			// set new gain
			global.VOLUME_SFX -= 0.05;
			audio_group_set_gain(audiogroup_sfx, global.VOLUME_SFX, 0);
			
			// update display
			option[1] = "SFX VOLUME: " + string(round(global.VOLUME_SFX * 100)) + "%";
		}
	}
}
