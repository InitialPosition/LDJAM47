
function button_openDoor() {
	sprite_index = spr_button_active;
	
	var i = instance_number(obj_lazer_h_switch);
	var k = instance_number(obj_lazer_v_switch);
	var m = instance_number(obj_doorSpawner);
	
	var count;
	for (count = 0; count < i; count++) {
		var currentLazer = instance_find(obj_lazer_h_switch, count);
		
		if (currentLazer.ID == ID) {
			with (currentLazer) {
				visible = visible ? false : true;
					
				if (visible) {
					lazer_enableParticles();
				} else {
					lazer_disableParticles();
				}
			}
		}
	}
	
	for (count = 0; count < k; count++) {
		var currentLazer = instance_find(obj_lazer_v_switch, count);
		
		if (currentLazer.ID == ID) {
			with (currentLazer) {
				visible = visible ? false : true;
				
				if (visible) {
					lazer_enableParticles();
				} else {
					lazer_disableParticles();
				}
			}
		}
	}
	
	for (count = 0; count < m; count++) {
		var currentDoor = instance_find(obj_doorSpawner, count);
		
		if (currentDoor.ID == ID) {
			with (currentDoor) {
				visible = true;
				
				with (doorChild) {
					instance_destroy();
				}
			}
		}
	}

	audio_play_sound(snd_button_activate, 1, false);
}

function button_closeDoor() {
	sprite_index = spr_button_inactive;
	
	var i = instance_number(obj_lazer_h_switch);
	var k = instance_number(obj_lazer_v_switch);
	var m = instance_number(obj_doorSpawner);
	
	var count;
	for (count = 0; count < i; count++) {
		var currentLazer = instance_find(obj_lazer_h_switch, count);
		
		if (currentLazer.ID == ID) {
			with (currentLazer) {
				visible = visible ? false : true;
				
				if (visible) {
					lazer_enableParticles();
				} else {
					lazer_disableParticles();
				}
			}
		}
	}
	
	for (count = 0; count < k; count++) {
		var currentLazer = instance_find(obj_lazer_v_switch, count);
		
		if (currentLazer.ID == ID) {
			with (currentLazer) {
				visible = visible ? false : true;
			
				if (visible) {
					lazer_enableParticles();
				} else {
					lazer_disableParticles();
				}
			}
		}
	}
	
	for (count = 0; count < m; count++) {
		var currentDoor = instance_find(obj_doorSpawner, count);
		
		if (currentDoor.ID == ID) {
			with (currentDoor) {
				visible = false;
			
				doorChild = instance_create_layer(x, y, "Instances", obj_door);
			}
		}
	}
	
	audio_play_sound(snd_button_deactivate, 10, false);
}
