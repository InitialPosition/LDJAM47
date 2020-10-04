/// @description 

part = particles_load_rift();

system = part_system_create();
emit = part_emitter_create(system);

part_emitter_region(system, emit, x - 10, x + 10, y - 10, y + 10, ps_shape_ellipse, ps_distr_gaussian);
part_emitter_stream(system, emit, part, 10);

randImg = 0;
alarm[0] = irandom_range(10, 40);