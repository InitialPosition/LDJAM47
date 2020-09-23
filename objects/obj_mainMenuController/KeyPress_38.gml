/// @description Increase Selection

if (canSelect) {
	selection--;
	
	if (selection == -1) {
		selection += array_length(option);
	}
}