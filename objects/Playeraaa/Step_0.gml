dir_x = key_right() - key_left();
dir_y = key_down() - key_up();

if (is_flying) {
	image_angle = 0;
	if (move_and_collide(move_x, move_y, tilemap) != undefined) {
		move_y = lerp(move_y, dir_y * move_speed, dragging);
		move_x = lerp(move_x, dir_x * move_speed, dragging);
	
		look_at(move_x, move_y);
		sprite_index = FarmerNadando;
	}
}
else if (is_on_water) {
	image_angle = 0;
	if (move_and_collide(move_x, move_y, tilemap) != undefined) {
		move_y = lerp(move_y, dir_y * move_speed, dragging);
		move_x = lerp(move_x, dir_x * move_speed, dragging);
	}
}
else {
	
	image_angle = 0;

	if (on_floor()) {
		if (dir_x != 0) {
			sprite_index = FarmerRun;
		}

		else {
			sprite_index = FarmerIdle;
		}
	}
	else {
		if (move_y > 0) {
			sprite_index = FarmerFall;
		}
		else {
			sprite_index = FarmerJump;
		}
	}

	move_x = lerp(move_x, dir_x * move_speed, dragging);

	if (on_floor()) {
		dragging = 1.0;
		double_jump = false;
	}
	else {
		dragging = 0.1;
		if (move_y < 10.0) {
			move_y += gravity_speed * delta_time / 1000000;
		}
		on_floor_hm = false;
	}

	if (key_up_pressed()) {
		jump();
	}

	if (on_floor() && move_y > 0.0) {
		move_y = 0.0;
	}

	if (on_ceiling() && move_y < 0.0) {
		move_y = 0.0;
	}

	if (dir_x < 0) {
		image_xscale = -1;
	}
	else if (dir_x > 0) {
		image_xscale = 1;
	}

	if (just_landed && on_floor()) {
		audio_sound_pitch(Dirt_Fall, random_range(0.5, 1.5));
		audio_play_sound(Dirt_Fall, 10, false);
		just_landed = false;
	}
	
	move_and_collide(move_x, move_y, tilemap);
}

if (y > 5000) kill_self();

if (elapsed_time >= rand_time) {
	play_music();
	elapsed_time = 0;
	rand_time = random_range(100, 200);
}

elapsed_time += delta_time / 1000000;