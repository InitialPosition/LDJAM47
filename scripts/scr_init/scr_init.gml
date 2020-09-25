
function scr_init() {
	// defaults
	global.CONFIG_PATH = working_directory + "config.ini";
	
	if (scr_hasConfig()) {
		scr_loadConfig();
	} else {
		global.VOLUME_MUSIC = 0.5;
		global.VOLUME_SFX = 0.5;
		
		scr_saveConfig();
	}
	
	audio_group_load(audiogroup_music);
	audio_group_load(audiogroup_sfx);
	
	audio_group_set_gain(audiogroup_music, global.VOLUME_MUSIC, 0);
	audio_group_set_gain(audiogroup_sfx, global.VOLUME_SFX, 0);
	
	fade_initializeFade(rm_mainMenu, $000000, 500);
}
