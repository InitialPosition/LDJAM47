/// @description Particle System

particles = particles_load_lazer(0.2, 0.5);

system = part_system_create();
emit = part_emitter_create(system);

part_emitter_region(system, emit, x, x + 32, y, y + 32, ps_shape_rectangle, ps_distr_linear);

part_emitter_stream(system, emit, particles, 2);
