/// @description Back if selected

if (selection == array_length(option) - 1) {
	canSelect = false;
	
	scr_saveConfig();	
	fade_initializeFade(rm_mainMenu, $000000, 500);
}
