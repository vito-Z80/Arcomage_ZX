;	+ 
;	+ TODO: не забыть завести методы обработки карт: elven, prisma
;	+ 
;	+ init
;	+ run
;	+ deal_cards
;	+ set_resource
;	+ new_card
	module GAME



///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
init:

	;	сброс индекса курсора. предыдущий курсор не должен совпадать с текущим для первого отображения курсора 
	xor	a
	ld	(DATA.cursor),a
	ld	(DATA.whose_move),a
	inc	a		;	A = 1
	ld	(DATA.pre_cursor),a
	ld	(DATA.play_again),a

	inc	a		;	A = 2
	ld	a,DIFFICULTY.HARD
	ld	(DATA.difficulty),a		; TODO убрать отсюда 
	ld	a,#0D
	ld	(CALC.table_x),a


	call	CALC.difficulty

	call	_DISPLAY.move_message

	call	set_resources
	call	deal_cards

	call	_DISPLAY.resource_icons
	call	_DISPLAY.player_cards
.resources:
	call	_DISPLAY.p_wall
	call	_DISPLAY.p_tower
	call	_DISPLAY.e_wall
	call	_DISPLAY.e_tower
	call	_DISPLAY.p_res_quarry
	call	_DISPLAY.p_res_bricks
	call	_DISPLAY.p_res_magic
	call	_DISPLAY.p_res_gems
	call	_DISPLAY.p_res_dungeon
	call	_DISPLAY.p_res_recruits
	call	_DISPLAY.e_res_quarry
	call	_DISPLAY.e_res_bricks
	call	_DISPLAY.e_res_magic
	call	_DISPLAY.e_res_gems
	call	_DISPLAY.e_res_dungeon
	call	_DISPLAY.e_res_recruits

.text:
	call	RENDERING.clear_frame
	call	RENDERING.clear_name_space
	call 	RENDERING.paint_frame_color
	

	call 	CARD_UTILS.card_id_by_cursor
	push	af
	call 	CARD_UTILS.depack_card_text
	pop	af
	call	_DISPLAY.card_name
	call	_DISPLAY.card_text
	call 	_DISPLAY.cursor

	ret

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
wait:
	ld	a,0
	dec	a
	ret	c
	ld	(wait + 1),a
	ret
set_wait:
	ld	a,50
	ld	(wait + 1),a
	ret
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

is_res_alignment:
	db	0
phase_card_from_bottom:
	db	0


run:
	call	_DISPLAY.alignment_resources	
	ld	a,(DATA.play_again)
	or	a
	jr	nz,.same_player		; ходит предыдудщий игрок.
	; ;	дать ход следующему игроку
	inc	a
	ld	(DATA.play_again),a
	; ;	сменить ходящего игрока.
	ld	a,(DATA.whose_move)
	xor	1
	ld	(DATA.whose_move),a
	push	af
	call	z,_DISPLAY.player_cards
	pop	af
	call	nz,_DISPLAY.comp_cards
	call	_DISPLAY.move_message
	call	daily_gain
.same_player:

	ld	a,(DATA.whose_move)
	or	a
	jp	z,PLAYER.key_polling
	jp	PLAYER.enemy_move

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

;	+ установка значений ресурсов обоим игрокам по стартовому шаблону.
set_resources:
	ld	hl,DATA.tmp_resources
	ld	de,DATA.player_final_resource
	ld	bc,RES_OFFSET
	push	bc
	ldir
	dec	hl
	ld	de,DATA.computer_final_resource + RES_OFFSET - 1
	pop	bc
	lddr
	ret
	
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
;	Сравнение значений в двух областях памяти.
;	+ HL - memory place 1
;	+ DE - memory place 2
;	+ return: flag Z = 0 - все значения равны. 1 - имеются разные данные
mem_compare:
	; ld	hl,DATA.player_resources
	; ld	de,DATA.player_final_resource
	ld	b,32
.loop:
	ld	a,(de)
	cp	(hl)
	inc	hl
	inc	de
	ret	nz
	djnz	.loop
	ret
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
;	+ индексы особых карт:
; 	+ 38, 72	-	DRAW 1 CARD. DISCARD 1 CARD. PLAY AGAIN.


;	+ сделать ход картой.
;	+ TODO разделить процедуру на обоих игроков, так как игрок выбирает карты руками а компьютерой какой-то логикой.
move_action:
	call 	CARD_UTILS.card_id_by_cursor
	push	af		; A - card index
	call 	PLAYER.pay
	ld	a,(DATA.is_paid)
	or	a
	jr	nz,.player_cant_pay
	pop	af		; A - card index
	ld	de,map_jump_data
	call	pointer
	jp	(hl)
.player_cant_pay:
	;	TODO	text message about cant pay
	pop	bc	;	заглушка по стеку
	ret
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
;	абсолютный тупой рандом раздачи карт для обоих игроков. FIXME - улучшить по уровню сложности партии и редкости карты.
deal_cards:
	ld	hl,DATA.player_cards
	ld	b,CARDS_ON_TABLE * 2
.loop:
	call	new_card_id
	ld	(hl),a
	inc	hl
	djnz	.loop
	ret

new_card:
	call	CARD_UTILS.card_id_by_cursor
	;	hl - адрес индекса карты по курсору
	call	new_card_id
	jp	_DISPLAY.card_sprite
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
;	+ Ежедневный прирост ресурсов.
;	+ 
;	+ baracks value += quarry value
;	+ gems value += magic value
;	+ recruits value += dungeon value
daily_gain:
	ld	ix,DATA.player_final_resource + RES_OFFSET.QUARRY
	ld	a,(DATA.whose_move)
	or	a
	jr	z,.loop - 2
	ld	ix,DATA.computer_final_resource + RES_OFFSET.QUARRY
	ld	b,3
.loop:
	ld	e,(ix + 0)
	ld	d,(ix + 1)
	ld	l,(ix + 2)
	ld	h,(ix + 3)
	add	hl,de
	call	CARD_UTILS.resource_limiter_999
	ld	(ix + 2),l
	ld	(ix + 3),h
	inc	ix, ix, ix, ix
	djnz	.loop
	ret
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
new_card_id:
	call	rnd_16
	cp	MAX_CARDS
	ret	c
	jr	new_card_id
new_cursor_id:
	call	rnd_16		
	and	7
	cp	CARDS_ON_TABLE
	jr	nc,new_cursor_id
	ret
clear_card_buff:
	ld	hl,DATA.move_buff
	ld	de,DATA.move_buff + 1
	ld	bc,143
	ld	(hl),0
	ldir
	ret
;	+ Сдвиг хранилища индексов карт компьютера.
move_card_indicies:
	ld	hl,DATA.enemy_cards + 1
	ld	de,DATA.enemy_cards
	ld	bc,CARDS_ON_TABLE - 1
	ldir
	ret
fill_buff:
	ld	de,DATA.move_buff
	ld	hl,card_back_raw
	ld	a,16
	ld	ix,card_back_raw + 160
.loop:
	exa
	ld	bc,8
	ldir
	ld	a,(ix)
	ld	(de),a
	inc	de,ix
	exa
	dec	a
	jr	nz,.loop
	ret

	
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	endmodule