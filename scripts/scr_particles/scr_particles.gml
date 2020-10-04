
function particles_load_dust(speed_min, speed_max, spin) {
	particle = part_type_create();
	
	part_type_alpha3(particle, 0, 0.5, 0);
	part_type_life(particle, 90, 150);
	part_type_size(particle, 0.02, 0.04, 0, 0);
	part_type_shape(particle, pt_shape_square);
	part_type_direction(particle, 170, 190, spin, 0);
	part_type_speed(particle, speed_min, speed_max, 0, 0);
	
	return particle;
}

function particles_load_rift_closing(dir_change, speedMin, speedMax) {
	particle = part_type_create();
	
	part_type_alpha2(particle, 1, 0);
	part_type_blend(particle, true);
	part_type_life(particle, 30, 40);
	part_type_size(particle, 0.08, 0.12, 0, 0);
	part_type_shape(particle, pt_shape_disk);
	part_type_direction(particle, 0, 359, dir_change, 0);
	part_type_speed(particle, speedMin, speedMax, 0, 0);
	
	return particle;
}

function particles_load_lazer(speedMin, speedMax) {
	particle = part_type_create();
	
	part_type_alpha2(particle, 1, 0);
	part_type_blend(particle, true);
	part_type_life(particle, 10, 15);
	part_type_size(particle, 0.03, 0.05, 0, 0);
	part_type_shape(particle, pt_shape_disk);
	part_type_direction(particle, 0, 359, 0, 0);
	part_type_speed(particle, speedMin, speedMax, 0, 0);
	part_type_color_hsv(particle, 0, 30, 10, 255, 230, 255);
	
	return particle;
}

function particles_load_rift() {
	particle = part_type_create();
	
	part_type_alpha3(particle, 0, 1, 0);
	part_type_blend(particle, true);
	part_type_life(particle, 20, 30);
	part_type_size(particle, 0.06, 0.1, 0, 0);
	part_type_shape(particle, pt_shape_disk);
	part_type_direction(particle, 0, 359, 10, 0);
	part_type_speed(particle, 10, 12, -0.2, 0);
	part_type_color_hsv(particle, 0, 255, 0, 30, 230, 255);
	
	return particle;
}