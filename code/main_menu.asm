	module MAIN_MENU


set_keys:
	call	PLAYER.clear_keys
	ld	hl,PLAYER.player_key_left
	ld	b,#FE
.loop
	rrc	b
	call	INPUT.listener
	jr	z,.loop
.check_keys:
	push	hl
	ld	c,a
	ld	hl,PLAYER.player_key_left
.cl:
	ld	a,l
	cp	low PLAYER.player_key_pause + 2
	jr	z,.end		
	ld	a,b
	cp	(hl)
	inc	hl
	jr	nz,.cl
	ld	a,c
	cp	(hl)
	inc	hl
	jr	nz,.cl
.keys_overlap:
	//	TODO	вывести сообщение что текущая выбираемая клавиша уже задействована.
	ld	de,34032
.l3:
	ld	a,e
	out	(254),a
	dec	de
	ld	a,d
	or	e
	jr	nz,.l3
	pop	hl
	jr	.loop
.end:
	pop	hl
	ld	a,c
.save_key:
	ld	(hl),b
	inc	hl
	ld	(hl),a
	inc	hl
	call	wait_up_key
	ld	a,l
	cp	low PLAYER.player_key_pause + 2
	ret	z
	jr	.loop
	endmodule