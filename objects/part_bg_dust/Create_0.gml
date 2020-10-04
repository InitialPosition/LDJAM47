/// @description Declare particle

switch (room) {
	case rm_level_06:
	case rm_level_07:
	case rm_level_08:
	case rm_level_09:
	case rm_level_10:
	case rm_end:
		dustParticle = particles_load_dust(0.2, 0.3, 2);
		break;
	default:
		dustParticle = particles_load_dust(1, 2, 0);
		break;
}

system = part_system_create();
emit = part_emitter_create(system);

part_emitter_region(system, emit, 0, room_width + 200, 0, room_height, ps_shape_rectangle, ps_distr_linear);
part_emitter_stream(system, emit, dustParticle, 1);
