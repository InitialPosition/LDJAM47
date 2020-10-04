
function player_initialize() {
	// player variables
	maxHspeed = 8;					// MAX HORIZONTAL MOVE SPEED
	maxVspeed = 20;					// MAX VERTICAL MOVE SPEED
	jumpForce = 15;					// JUMP FORCE
	jumpPrecisionMod = 0.5;			// JUMP FORCE MODIFIER
	xx = 0;							// X MOVEMENT ON THIS FRAME
	yy = 0;							// Y MOVEMENT ON THIS FRAME
	accel = 1.2;					// ACCELERATION PER FRAME
	frict = 0.7;					// GROUND FRICTION
	onGround = false;				// WHETHER PLAYER IS ON GROUND
	jumping = false;				// WHETHER PLAYER IS CURRENTLY JUMPING
	canMove = true;					// WHETHER PLAYER IS ALLOWED TO MOVE
	moveHsp = 0;					// SPEED FROM MOVING PLATFORMS
	
	// respawn coordinates at death
	savX = x;
	savY = y;
	
	// recording array
	recording[0][0][0] = x;			// MOVEMENT RECORDING ARRAY
	recording[0][0][1] = y;
	recording[0][0][2] = spr_player_idle_r_c;
	recording[0][0][3] = false;
	recordCounter = 0;				// CURRENT FRAME
	isRecording = true;
	
	canRecord = false;				// CAN THE PLAYER RECORD ALREADY
	maxClones = 1;
	
	// increase at specific levels
	switch (room) {
		case rm_level_06:
		case rm_level_07:
		case rm_level_08:
			maxClones = 2;
			break;
	}
	
	// ..if a record object exists, yes
	if (instance_exists(obj_enableRecord)) {
		canRecord = true;
	}

	currentClone = 0;				// CLONES TO SPAWN
	
	player_spawnClones();
	
	// environment variables
	gravity_norm = 0.9;
	
	xStart = x;
	yStart = y;
	
	show_debug_message("XSTART: " + string(xStart) + ", YSTART: " + string(yStart))
	
	// default input 
	leftKey = vk_left;
	rightKey = vk_right;
	jumpKey = vk_space;
	resetKey = ord("R");
	
	forceReset = false;
	
	// animation speeds
	anim_idle = 0.1;
	anim_running = 2;
	
	image_speed = anim_idle;
}

function player_update() {
	// get current input
	var leftPressed = keyboard_check(leftKey);
	var rightPressed = keyboard_check(rightKey);
	var jumpHeld = keyboard_check(jumpKey);
	var jumpPressed = keyboard_check_pressed(jumpKey);
	var resetPressed = keyboard_check_pressed(resetKey);
	
	if (canMove) {
		player_setMovementVectors(leftPressed, rightPressed, jumpPressed, jumpHeld);
		player_applyGravity();
		player_handleMovingPlatform();
		player_handleCollision();
	}
	
	// apply movement vectors
	x += xx + moveHsp;
	y += yy;
	
	// record movement
	if (canRecord) {
		player_recordMovement();
		player_handleReset(resetPressed);
	}
}

function player_setControls(left, right) {
	leftKey = left;
	rightKey = right;
}

function player_setJump(jump) {
	jumpKey = jump;
}

function player_setMovementVectors(leftPressed, rightPressed, jumpPressed, jumpHeld) {
	// convert input to movement vectors
	if (leftPressed && !rightPressed) {
		if (xx > -maxHspeed) {
			xx -= accel;
		} else {
			xx = -maxHspeed;
		}
		
		sprite_index = spr_player_run_l;
		image_speed = anim_running;
	}
	
	if (rightPressed && !leftPressed) {
		if (xx < maxHspeed) {
			xx += accel;
		} else {
			xx = maxHspeed;
		}
		
		sprite_index = spr_player_run_r;
		image_speed = anim_running;
	}
	
	// stop player if no movement should happen
	if (leftPressed && rightPressed || !leftPressed && !rightPressed) {
		xx = lerp(xx, 0, frict);
		
		if (sprite_index == spr_player_run_r) {
			sprite_index = spr_player_idle_r;
		}
		if (sprite_index == spr_player_run_l) {
			sprite_index = spr_player_idle_l;
		}
		
		image_speed = anim_idle;
	}
	
	// jumping
	recording[currentClone][recordCounter][3] = false;
	if (jumpPressed) {
		if (onGround) {
			jumping = true;
			yy = -jumpForce;
			
			audio_play_sound(snd_jump, 1, false);
			recording[currentClone][recordCounter][3] = true;
		}
	}
	// more precise jump handling
	if (jumping) {
		
		if (sprite_index == spr_player_run_r || sprite_index == spr_player_idle_r) {
			sprite_index = spr_player_jump_r;
		}
		if (sprite_index == spr_player_run_l || sprite_index == spr_player_idle_l) {
			sprite_index = spr_player_jump_l;
		}
		image_speed = 0;
	
		if (!jumpHeld) {
			if (yy < 0) {
				yy = lerp(yy, 0, jumpPrecisionMod);
			}
		}
	}
}

function player_handleCollision() {
	if (place_meeting(x + xx, y, obj_wall)) {
		
		if (moveHsp == 0) {
			while (!place_meeting(x + sign(xx), y, obj_wall)) {
				x += sign(xx);	
			}
		} else {
			x -= moveHsp;
		}
		
		if (xx > 0) {
			move_contact_all(0, xx);
		}
		
		if (xx < 0) {
			move_contact_all(180, abs(xx));
		}
		
		xx = 0;
	}
	
	if (place_meeting(x, y + yy, obj_wall)) {
		if (yy > 0) {
			move_contact_all(270, yy);
			
			// we are on ground here
			onGround = true;
			jumping = false;
			
			if (sprite_index == spr_player_run_l || sprite_index == spr_player_jump_l) {
				sprite_index = spr_player_idle_l;
			}
			if (sprite_index == spr_player_run_r || sprite_index == spr_player_jump_r) {
				sprite_index = spr_player_idle_r;
			}
		}
		
		if (yy < 0) {
			move_contact_all(90, abs(yy));
		}
		
		yy = 0;
	}
	
	// walking off a platform will reset onGround here
	if (onGround) {
		if (!place_meeting(x, y + 1, obj_wall) && !place_meeting(x, y + 1, obj_platformHMove)) {
			onGround = false;
		}
	}
}

function player_antiStuck() {
	// anti stuck code
	if (place_meeting(x + xx, y + yy, obj_wall)) {
		var prevX = x;
		var prevY = y;
		if (xx > 0) {
			x -= 5;
		}
		if (xx < 0) {
			x += 5;
		}
		if (yy > 0) {
			y -= 5;
		}
		if (yy < 0) {
			y += 5;
		}
		
		if (x == prevX && y == prevY) {
			show_debug_message("STUCK, attempting to unstuck...");
			
			// massive sweep
			if (!place_meeting(x + 5, y + 5, obj_wall)) {
				x += 5;
				y += 5;
				
				show_debug_message("Free spot at -5, -5, moving");
				exit;
			}
			if (!place_meeting(x + 5, y - 5, obj_wall)) {
				x += 5;
				y -= 5;
				
				show_debug_message("Free spot at +5, -5, moving");
				exit;
			}
			if (!place_meeting(x - 5, y + 5, obj_wall)) {
				x -= 5;
				y += 5;
				
				show_debug_message("Free spot at -5, +5, moving");
				exit;
			}
			if (!place_meeting(x - 5, y - 5, obj_wall)) {
				x -= 5;
				y -= 5;
				
				show_debug_message("Free spot at +5, +5, moving");
				exit;
			}
		}
	}
}

function player_applyGravity() {
	// apply gravity
	if (!onGround) {
		yy += gravity_norm;
	}
	
	// cap at terminal velocity
	if (yy > maxVspeed) {
		yy = maxVspeed;
	}
}

function player_recordMovement() {
	
	if (isRecording) {
		recording[currentClone][recordCounter][0] = x;
		recording[currentClone][recordCounter][1] = y;
		
		// record sprite
		if (sprite_index == spr_player_idle_l) {
			recording[currentClone][recordCounter][2] = spr_player_idle_l_c;
		}
		if (sprite_index == spr_player_idle_r) {
			recording[currentClone][recordCounter][2] = spr_player_idle_r_c;
		}
		if (sprite_index == spr_player_run_l) {
			recording[currentClone][recordCounter][2] = spr_player_run_l_c;
		}
		if (sprite_index == spr_player_run_r) {
			recording[currentClone][recordCounter][2] = spr_player_run_r_c;
		}
		if (sprite_index == spr_player_jump_l) {
			recording[currentClone][recordCounter][2] = spr_player_jump_l_c;
		}
		if (sprite_index == spr_player_jump_r) {
			recording[currentClone][recordCounter][2] = spr_player_jump_r_c;
		}
		
		recordCounter++;
	}
}

function player_handleReset(resetPressed) {
	if (resetPressed || forceReset) {
		
		// stop force resetting
		forceReset = false;
		
		// f l a s h
		instance_create_layer(0, 0, "Instances", obj_riftEffect);
		
		// stop recording
		isRecording = false;
		
		show_debug_message("MOVING TO " + string(xStart) + ", " + string(yStart))
		
		// reset other player vars
		xx = 0;
		yy = 0;
		onGround = false;
		
		// reset player position
		x = xStart;
		y = yStart;
		
		// reset other positions
		with (obj_platformHMove) {
			x = xStart;
			hspeed = spdStart;
		}
		
		with (obj_saw) {
			instance_destroy();
		}
		
		with (obj_sawShooter) {
			alarm[0] = shootSpd;
		}
		
		with (obj_lazer_h_timer) {
			alarm[0] = switchSpeed + initalOffset;
		}
		with (obj_lazer_v_timer) {
			alarm[0] = switchSpeed + initalOffset;
		}
		
		show_debug_message("ACTUAL POS: " + string(x) + ", " + string(y))
		
		// play swoosh
		audio_play_sound(snd_quantum_leap, 1, false);
		
		// increment clone counter
		currentClone++;
		
		recordCounter = 0;
		
		// spawn clones
		player_spawnClones();
		
		// re enable recording
		isRecording = true;
	}
}

function player_spawnClones() {
	
	// remove all clones
	with (obj_playerClone) {
		instance_destroy()
	}
	
	// spawn new clones
	var i;
	for (i = clamp(currentClone - maxClones, 0, currentClone); i < currentClone; i++) {
		var clone = instance_create_layer(xStart, yStart, "Instances", obj_playerClone);
		
		clone.recording = recording[i];
		clone.recordLength = array_length(recording[i]) - 1;
		
		clone.moving = true;
	}
}

function player_kill() {
	if (canRecord) {
		forceReset = true;
	} else {
		var respawn = instance_create_layer(0, 0, "Instances", obj_deathRespawn);
		respawn.xx = savX;
		respawn.yy = savY;
		
		instance_destroy();
	}
}

function player_unstuck() {
	// find the optimal direction to unstuck
	var lDist = 0;
	var rDist = 0;
	
	while (place_meeting(x + lDist, y, obj_door)) {
		lDist--;
	}
	while (place_meeting(x + rDist, y, obj_door)) {
		rDist++;
	}
	
	if (abs(lDist) < abs(rDist)) {
		// we push to the left
		show_debug_message("ldist: " + string(abs(lDist)) + ", rdist: " + string(abs(rDist)) + " (Pushing left)");
		move_outside_all(180, lDist);
	} else {
		show_debug_message("ldist: " + string(abs(lDist)) + ", rdist: " + string(abs(rDist)) + " (Pushing right)");
		move_outside_all(0, rDist)
	}
}

function player_saveGame() {
	savX = other.x;
	savY = other.y;
	
	with (other) {
		instance_destroy();
	}
}

function player_handleMovingPlatform() {
	if (place_meeting(x, y + 1, obj_platformHMove)) {
		var platform = instance_nearest(x, y, obj_platformHMove);
		
		if (y < platform.y) {
			moveHsp = platform.hspeed;
		}
	} else {
		moveHsp = 0;
	}
}
