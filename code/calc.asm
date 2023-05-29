


	module CALC

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
;	Расчет стартовых и конечных координат тайлов карты при выскакивании карты снизу экрана.
tiles_from_bottom:
	ld	d,#19			; Y
	xor	a
	ld	(DATA.symbol_counter),a
	ld	a,(DATA.cursor)		; A = (0-5)
	call	card_x_value		; A = X
	push	af			; X
	cp	#0f			; X center screen
	ld	hl,DATA.card_position_table
	call	tiles_pos.fill_coords_left
	ld	d,#12			; Y
	; ld	a,(table_x)		; X
	; ld	b,a
	pop	af		
	cp	#0F			; X center screen
	jp	tiles_pos.fill_coords_left
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
table_x:
	db	#0D
tiles_pos:
	ld	a,(table_x)		; X
	inc	a
	inc	a
	cp	#13			; final X
	ld	(table_x),a
	jr	z,.con
	jr	c,.con
	call	RENDERING.shift_on_table
.con:
	ld	hl,table_x
	ld	d,#12			; Y hands
	xor	a
	ld	(DATA.symbol_counter),a
	ld	a,(DATA.cursor)		; A = (0-5)
	call	card_x_value		; A = X
	push	af			; X
	cp	(hl)
	ld	hl,DATA.card_position_table
	call	.fill_coords_left
.min_y:
	ld	d,#0D			; Y table
	dec	d
	ld	a,d
	cp	#0A			; min Y table
	jr	z,.mo
	ld	(.min_y + 1),a
.mo:
	ld	a,(table_x)		; X
	ld	b,a
	pop	af		
	cp	b	
	ld	a,b		

.fill_coords_left:
	push	hl
	ld	hl,DATA.tiles_matrix_left
	ld	b,4
	jr	nc,.fill_coords_right
	ld	(_DISPLAY.calc_tile.mat_addr + 1),hl
	pop	hl
.n_c2:
	ld	c,4
	ld	e,a
.n_coord_1:
	ld	(hl),e		; X
	inc	hl
	ld	(hl),d		; Y
	inc	hl
	dec	e
	dec	c
	jr	nz,.n_coord_1
	inc	d
	djnz	.n_c2
	ret
.fill_coords_right:
	ld	hl,DATA.tiles_matrix_right
	ld	(_DISPLAY.calc_tile.mat_addr + 1),hl
	pop	hl
	sub	3
.n_c3:
	ld	c,4
	ld	e,a
.n_coord_2:
	ld	(hl),e		; X
	inc	hl
	ld	(hl),d		; Y
	inc	hl
	inc	e
	dec	c
	jr	nz,.n_coord_2
	inc	d
	djnz	.n_c3
	ret

	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
;	+ Адрес изображения карты по индексу.
;	+ A - card index
;	+ return: HL - card raw address
card_raw_addr:
	ld	l,a
	ld	h,0
	call	mul_144
	ld 	bc,card_raw
	add 	hl,bc
	ret

	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////

;	+ A - card index
probability:
	ld	a,(DATA.difficulty)
	ld	c,a
	ld	de,DATA.probability_comp
	ld	a,(DATA.whose_move)
	or	a



	call	low_addr_ret
	ld	a,(hl)			; probability
	sub	c
	jr	z,.can_use
	jr	nc,.cant_use
.can_use:

	ret
.cant_use:


	ret

b_sort:


	ret
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
;	+ 
;	+ Получить индекс карты с помощью таблиц вероятностей.
;	+ DE - probability map address (player or computer)
;	+ return: A - card index calculate by difficulty
new_card_id_by_diff:
	ld	de,DATA.probability_comp
	call	GAME.new_card_id
	push	af,de
	call	low_addr_ret
	pop	de,af
	dec	(hl)			; decrement probability
	jr	nz,new_card_id_by_diff
	; restore probability.
	push	hl
	ld	bc,MAX_CARDS
	add	hl,bc
	ld	c,(hl)
	pop	hl
	ld	(hl),c
	ret
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
;	+ Расчет общей вероятности выпадения карт и для обоих игроков персонально по сложности игры.
difficulty:
	ld	a,(DATA.difficulty)
	or	a
	jr	z,.hard
	rrca
	jr	c,.normal
;	+ computer - hard
;	+ player - easy
.easy:
	ld	hl,DATA.probability_player
	call	fill_easy_prob
	ld	de,DATA.probability_comp
	jr	fill_prob
;	+ computer - normal
;	+ player - normal
.normal:
	ld	hl,DATA.probability_player
	call	fill_easy_prob
	ld	de,DATA.probability_comp
	jr	fill_easy_prob
;	+ computer - easy
;	+ player - hard
.hard:
	ld	hl,DATA.probability_comp
	call	fill_easy_prob
	ld	de,DATA.probability_player
;	+ DE - probability table address
fill_prob:
	ld	hl,probability_map
	ld	bc,MAX_CARDS
	push	hl
	ldir
	pop	hl
	ld	bc,MAX_CARDS
	ldir	
	ret
;	+ HL - probability table address
fill_easy_prob:
	push	hl
	pop	de
	inc	de
	ld	(hl),1
	ld	bc,MAX_CARDS * 2 - 1
	ldir
	ret
//////////////////////////////////////////////////////////////////////////////////////////////////////////////

comp_cards_sort:
	ld de,probability_map
	exx
	ld hl,DATA.enemy_cards
	ld b,5
/*
Сортировка пузырьком.
	HL < data
	B < array size - 1
*/
cards_sort_by_dif:
	push hl
	push bc
.pass:
	ld a,(hl)
	ld e,a
	inc hl
	exx
	call low_addr_ret
	ld a,(hl)
	exx
	ld c,a
	ld a,(hl)
	exx
	call low_addr_ret
	ld a,(hl)
	exx
	cp c
	jr c,.next 	; jr c,(DESC) | jr nc,(ASC)
	; move
	ld c,(hl)
	ld (hl),e
	dec hl
	ld (hl),c
	inc hl
.next:
	djnz .pass
	pop bc
	pop hl
	djnz cards_sort_by_dif
	ret
//////////////////////////////////////////////////////////////////////////////////////////////////////////////

	endmodule