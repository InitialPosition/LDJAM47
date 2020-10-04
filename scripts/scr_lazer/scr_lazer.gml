
function lazer_enableParticles() {
	part_emitter_stream(system, emit, particles, 2);
}

function lazer_disableParticles() {
	part_emitter_stream(system, emit, particles, 0);
}

function lazer_destroyPartSystem() {
	part_system_destroy(system);
}
