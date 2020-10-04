
function scr_hasConfig() {
	return file_exists(global.CONFIG_PATH);
}

function scr_loadConfig() {
	ini_open(global.CONFIG_PATH);
	
	global.VOLUME_MUSIC = ini_read_real("volume", "music", 0.2);
	global.VOLUME_SFX = ini_read_real("volume", "sound", 0.2);
	
	ini_close();
}

function scr_saveConfig() {
	ini_open(global.CONFIG_PATH);
	
	ini_write_real("volume", "music", global.VOLUME_MUSIC);
	ini_write_real("volume", "sound", global.VOLUME_SFX);
	
	ini_close();
}
