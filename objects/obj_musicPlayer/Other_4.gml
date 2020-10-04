/// @description music lookup table

switch (room) {
	case rm_mainMenu:
		if (!audio_is_playing(snd_mus_intro)) {
			audio_play_sound(snd_mus_intro, 1, true);
		}
		break;
	case rm_quote1:
		if (audio_is_playing(snd_mus_intro)) {
			audio_group_set_gain(audiogroup_default, 0, 2000);
			
			alarm[0] = 150;
		}
		break;
	case rm_level_09:
		if (audio_is_playing(snd_mus_level_01)) {
			audio_group_set_gain(audiogroup_default, 0, 2000);
			
			alarm[0] = 150;
		}
		break;
	
	case rm_level_01:
	case rm_level_02:
	case rm_level_03:
	case rm_level_04:
	case rm_level_05:
	case rm_level_06:
	case rm_level_07:
	case rm_level_08:
		if (!audio_is_playing(snd_mus_level_01)) {
			audio_play_sound(snd_mus_level_01, 1, true);
		}
		break;
}
