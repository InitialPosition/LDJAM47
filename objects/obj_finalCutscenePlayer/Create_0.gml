/// @description Timeline Setup

hspeed = -2;

currentSprite = spr_player_run_l;

xShake = 0;
yShake = 0;

shakeStrength = 1;

isShaking = false;
flicker = false;
spriteFlickerSpeed = 7;

alarm[0] = 320;
alarm[5] = room_speed * 13;

audio_play_sound(snd_final, 1, false);