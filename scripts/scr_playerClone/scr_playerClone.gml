
function playerClone_initialize() {
	moving = false;
	currentFrame = 0;
	recordLength = 0;
	
	// animation speeds
	anim_idle = 0.1;
	anim_running = 2;
}

function playerClone_move() {
	if (moving) {
		//destroy at end
		if (currentFrame == recordLength) {
			instance_create_layer(x + 16, y + 16, "Instances", obj_cloneExplosion);
			audio_play_sound(snd_clone_dies, 1, false);
			
			instance_destroy();
		}
		
		x = recording[currentFrame, 0];
		y = recording[currentFrame, 1];
		
		sprite_index = recording[currentFrame, 2];
		
		if (recording[currentFrame, 3]) {
			audio_play_sound(snd_clone_jump, 1, false);
		}
		
		if (sprite_index == spr_player_idle_l_c || sprite_index == spr_player_idle_r_c) {
			image_speed = anim_idle;
		}
		else if (sprite_index == spr_player_run_l_c || sprite_index == spr_player_run_r_c) {
			image_speed = anim_running;
		}
		
		currentFrame++;
	}
}
