////////////////////////////////////////////////////////////////////////////////////////////////////
; half-row	DEC	HEX	BIN
; Space...B	32766	7FFE	01111111 11111110
; Enter...H	49150	BFFE	10111111 11111110
; P...Y		57342	DFFE	11011111 11111110
; 0...6		61438	EFFE	11101111 11111110
; 1...5		63486	F7FE	11110111 11111110
; Q...T		64510	FBFE	11111011 11111110
; A...G		65022	FDFE	11111101 11111110
; CS...V	65278	FEFE	11111110 11111110
////////////////////////////////////////////////////////////////////////////////////////////////////
	module INPUT
ENTER = ';'
CS = 	'['
SS = 	'/'
SPACE = ' '
chars:
	db "}ZXCV"	; #FE (CS)
	db "ASDFG"	; #FD
	db "QWERT"	; #FB
	db "12345"	; #F7
	db "09876"	; #EF
	db "POIUY"	; #DF
	db "{LKJH"	; #BF (ENTER)
	db "^`MNB"	; #7F (SPACE,SS)
///////////////////////////////////////////////////////////////////////////////////////////////////////
last_port:	db	0
last_key:	db	0
///////////////////////////////////////////////////////////////////////////////////////////////////////
;	+ B - half-row port
;	+ return: A - key bit
listener:
	ld	c,#FE
	in	a,(c)
	cpl
	and	%00011111
	ret
///////////////////////////////////////////////////////////////////////////////////////////////////////
listener_with_pre:
	ld	ix,INPUT.last_port
	ld	b,(hl)
	inc	hl
	call	INPUT.listener
	ld	c,a
	cp	(hl)
	ret	nz
	sub 	(ix)
	jr 	z,1f
	ld 	a,#ff
1  	inc 	a
	jp	set_last
.iwp:
	ld	(ix),0
	ld	(ix + 1),0
	ret
; test_kempston:	
; 	ei
; 	halt
; 	ld	de,1000
; .loop:
; 	xor	a
; 	in	a,(#1F)
; 	inc	a
; 	jr	z,.set_kempston
; 	dec	de
; 	ld	a,e
; 	or	d
; 	jr	nz,.loop
; 	dec	a
; .set_kempston:
; 	ld	(DATA.kemp_disable),a
; 	ret
///////////////////////////////////////////////////////////////////////////////////////////////////////
;	Юзается 
;	+ B - keyboard or joystick port
;	+ C - key or joy bit
;	+ return: flag Z (0 - used, 1 - not used)
is_key_used:
	ld	hl,DATA.keyboard
.next_byte:
	ld	a,l
	cp	low DATA.end_keyboard
	jr	nz,.next_port
	dec	h		; set flag Z
	ret
.next_port:
	ld	a,(hl)
	inc	hl
	inc	hl
	cp	b
	jr	nz,.next_byte
	dec	hl
	ld	a,(hl)
	inc	hl
	cp	c
	ret	z		; flag Z is reset
	jr	.next_byte
///////////////////////////////////////////////////////////////////////////////////////////////////////

set_keys:
	pp_xy_hl_scr (MAIN_MENU.redKeysX + 9),MAIN_MENU.redKeysY
	ld	(.scr_addr + 1),hl
	call	wait_up_key
	call	clear_keys
	ld	hl,DATA.keyboard
.loop:
	; ei
	; halt
.port:
	ld	a,#FE
	rrca
	ld	(.port + 1),a
	ld	b,a
	call	listener
	jr	z,.loop
	ld	c,a		; key bit
	push	hl
	call	is_key_used
	pop	hl
	jr	z,.loop
.save:
	push	hl,bc
	call	.show_char
	pop	bc,hl
	ld	(hl),b
	inc	hl
	ld	(hl),c
	inc	hl
	ld	a,l
	cp	low DATA.end_keyboard
	ret	z
	jr	.loop
.show_char:
	ld	a,c
	call	char_addr_from_table
	ld	c,0
.scr_addr:
	ld	de,0
	push	de
	call	RENDERING.draw_half
.next_symbol:
	pop	de
	call	down_symbol
	ld	(.scr_addr + 1),de
	ret

///////////////////////////////////////////////////////////////////////////////////////////////////////


keyboard_polling:
	ld	ix,last_port
	ld	hl,DATA.player_key_left
	ld	de,PLAYER.key_jump
.loop:
	ld	b,(hl)
	inc	hl
	call	listener
	ld	c,a
	cp	(hl)
	inc	hl
	jr	nz,.more
.jump:
	cp	(ix + 1)
	ret	z
	call	set_last
	jp	PLAYER.control_polling.jump
	ret
.more:
	inc	de
	inc	de
	ld	a,l
	cp	low DATA.player_key_pause + 2
	ld	a,c
	jr	z,clear_last
	jr	.loop
///////////////////////////////////////////////////////////////////////////////////////////////////////
kempston_polling:
	ld	ix,last_port
	ld	hl,DATA.player_key_left
	ld	de,PLAYER.key_jump

	xor	a
	in	a,(KEMPSTON_PORT)
.loop:
	inc	hl
	or	a
	jr	z,clear_last
	cp	#E0
	jr	z,.more
	cp	(ix + 1)
	jr	z,.more
	cp	(hl)
	jp	z,.jump
.more:
	inc	hl
	inc	de
	inc	de
	ld	c,a
	ld	a,l
	cp	low DATA.player_key_pause + 2
	ld	a,c
	ret	z
	jr	.loop
.jump:
	call	clear_last + 1
	jp	PLAYER.control_polling.jump
///////////////////////////////////////////////////////////////////////////////////////////////////////
clear_last:
	xor	a
	ld	(ix),a
	ld	(ix + 1),a
	ret
set_last:
	ld	(ix),b
	ld	(ix + 1),c
	ret

;	+ clear player key polling
clear_keys:
	ld	hl,DATA.keyboard
	ld	de,DATA.keyboard + 1
	ld	bc,9
	ld	(hl),0
	ldir
	ret
	endmodule