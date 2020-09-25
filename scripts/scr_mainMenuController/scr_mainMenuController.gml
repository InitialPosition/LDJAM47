
/**
	Initializes the main menu controller variables.
**/
function mainMenuController_initializeMainMenu() {
	// metadata
	GAME_NAME = "LDJAM47";
	GAME_VERSION = "v" + string(GM_version);
	GAME_COPYRIGHT = "(c) 2020 InitialPosition";
	
	// menu options
	option[0] = "NEW GAME";
	option[1] = "OPTIONS";
	option[2] = "EXIT";
	
	// internal selection handling
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
		case 0:						// NEW GAME
			fade_initializeFade(rm_fadeTest, $000000, 2000);
			break;
		case 1:						// OPTIONS
			fade_initializeFade(rm_options, $000000, 500);
			break;
		case 2:						// EXIT
			game_end();
			break;
	}
}

/**
	Draws the main menu
**/
function mainMenuController_drawMainMenu() {
	draw_set_halign(fa_left);
	
	// game name
	draw_set_font(fnt_mainMenu_large);
	draw_text_color(room_width / 2, room_height / 2 - 150, GAME_NAME, c_white, c_white, c_white, c_white, 1);
	
	draw_set_font(fnt_mainMenu_medium);
	
	// loop through menu options and draw indicator next to selected one
	var i;
	for (i = 0; i < array_length(option); i++) {
		if (i == selection) {
			draw_text_color(room_width / 2, room_height / 2 + 50 * i, selectIcon + option[i], c_white, c_white, c_white, c_white, 1);
		} else {
			draw_text_color(room_width / 2, room_height / 2 + 50 * i, option[i], c_white, c_white, c_white, c_white, 1);
		}
	}
	
	draw_set_font(fnt_mainMenu_small);
	
	// copyright string
	draw_set_halign(fa_left);
	draw_text(20, room_height - 50, GAME_COPYRIGHT);
	
	// version string
	draw_set_halign(fa_right);
	draw_text(room_width - 20, room_height - 50, GAME_VERSION)
}
