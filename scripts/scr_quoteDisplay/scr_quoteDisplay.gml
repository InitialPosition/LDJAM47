
function quoteDisplay_initialize(){
	quote = "The many worlds interpretation implies that all possible outcomes of quantum measurements are physically realized in some world or universe.";
	author = "\"Quantum Mechanics Vol. 12\", Dr. Brent";
	
	targetRoom = rm_intro;
	
	showingQuote = false;
	showingAuthor = false;
	
	quoteAlpha = 0;
	authorAlpha = 0;
	
	alphaSpeed = 0.02;
	
	fading = false;
	
	alarm[0] = room_speed * 2;				// fade in quote
	alarm[1] = room_speed * 5;				// fade in author
	alarm[2] = room_speed * 10;				// fade out and end
}

function quoteDisplay_displayQuote() {
	draw_set_halign(fa_center);
	draw_set_font(fnt_quote_text);
	
	if (showingQuote) {
		draw_text_ext_color(room_width / 2, room_height / 2 - 100, "\"" + quote + "\"", 60, room_width - 300, c_white, c_white, c_white, c_white, quoteAlpha);
	}
	
	draw_set_halign(fa_right);
	if (showingAuthor) {
		draw_text_ext_color(room_width - 100, room_height / 2 + 100, "- " + author, 0, room_width - 300, c_white, c_white, c_white, c_white, authorAlpha);
	}
	
	draw_set_font(fnt_mainMenu_small);
	draw_text_color(room_width - 100, room_height - 100, "SPACE to skip", c_white, c_white, c_white, c_white, 1);
}

function quoteDisplay_fadeValues() {
	if (showingQuote) {
		if (quoteAlpha < 1) {
			quoteAlpha += alphaSpeed;
		}
	}
	if (showingAuthor) {
		if (authorAlpha < 1) {
			authorAlpha += alphaSpeed;
		}
	}
}

function quoteDisplay_skipQuote() {
	if (!fading) {
		with (obj_fade) {
			instance_destroy();
		}
		
		fading = true;
		alarm[2] = -1;
		
		fade_initializeFade(targetRoom, c_black, 2000);
	}
}
