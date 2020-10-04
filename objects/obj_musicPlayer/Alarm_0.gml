/// @description stop sound and reset music volume

audio_stop_all();
audio_group_set_gain(audiogroup_default, global.VOLUME_MUSIC, 0);
