/// @description Selection Down

if (canSelect) {
	selection++;
	
	if (selection > array_length(option) - 1) {
		selection = 0;
	}
}
