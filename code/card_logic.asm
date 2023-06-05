
_jump_set_play_again:
	ld	a,(DATA.play_again)
	inc	a
.jspa:
	ld	(DATA.play_again),a
	ret
; _jump_reset_play_again:
; 	xor	a
; 	jr	_jump_set_play_again.jspa


;	С	-	value.	отрицательное значение.
;	Урон по стене ходящего хода игрока. Оставшийся урон переходит башне ходящего игрока.
active_wall_damage:
	ld	b,RES_OFFSET.WALL
	call	PLAYER.active_res_addr
	jr	non_active_wall_damage.navd
;	С	-	value.	отрицательное значение.
;	Урон по стене ожидающего хода игрока. Оставшийся урон переходит башне ожидающего игрока.
non_active_wall_damage:
	ld	b,RES_OFFSET.WALL
	call	PLAYER.non_active_res_addr
.navd:
	ld	e,(hl)
	inc	HL
	ld	d,(hl)
	ex	de,hl
	ld	b,#FF
	add	hl,bc
	jr	c,.no_carry
	ld	c,l
	ld	b,h
	ld	hl,0
.no_carry:
	ex	de,hl
	ld	(hl),d
	dec	hl
	ld	(hl),e
	ret	c
	inc	hl
	inc	hl
	ld	b,0
	jp	CARD_UTILS.calc_resource
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



;	if whose_move == 0
;		HL - player resources data
;		DE - enemy resources data
;	else
;		HL - enemy resources data
;		DE - player resources data
;
;	B	-	resource offset
;	C	-	value
jump_brick_shortage:
	; (0)	ALL PLAYERS LOSE 8 BRICKS.
	ld	bc,RES_OFFSET.BRICKS * 256 + 256 + -8
	call	PLAYER.active_calc_res
	jp	PLAYER.non_active_calc_res
	
jump_lucky_cache:
	; (1)	+2 BRICKS, +2 GEMS, PLAY AGAIN.
	ld	bc,RES_OFFSET.BRICKS * 256 + 2
	call	PLAYER.active_calc_res
	ld	b,RES_OFFSET.GEMS
	call	PLAYER.active_calc_res
	jp	_jump_set_play_again

jump_friendly_terrain:
	; (2)	+1 WALL. PLAY AGAIN.
	call	_jump_set_play_again
.wall1:
	ld	bc,RES_OFFSET.WALL * 256 + 1
	jp	PLAYER.active_calc_res

jump_miners:
	; (3)	+1 QUARRY.
	ld	bc,RES_OFFSET.QUARRY * 256 + 1
	jp	PLAYER.active_calc_res
jump_mother_lode:
	; (4)	IF QUARRY < ENEMY QUARRY, +2 QUARRY. ELSE, +1 QUARRY.
	call	jump_miners
	ld	b,RES_OFFSET.QUARRY

	call	PLAYER.active_res_addr
	push	hl
	call	PLAYER.non_active_res_addr
	pop	de
	
	ex	de,hl
	ld	a,(de)
	sub	(hl)
	ret	c
	jp	jump_miners

jump_dwarven_miners:
	; (5)	+4 WALL, +1 QUARRY.
	ld	bc,RES_OFFSET.WALL * 256 + 4
	call	PLAYER.active_calc_res
	jr	jump_miners

jump_work_overtime:
	; (6)	+5 WALL. YOU LOSE SIX GEMS.
	ld	bc,RES_OFFSET.GEMS * 256 + 256 + -6
	call	PLAYER.active_calc_res
.wall5:
	ld	bc,RES_OFFSET.WALL * 256 + 5
	jp	PLAYER.active_calc_res
	
jump_copping_the_tech:
	; (7)	IF QUARRY < ENEMY QUARRY, QUARRY = ENEMY QUARRY.
	ld	b,RES_OFFSET.QUARRY

	call	PLAYER.active_res_addr
	push	hl
	call	PLAYER.non_active_res_addr
	pop	de
	
	ex	de,hl
	ld	a,(de)
	sub	(hl)
	ret	z
	ret	c
	ld	a,(de)
	ld	(hl),a
	ret
jump_basic_wall:
	; (8)	+3 WALL.
	ld	bc,RES_OFFSET.WALL * 256 + 3
	jp	PLAYER.active_calc_res
jump_sturdy_wall:
	; (9)	+4 WALL.
	ld	bc,RES_OFFSET.WALL * 256 + 4
	jp	PLAYER.active_calc_res
jump_innovations:
	; (10)	+1 TO ALL PLAYER'S QUARRYS, YOU GAIN 4 GEMS.
	ld	bc,RES_OFFSET.QUARRY * 256 + 1
	call	PLAYER.active_calc_res
	call	PLAYER.non_active_calc_res
	ld	bc,RES_OFFSET.GEMS * 256 + 4
	jp	PLAYER.active_calc_res
jump_foundations:
	; (11)	IF WALL = 0, +6 WALL, ELSE +3 WALL.
	ld	b,RES_OFFSET.WALL
	call	PLAYER.active_res_addr
	xor	a
	cp	(HL)
	jr	nz,jump_basic_wall
	jp	jump_big_wall

jump_tremors:
	; (12)	ALL WALLS TAKE 5 DAMAGE. PLAY AGAIN.
	ld	bc,RES_OFFSET.WALL * 256 + 256 + -5
	call	PLAYER.active_calc_res
	call	PLAYER.non_active_calc_res	
	jp	_jump_set_play_again

jump_secret_room:
	; (13)	+1 MAGIC. PLAY AGAIN.
	call	_jump_set_play_again
.magic1:
	ld	bc,RES_OFFSET.MAGIC * 256 + 1
	jp	PLAYER.active_calc_res	
jump_earthquake:
	; (14)	-1 TO ALL PLAYER'S QUARRYS.
	ld	bc,RES_OFFSET.QUARRY * 256 + 256 + -1
	call	PLAYER.active_calc_res
	jp	PLAYER.non_active_calc_res
jump_big_wall:
	; (15)	+6 WALL.
	ld	bc,RES_OFFSET.WALL * 256 + 6
	jp	PLAYER.active_calc_res
jump_collapse_:
	; (16)	-1 ENEMY QUARRY.
	ld	bc,RES_OFFSET.QUARRY * 256 + 256 + -1
	jp	PLAYER.non_active_calc_res
jump_new_equipment:
	; (17)	+2 QUARRY.
	ld	bc,RES_OFFSET.QUARRY * 256 + 2
	jp	PLAYER.active_calc_res
jump_strip_mine:
	; (18)	-1 QUARRY, +10 WALL. YOU GAIN 5 GEMS.
	ld	bc,RES_OFFSET.QUARRY * 256 + 256 + -1
	call	PLAYER.active_calc_res
	ld	bc,RES_OFFSET.WALL * 256 + 10
	call	PLAYER.active_calc_res
	ld	bc,RES_OFFSET.GEMS * 256 + 5
	jp	PLAYER.active_calc_res
	
jump_reinforced_wall:
	; (19)	+8 WALL.
	ld	bc,RES_OFFSET.WALL * 256 + 8
	jp	PLAYER.active_calc_res
jump_porticulus:
	; (20)	+5 WALL, +1 DUNGEON.
	ld	bc,RES_OFFSET.WALL * 256 + 5
	call	PLAYER.active_calc_res
.dungeon1:
	ld	bc,RES_OFFSET.DUNGEON * 256 + 1
	jp	PLAYER.active_calc_res
jump_crystal_rocks:
	; (21)	+7 WALL, GAIN 7 GEMS.
	ld	bc,RES_OFFSET.GEMS * 256 + 7
	call	PLAYER.active_calc_res
.wall7:
	ld	bc,RES_OFFSET.WALL * 256 + 7
	jp	PLAYER.active_calc_res
jump_harmonic_ore:
	; (22)	+6 WALL, +3 TOWER.
	call	jump_big_wall
	jp	jump_amethyst
jump_mondo_wall:
	; (23)	+12 WALL.
	ld	bc,RES_OFFSET.WALL * 256 + 12
	jp	PLAYER.active_calc_res
jump_focused_designs:
	; (24)	+8 WALL, +5 TOWER.
	call	jump_reinforced_wall
.tower5:
	ld	bc,RES_OFFSET.TOWER * 256 + 5
	jp	PLAYER.active_calc_res	
jump_great_wall:
	; (25)	+15 WALL.
	ld	bc,RES_OFFSET.WALL * 256 + 15
	jp	PLAYER.active_calc_res
jump_rock_launcher:
	; (26)	+6 WALL. 10 DAMAGE TO ENEMY.
	call	jump_big_wall
	ld	c,-10
	jp	non_active_wall_damage
jump_dragon_s_heart:
	; (27)	+20 WALL, +8 TOWER.
	ld	bc,RES_OFFSET.WALL * 256 + 20
	call	PLAYER.active_calc_res
.tower8:
	ld	bc,RES_OFFSET.TOWER * 256 + 8
	jp	PLAYER.active_calc_res	
jump_forced_labor:
	; (28)	+9 WALL, LOSE 5 RECRUITS.
	ld	bc,RES_OFFSET.WALL * 256 + 9
	call	PLAYER.active_calc_res
	ld	bc,RES_OFFSET.RECRUITS * 256 + 256 - 5
	jp	PLAYER.active_calc_res	
jump_rock_garden:
	; (29)	+1 WALL, +1 TOWER, +2 RECRUITS.
	call	jump_friendly_terrain.wall1
	ld	bc,RES_OFFSET.RECRUITS * 256 + 2
	call	PLAYER.active_calc_res
.tower1:
	ld	bc,RES_OFFSET.TOWER * 256 + 1
	jp	PLAYER.active_calc_res
jump_flood_water:
	; (30)	PLAYER(S) W/LOWEST WALL ARE -1 DUNGEON AND 2 DAMAGE TO TOWER.
	;	У кого меньше стена по тому дамаг.	
	call 	PLAYER.get_res_addr
	ld	c,(hl)
	inc	hl
	ld	b,(hl)	
	ex	de,hl
	ld	e,(hl)
	inc 	hl
	ld	d,(hl)
	ex	de,hl
	or	a
	sbc	hl,bc
	ret	z	;	стены одинаковы.
	ld	bc,RES_OFFSET.DUNGEON * 256 + 256 - 1
	jr	nc,.damage
	call	PLAYER.non_active_calc_res
	ld	bc,RES_OFFSET.TOWER * 256 + 256 - 2
	jp	PLAYER.non_active_calc_res	
.damage:
	call	PLAYER.active_calc_res
	ld	bc,RES_OFFSET.TOWER * 256 + 256 - 2
	jp	PLAYER.active_calc_res	


jump_barracks:
	; (31)	+6 RECRUITS, +6 WALL. IF DUNGEON < ENEMY DUNGEON, +1 DUNGEON.
	ld	bc,RES_OFFSET.RECRUITS * 256 + 6
	call	PLAYER.active_calc_res
	call	jump_big_wall
	ld	b,RES_OFFSET.DUNGEON
	
	call	PLAYER.active_res_addr
	push	hl
	call	PLAYER.non_active_res_addr
	pop	de

	ex	de,hl
	ld	a,(de)
	sub	(hl)
	ret	z
	ret	c
	jp	jump_porticulus.dungeon1

jump_battlements:
	; (32)	+7 WALL, 6 DAMAGE TO ENEMY.
	call	jump_crystal_rocks.wall7
.enemy6_n:
	ld	c,-6
	jp	non_active_wall_damage

jump_shift:
	; (33)	SWITCH YOUR WALL WITH ENEMY WALL.
	call 	PLAYER.get_res_addr
	ld	c,(hl)
	inc	hl
	ld	b,(hl)	
	push	hl
	ex	de,hl
	ld	e,(hl)
	ld	(hl),c
	inc 	hl
	ld	d,(hl)
	ld	(hl),b
	pop	hl
	ld	(hl),d
	dec	hl
	ld	(hl),e
	ret
jump_quartz:
	; (34)	+1 TOWER. PLAY AGAIN.
	call	jump_rock_garden.tower1
	jp	_jump_set_play_again
jump_smoky_quartz:
	; (35)	1 DAMAGE TO ENEMY TOWER. PLAY AGAIN.
	call	_jump_set_play_again
	ld	bc,RES_OFFSET.TOWER * 256 + 256 - 1
	jp	PLAYER.non_active_calc_res

jump_amethyst:
	; (36)	+3 TOWER.
	ld	bc,RES_OFFSET.TOWER * 256 + 3
	jp	PLAYER.active_calc_res
jump_spell_weavers:
	; (37)	+1 MAGIC.
	jp	jump_secret_room.magic1
jump_prism:
	; (38)	DRAW 1 CARD. DISCARD 1 CARD. PLAY AGAIN.
	ld	a,2
	ld	(DATA.play_again),a
	ld	(DATA.force_discard_card),a
	ret
jump_lodestone:
	; (39)	+8 TOWER. THIS CARD CAN'T BE DISCARDED WITHOUT PLAYING IT.
	;	TODO test
	call	jump_dragon_s_heart.tower8
	ld	a,b	; B != 0; (B = 2 (TOWER))
	ld	(DATA.cant_discard),a
	ret
jump_solar_flare:
	; (40)	+2 TOWER. 2 DAMAGE TO ENEMY TOWER.
	ld	bc,RES_OFFSET.TOWER * 256 + 2
	call	PLAYER.active_calc_res
.tower2_n:
	ld	bc,RES_OFFSET.TOWER * 256 + 256 - 2
	jp	PLAYER.non_active_calc_res
jump_crystal_matrix:
	; (41)	+1 MAGIC. +3 TOWER. +1 ENEMY TOWER.
	call	jump_secret_room.magic1
	call	jump_amethyst
	ld	bc,RES_OFFSET.TOWER * 256 + 1
	jp	PLAYER.non_active_calc_res
jump_gemstone_flaw:
	; (42)	3 DAMAGE TO ENEMY TOWER.
	ld	bc,RES_OFFSET.TOWER * 256 + 256 - 3
	jp	PLAYER.non_active_calc_res
jump_ruby:
	; (43)	+5 TOWER.
	jp	jump_focused_designs.tower5
jump_gem_spear:
	; (44)	5 DAMAGE TO ENEMY TOWER.
	ld	bc,RES_OFFSET.TOWER * 256 + 256 - 5
	jp	PLAYER.non_active_calc_res
jump_power_burn:
	; (45)	5 DAMAGE TO YOUR TOWER. +2 MAGIC.
	ld	bc,RES_OFFSET.TOWER * 256 + 256 - 5
	call	PLAYER.active_calc_res
.magic2:
	ld	bc,RES_OFFSET.MAGIC * 256 + 2
	jp	PLAYER.active_calc_res
jump_harmonic_vibe:
	; (46)	+1 MAGIC. +3 TOWER. +3 WALL.
	call	jump_secret_room.magic1
	call	jump_amethyst
	jp	jump_basic_wall
jump_parity:
	; (47) 	ALL PLAYER'S MAGIC EQUALS THE HIGHEST PLAYER'S MAGIC.
	ld	hl,DATA.player_final_resource + RES_OFFSET.MAGIC
	ld	de,DATA.computer_final_resource + RES_OFFSET.MAGIC
	ld	a,(de)
	cp	(hl)
	jr	nc,.a_more
	ex	de,hl
	ld	a,(de)
.a_more:
	ld	(hl),a
	ret

jump_emerald:
	; (48) 	+8 TOWER.
	jp	jump_dragon_s_heart.tower8
jump_pearl_of_wisdom:
	; (49) 	+5 TOWER. +1 MAGIC.
	call	jump_focused_designs.tower5
	jp	jump_secret_room.magic1
jump_shatterer:
	; (50) 	-1 MAGIC. 9 DAMAGE TO ENEMY TOWER.
	ld	bc,RES_OFFSET.TOWER * 256 + 256 + -9
	call	PLAYER.non_active_calc_res
.magic1_n:
	ld	bc,RES_OFFSET.MAGIC * 256 + 256 + -1
	jp	PLAYER.active_calc_res

jump_crumblestone:
	; (51) 	+5 TOWER. ENEMY LOSES 6 BRICKS.
	call	jump_focused_designs.tower5
	ld	bc,RES_OFFSET.BRICKS * 256 + 256 + -6
	jp	PLAYER.non_active_calc_res

jump_sapphire:
	; (52) 	+11 TOWER.
	ld	bc,RES_OFFSET.TOWER * 256 + 11
	jp	PLAYER.active_calc_res
jump_discord:
	; (53) 	7 DAMAGE TO ALL TOWERS, ALL PLAYERS MAGIC -1
	ld	bc,RES_OFFSET.TOWER * 256 + 256 + -7
	call	PLAYER.active_calc_res
	call	PLAYER.non_active_calc_res
	ld	bc,RES_OFFSET.MAGIC * 256 + 256 + -1
	call	PLAYER.active_calc_res
	jp	PLAYER.non_active_calc_res
jump_fire_ruby:
	; (54) 	+6 TOWER. 4 DAMAGE TO ALL ENEMY TOWERS.
	ld	bc,RES_OFFSET.TOWER * 256 + 256 + -4
	call	PLAYER.non_active_calc_res
	ld	bc,RES_OFFSET.TOWER * 256 + 6
	jp	PLAYER.active_calc_res
jump_quarry_s_help:
	; (55) 	+7 TOWER. LOSE 10 BRICKS.
	ld	bc,RES_OFFSET.BRICKS * 256 + 256 + -10
	call	PLAYER.active_calc_res
	ld	bc,RES_OFFSET.TOWER * 256 + 7
	jp	PLAYER.active_calc_res
jump_crystal_shield:
	; (56) 	+8 TOWER. +3 WALL.
	call	jump_dragon_s_heart.tower8
	jp	jump_basic_wall
jump_empathy_gem:
	; (57) 	+8 TOWER. +1 DUNGEON.
	call	jump_dragon_s_heart.tower8
	jp	jump_porticulus.dungeon1
jump_diamond:
	; (58) 	+15 TOWER.
	ld	bc,RES_OFFSET.TOWER * 256 + 15
	jp	PLAYER.active_calc_res
jump_sanctuary:
	; (59) 	+10 TOWER. +5 WALL, GAIN 5 RECRUITS.
	ld	bc,RES_OFFSET.TOWER * 256 + 10
	call	PLAYER.active_calc_res
	call	jump_work_overtime.wall5
	ld	bc,RES_OFFSET.RECRUITS * 256 + 5
	jp	PLAYER.active_calc_res
jump_lava_jewel:
	; (60) 	+12 TOWER. 6 DAMAGE TO ALL ENEMIES.
	ld	bc,RES_OFFSET.TOWER * 256 + 12
	call	PLAYER.active_calc_res
	jp	jump_battlements.enemy6_n

jump_dragon_s_eye:
	; (61) 	+20 TOWER.
	ld	bc,RES_OFFSET.TOWER * 256 + 20
	jp	PLAYER.active_calc_res
jump_crystallize:
	; (62) 	+11 TOWER. -6 WALL.
	call	jump_sapphire
	ld	bc,RES_OFFSET.WALL * 256 + 256 + -6
	jp	PLAYER.active_calc_res

jump_bag_of_baubles:
	; (63) 	IF TOWER < ENEMY TOWER, +2 TOWER. ELSE +1 TOWER.
	call	jump_rock_garden.tower1
	ld	b,RES_OFFSET.TOWER

	call	PLAYER.active_res_addr
	push	hl
	call	PLAYER.non_active_res_addr
	pop	de
	
	ex	de,hl
	ld	a,(de)
	sub	(hl)
	ret	c
	jp	jump_rock_garden.tower1
jump_rainbow:
	; (64) 	+1 TOWER TO ALL PLAYERS. YOU GAIN 3 GEMS.
	ld	bc,RES_OFFSET.GEMS * 256 + 3
	call	PLAYER.active_calc_res
	ld	bc,RES_OFFSET.TOWER * 256 + 1
	call	PLAYER.active_calc_res
	jp	PLAYER.non_active_calc_res


jump_apprentice:
	; (65) 	+4 TOWER, YOU LOSE 3 RECRUITS, 2 DAMAGE TO ENEMY TOWER.
	call	jump_solar_flare.tower2_n
	ld	bc,RES_OFFSET.RECRUITS * 256 + 256 + -3
	call	PLAYER.active_calc_res
.tower4:
	ld	bc,RES_OFFSET.TOWER * 256 + 4
	jp	PLAYER.active_calc_res
	
jump_lightning_shard:
	; (66) 	IF TOWER < ENEMY WALL, 8 DAMAGE TO ENEMY TOWER. ELSE 8 DAMAGE.
	ld	b,RES_OFFSET.TOWER
	call	PLAYER.active_res_addr
	push	hl
	ld	b,RES_OFFSET.WALL
	call	PLAYER.non_active_res_addr
	pop	de
	ld	bc,RES_OFFSET.TOWER * 256 + 256 + -8
	ld	a,(de)
	sub	(hl)
	jp	nc,non_active_wall_damage
	jp	PLAYER.non_active_calc_res
jump_phase_jewel:
	; (67) 	+13 TOWER. +6 RECRUITS. +6 BRICKS.
	ld	bc,RES_OFFSET.TOWER * 256 + 13
	call	PLAYER.active_calc_res
	ld	bc,RES_OFFSET.RECRUITS * 256 + 6
	call	PLAYER.active_calc_res
	ld	bc,RES_OFFSET.BRICKS * 256 + 6
	jp	PLAYER.active_calc_res
jump_mad_cow_disease:
	; (68) 	ALL PLAYERS LOSE 6 RECRUITS.
	ld	bc,RES_OFFSET.RECRUITS * 256 + 256 + -6
	call	PLAYER.active_calc_res
	jp	PLAYER.non_active_calc_res
jump_faerie:
	; (69) 	2 DAMAGE. PLAY AGAIN.
	ld	c,-2
	call	non_active_wall_damage
	jp	_jump_set_play_again
jump_moody_goblins:
	; (70) 	4 DAMAGE. YOU LOSE 3 GEMS.
	ld	bc,RES_OFFSET.GEMS * 256 + 256 + -3
	call	PLAYER.active_calc_res
.damage4:
	dec	c
	jp	non_active_wall_damage
jump_minotaur:
	; (71) 	+1 DUNGEON.
	jp	jump_porticulus.dungeon1
jump_elven_scout:
	; (72) 	DRAW 1 CARD. DISCARD 1 CARD. PLAY AGAIN.
	jp	jump_prism
jump_goblin_mob:
	; (73) 	6 DAMAGE. YOU TAKE 3 DAMAGE.
	ld	c,-6
	call	non_active_wall_damage
.damage3_me:
	ld	c,-3
	jp	active_wall_damage
jump_goblin_archers:
	; (74) 	3 DAMAGE TO ENEMY TOWER. YOU TAKE 1 DAMAGE.
	ld	bc,RES_OFFSET.TOWER * 256 + 256 + -3
	call	PLAYER.non_active_calc_res
	ld	c,-1
	jp	active_wall_damage
jump_shadow_faerie:
	; (75) 	2 DAMAGE TO ENEMY TOWER. PLAY AGAIN.
	ld	bc,RES_OFFSET.TOWER * 256 + 256 + -2
	call	PLAYER.non_active_calc_res
	jp	_jump_set_play_again	
jump_orc:
	; (76) 	5 DAMAGE.
	ld	c,-5
	jp	non_active_wall_damage
jump_dwarves:
	; (77) 	4 DAMAGE. +3 WALL.
	ld	c,-4
	call	non_active_wall_damage
	ld	bc,RES_OFFSET.WALL * 256 + 3
	jp	PLAYER.active_calc_res
jump_little_snakes:
	; (78) 	4 DAMAGE TO ENEMY TOWER.
	ld	bc,RES_OFFSET.TOWER * 256 + 256 + -4
	jp	PLAYER.non_active_calc_res
jump_troll_trainer:
	; (79) 	+2 DUNGEON.
	ld	bc,RES_OFFSET.DUNGEON * 256 + 2
	jp	PLAYER.active_calc_res
jump_tower_gremlin:
	; (80) 	2 DAMAGE. +4 TOWER. +2 WALL.
	ld	c,-2
	call	non_active_wall_damage
	call	jump_apprentice.tower4
	ld	bc,RES_OFFSET.WALL * 256 + 2
	jp	PLAYER.active_calc_res
jump_full_moon:
	; (81) 	+1 TO ALL PLAYER'S DUNGEON. YOU GAIN 3 RECRUITS.
	ld	bc,RES_OFFSET.DUNGEON * 256 + 1
	call	PLAYER.active_calc_res
	call	PLAYER.non_active_calc_res
	ld	bc,RES_OFFSET.RECRUITS * 256 + 3
	jp	PLAYER.active_calc_res

jump_slasher:
	; (82) 	6 DAMAGE.
	jp	jump_battlements.enemy6_n
jump_ogre:
	; (83) 	7 DAMAGE.
	ld	c,-7
	jp	non_active_wall_damage
jump_rabid_sheep:
	; (84) 	6 DAMAGE. ENEMY LOSES 3 RECRUITS.
	call	jump_battlements.enemy6_n
	ld	bc,RES_OFFSET.RECRUITS * 256 + 256 + -3
	jp	PLAYER.non_active_calc_res
jump_imp:
	; (85) 	6 DAMAGE. ALL PLAYERS LOSE 5 BRICKS, GEMS AND RECRUITS.
	call	jump_battlements.enemy6_n
	ld	bc,RES_OFFSET.BRICKS * 256 + 256 + -5
	ld	a,3
.loop:
	push	af
	call	PLAYER.active_calc_res
	call	PLAYER.non_active_calc_res
	pop	af
	inc	b
	inc	b
	inc	b
	inc	b
	dec	a
	jr	nz,.loop
	ret

jump_spizzer:
	; (86) 	IF ENEMY WALL = 0, 10 DAMAGE, ELSE 6 DAMAGE.
	ld	b,RES_OFFSET.WALL
	call	PLAYER.active_res_addr
	xor	a
	cp	(HL)
	jp	nz,jump_battlements.enemy6_n
	jp	jump_stone_giant.damage10
jump_werewolf:
	; (87) 	9 DAMAGE.
	ld	c,-9
	jp	non_active_wall_damage
jump_corrosion_cloud:
	; (88) 	IF ENEMY WALL > 0, 10 DAMAGE, ELSE 7 DAMAGE.
	ld	b,RES_OFFSET.WALL
	call	PLAYER.active_res_addr
	xor	a
	cp	(HL)
	jp	z,jump_stone_giant.damage10
	jp	jump_ogre
jump_unicorn:
	; (89) 	IF MAGIC > ENEMY MAGIC, 12 DAMAGE, ELSE 8 DAMAGE.
	ld	b,RES_OFFSET.MAGIC
	call	PLAYER.active_res_addr
	push	hl
	call	PLAYER.non_active_res_addr
	pop	de
	ex	de,hl
	ld	a,(de)
	sub	(hl)
	jr	nc,jump_rock_stompers.damage8
.damage12:
	ld	c,-12
	jp	non_active_wall_damage
jump_elven_archers:
	; (90) 	IF WALL > ENEMY WALL, 6 DAMAGE TO ENEMY TOWER, ELSE 6 DAMAGE.
	ld	b,RES_OFFSET.WALL
	call	PLAYER.active_res_addr
	push	hl
	call	PLAYER.non_active_res_addr
	pop	de
	ex	de,hl
	ld	a,(de)
	sub	(hl)
	jp	nc,jump_battlements.enemy6_n
.tower6:
	ld	bc,RES_OFFSET.TOWER * 256 + 256 + -6
	jp	PLAYER.non_active_calc_res

jump_succubus:
	; (91) 	5 DAMAGE TO ENEMY TOWER, ENEMY LOSES 8 RECRUITS.
	call	jump_gem_spear
	ld	bc,RES_OFFSET.RECRUITS * 256 + 256 + -8
	jp	PLAYER.non_active_calc_res	
	
jump_rock_stompers:
	; (92) 	8 DAMAGE, -1 ENEMY QUARRY.
	call	jump_collapse_
.damage8:
	ld	c,-8
	jp	non_active_wall_damage
jump_thief:
	; (93) 	ENEMY LOSES 10 GEMS, 5 BRICKS, YOU GAIN 1/2 AMT. ROUND UP.
	ld	bc,RES_OFFSET.GEMS * 256 + 256 + -10
	call	PLAYER.non_active_calc_res
	ld	bc,RES_OFFSET.BRICKS * 256 + 256 + -5
	call	PLAYER.non_active_calc_res
	ld	bc,RES_OFFSET.GEMS * 256 + 5
	call	PLAYER.active_calc_res
	ld	bc,RES_OFFSET.BRICKS * 256 + 3
	jp	PLAYER.active_calc_res
jump_stone_giant:
	; (94) 	10 DAMAGE. +4 WALL.
	call	jump_sturdy_wall
.damage10:
	ld	c,-10
	jp	non_active_wall_damage
jump_vampire:
	; (95) 	10 DAMAGE. ENEMY LOSES 5 RECRUITS, -1 ENEMY DUNGEON.
	call	jump_stone_giant.damage10
	ld	bc,RES_OFFSET.RECRUITS * 256 + 256 + -5
	call	PLAYER.non_active_calc_res	
.dungeon1_n:
	ld	bc,RES_OFFSET.DUNGEON * 256 + 256 + -1
	jp	PLAYER.non_active_calc_res
jump_dragon:
	; (96) 	20 DAMAGE. ENEMY LOSES 10 GEMS, -1 ENEMY DUNGEON.
	ld	c,-20
	call	non_active_wall_damage
	ld	bc,RES_OFFSET.GEMS * 256 + 256 + -10
	call	PLAYER.non_active_calc_res	
	jp	jump_vampire.dungeon1_n
jump_spearman:
	; (97) 	IF WALL > ENEMY WALL DO 3 DAMAGE ELSE DO 2 DAMAGE.
	ld	b,RES_OFFSET.WALL
	call	PLAYER.active_res_addr
	push	hl
	call	PLAYER.non_active_res_addr
	pop	de
	ld	a,(de)
	sub	(hl)
	jr	z,.damage2
	jr	nc,jump_gnome.damage3
.damage2:
	ld	c,-2
	jp	non_active_wall_damage


jump_gnome:
	; (98) 	3 DAMAGE. +1 GEM.
	ld	bc,RES_OFFSET.GEMS * 256 + 1
	call	PLAYER.active_calc_res
.damage3:
	ld	c,-3
	jp	non_active_wall_damage	
jump_berserker:
	; (99) 	8 DAMAGE. 3 DAMAGE TO YOUR TOWER.
	call	jump_rock_stompers.damage8
	ld	bc,RES_OFFSET.TOWER * 256 + 256 + -3
	jp	PLAYER.active_calc_res

jump_warlord:
	; (100) 	13 DAMAGE. YOU LOSE 3 GEMS.
	ld	bc,RES_OFFSET.GEMS * 256 + 256 + -3
	call	PLAYER.active_calc_res	
	ld	c,-13
	jp	non_active_wall_damage	
jump_pegasus_lancer:
	; (101) 	12 DAMAGE TO ENEMY TOWER.
	ld	bc,RES_OFFSET.TOWER * 256 + 256 + -12
	jp	PLAYER.non_active_calc_res	