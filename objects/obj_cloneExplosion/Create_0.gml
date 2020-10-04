/// @description prepare explosion

// particles
explodePart = particles_load_rift_closing(5, 2, 3);
explodePart2 = particles_load_rift_closing(-3, 5, 7);
system = part_system_create();
emit = part_emitter_create(system);

part_emitter_region(system, emit, x - 2, x + 2, y - 2, y + 2, ps_shape_rectangle, ps_distr_linear);

part_emitter_burst(system, emit, explodePart, 40);
part_emitter_burst(system, emit, explodePart2, 40);

alarm[0] = 60;
