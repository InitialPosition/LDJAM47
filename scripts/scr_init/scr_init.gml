
function scr_init() {
	// defaults
	global.CONFIG_PATH = working_directory + "config.ini";
	
	if (scr_hasConfig()) {
		scr_loadConfig();
	} else {
		global.VOLUME_MUSIC = 0.2;
		global.VOLUME_SFX = 0.2;
		
		scr_saveConfig();
	}
	
	audio_group_load(audiogroup_default);
	audio_group_load(audiogroup_sfx);
	
	audio_group_set_gain(audiogroup_default, global.VOLUME_MUSIC, 0);
	audio_group_set_gain(audiogroup_sfx, global.VOLUME_SFX, 0);
	
	fade_initializeFade(rm_mainMenu, $000000, 500);
}
