/// @description Switch state

alarm[0] = switchSpeed;
visible = visible ? false : true;

if (visible) {
	lazer_enableParticles();
} else {
	lazer_disableParticles();
}