/// @description Selection up

if (canSelect) {
	selection--;
	
	if (selection < 0) {
		selection += array_length(option);
	}
}
