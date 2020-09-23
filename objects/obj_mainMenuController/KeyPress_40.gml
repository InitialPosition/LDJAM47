/// @description Decrease Selection

if (canSelect) {
	selection++;
	
	if (selection == array_length(option)) {
		selection -= array_length(option);
	}
}
