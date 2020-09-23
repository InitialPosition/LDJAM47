
/**
	Initializes the main menu controller variables.
**/
function mainMenuController_initializeMainMenu () {
	GAME_NAME = "LDJAM47";
	GAME_VERSION = "1.0.0";
	GAME_COPYRIGHT = "(c) 2020 InitialPosition";
	
	option[0] = "NEW GAME";
	option[1] = "OPTIONS";
	option[2] = "EXIT";
	
	selection = 0;
	selectIcon = "> ";
	canSelect = true;
}

/**
	Lock cursor and handle selection.
**/
function mainMenuController_enterSelection() {
	canSelect = false;
	
	switch (selection) {
		case 0:
			canSelect = true;		// TEMP!
			break;
		case 1:
			canSelect = true;		// TEMP!
			break;
		case 2:
			game_end();
			break;
	}
}

/**
	Draws the main menu
**/
function mainMenuController_drawMainMenu() {
	draw_set_halign(fa_left);
	
	draw_set_font(fnt_mainMenu_large);
	draw_text_color(room_width / 2, room_height / 2 - 150, GAME_NAME, c_white, c_white, c_white, c_white, 1);
	
	draw_set_font(fnt_mainMenu_medium);
	
	var i;
	for (i = 0; i < array_length(option); i++) {
		if (i == selection) {
			draw_text_color(room_width / 2, room_height / 2 + 50 * i, selectIcon + option[i], c_white, c_white, c_white, c_white, 1);
		} else {
			draw_text_color(room_width / 2, room_height / 2 + 50 * i, option[i], c_white, c_white, c_white, c_white, 1);
		}
	}
	
	draw_set_font(fnt_mainMenu_small);
	
	draw_set_halign(fa_left);
	draw_text(20, room_height - 50, GAME_COPYRIGHT);
	
	draw_set_halign(fa_right);
	draw_text(room_width - 20, room_height - 50, GAME_VERSION)
}
