/// @description 

if (isShaking) {
	xShake = irandom_range(-shakeStrength, shakeStrength);
	yShake = irandom_range(-shakeStrength, shakeStrength);
	
	shakeStrength += 0.05;
}

if (flicker) {
	currentSprite = choose(spr_player_handsUp, spr_player_handsUp_c);
}

if (y < room_height / 2) {
	vspeed = 0;
}
