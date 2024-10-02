dir_x = key_right() - key_left();

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

if (key_up()) {
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

if (y > 620) kill_self();

if (just_landed && on_floor()) {
	audio_play_sound(Dirt_Fall, 10, false);
	just_landed = false;
}

move_and_collide(move_x, move_y, tilemap);

if (mouse_check_button_pressed(mb_left)) {
	// Obter a posição do mouse e converter para a grade de tiles
	var tile_x = mouse_x div 16;
	var tile_y = mouse_y div 16;

	// Colocar o tile de índice 1 na posição correspondente
	tilemap_set(tilemap, 5, tile_x, tile_y);
}

if (mouse_check_button_pressed(mb_right)) {
	// Obter a posição do mouse e converter para a grade de tiles
	var tile_x = mouse_x div 16;
	var tile_y = mouse_y div 16;

	// Colocar o tile de índice 1 na posição correspondente
	tilemap_set(tilemap, 0, tile_x, tile_y);
}