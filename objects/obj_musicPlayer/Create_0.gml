/// @description Destroy if we have one

if (instance_number(obj_musicPlayer) > 1) {
	instance_destroy();
}
