/// @description Close door once player leaves

if (active) {
	if (distance_to_object(instance_nearest(x, y, obj_playerControlled)) > activeRadius) {
		active = false;
		button_closeDoor();
	}
} else {
	if (distance_to_object(instance_nearest(x, y, obj_playerControlled)) < activeRadius) {
		active = true;
		button_openDoor();
	}
}