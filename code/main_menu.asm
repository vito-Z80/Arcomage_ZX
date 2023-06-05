	module MAIN_MENU

///////////////////////////////////////////////////////////////////////////////////////////////////////
redKeysX:			=	2
redKeysY:			=	17
menuX:				=	16
menuY:				=	8

MENU_COLOR			=	%01001111
REDEFINE_COLOR			=	%01110011
///////////////////////////////////////////////////////////////////////////////////////////////////////
run:
	xor	a
	call	clear_screen
	call	_display
.loop:

	ld	hl,DATA.player_key_move
	ld	a,(select_control + 1)
	rrca
	jr	c,.keyboard
	xor	a
	in	a,(KEMPSTON_PORT)
	inc	hl
	cp	(hl)
	jr	z,key_listener.start_game
.keyboard:
	ld	b,(hl)
	inc	hl
	call	INPUT.listener
	cp	(hl)
	jr	z,key_listener.start_game

.more:


	ld	hl,run.loop
	; ret
///////////////////////////////////////////////////////////////////////////////////////////////////////
key_listener:
	ld	b,#F7
	call	INPUT.listener
	rrca
	jp	c,select_control
	rrca
	jr	c,redefine_keys
	rrca
	ret	nc
.difficulty:
	ld	a,(DATA.difficulty)
	xor	1
	ld	(DATA.difficulty),a
	call	show_diff
	call	wait_up_key
.end:
	ld	hl,run.loop
	ret
.start_game:
	call	GAME.init
	ld	hl,GAME.run
	ret
_display:
	ld	a,MENU_COLOR
	ld	bc,8 * 256 + 7
	pp_xy_hl_attr menuX, menuY
	call	fill_attr_rect
	ld	hl,TEXT.control
	pp_xy_de_scr  menuX, menuY + 1
	ld	b,3
.next_label:
	push	bc,de
	call	_DISPLAY.text
	pop	de
	call	down_symbol
	inc	hl
	pop	bc
	djnz	.next_label
	call	down_symbol
	ld	hl,TEXT.fire_to_start
	call	_DISPLAY.text


	call	select_control
	ld	a,(DATA.difficulty)
;	A - difficulty
show_diff:
	ld	hl,TEXT.dif_state_easy
	xor	1
	jr	nz,.easy
	ld	hl,TEXT.dif_state_hard
.easy:
	push	hl
	ld	bc,3 * 256 + 1
	ld	hl,font4
	pp_xy_de_scr  menuX + 2, menuY + 3
	call	fill_scr_rect
	pop	hl
	pp_xy_de_scr  menuX + 2, menuY + 3
	call	_DISPLAY.text
	ld	hl,run.loop
	ret
///////////////////////////////////////////////////////////////////////////////////////////////////////
redefine_keys:
	; show
	ld	a,REDEFINE_COLOR
	call	.clear_area
	ld	hl,TEXT.key_left
	pp_xy_de_scr redKeysX, redKeysY
	ld	b,5
.next_label:
	push	bc,de
	call	_DISPLAY.text
	pop	de
	call	down_symbol
	inc	hl
	pop	bc
	djnz	.next_label
	call	INPUT.set_keys
	call	PLAYER.wait
	xor	a
.clear_area:
	ld	bc,10 * 256 + 5
	pp_xy_hl_attr redKeysX, redKeysY
	call	fill_attr_rect
	ld	bc,10 * 256 + 5
	ld	hl,font4 
	pp_xy_de_scr redKeysX, redKeysY
	call	fill_scr_rect
	ld	hl,DATA.keyboard
	call	show_control_label.fill
	ld	hl,run.loop
	ret
///////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////
select_control:
	ld	a,4			; 1 - keyboard, 2 - kempston 5, 4 - kempston 8
	rlca
	cp	8
	jr	nz,.no_xor
	ld	a,1
.no_xor:
	ld	(select_control + 1),a
	; ret
show_control_label:
	; ld	a,(select_control + 1)
	rrca
	jr	c,.keyboard
	rrca
	jr	c,.kemp_5
	rrca
	jp	nc,key_listener.end
.kemp_8:
	ld	hl,DATA.kempston_8_bits
	call	.fill
	ld	hl,TEXT.control_kempston_8
	jr	.show
.keyboard:
	ld	hl,DATA.keyboard
	call	.fill
	ld	hl,TEXT.control_keyboard
.show:
	push	hl
	ld	bc,6 * 256 + 1
	ld	hl,font4
	pp_xy_de_scr  menuX + 2, menuY + 1
	call	fill_scr_rect
	pop	hl
	pp_xy_de_scr  menuX + 2, menuY + 1
	call	_DISPLAY.text
	call	wait_up_key
	jp	key_listener.end
.kemp_5:
	ld	hl,DATA.kempston_5_bits
	call	.fill
	ld	hl,TEXT.control_kempston_5
	jr	.show
.fill:
	ld	de,DATA.player_key_left
	ld	bc,10
	ldir
	ret
///////////////////////////////////////////////////////////////////////////////////////////////////////
	endmodule