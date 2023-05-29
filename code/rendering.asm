;	+ sprite_4x4
;	+ sprite_4x5
;	+ symbol
;	+ symbol_attr
;	+ symbol_to_buff
;	+ draw_half
;	+ symbols_color
;	+ paint_frame_color
;	+ 
;	+ clear_symbol
;	+ clear_two_symbols
;	+ clear_name_space
;	+ clear_frame
;	+ 
;	+ cursor
	module RENDERING
; 	+ HL - char address.
; 	+ DE - screen address.
;	+ by symbols
sprite_4x5:
	ld	bc,.attr
	push	bc
	push	de
	ld	c,#05
	jr	sprite_4x4.l2
.attr:
	ld	b,1
	jr	sprite_4x4.attr
; 	+ HL - first sprite char address.
;	+ DE - screen address.
;	+ by symbols
sprite_4x4:
	push	de
	ld	c,#04
.l2:
	ld	b,#04
.loop:
	push	bc
	push	de
	call	symbol
	pop	de
	inc	e
	pop	bc
	djnz	.loop
	dec	e
	dec	e
	dec	e
	dec	e
	call	down_symbol
	dec	c
	jr	nz,.l2
	pop	de
	call	scr_to_attr
	ld	b,4
.attr:
	push	bc
	ldi
	ldi
	ldi
	ldi
	ld	bc,#20 - 4
	ex	de,hl
	add	hl,bc
	ex	de,hl
	pop	bc
	djnz	.attr
	ret
;	+ Draw symol with attribute after him.
;	+ HL - raw addres
;	+ DE - screen addres
symbol_attr:
	push	de
	call	symbol
	pop	de
	call	scr_to_attr
	ld	a,(hl)
	ld	(de),a
	ret
;	+ invert symbol to screen
; 	+ HL - char address
; 	+ DE - screen address
symbol_inv:
	push	de
	push	hl
	ld	bc,CHAR_HEIGHT - 1
	add	hl,bc
	ld b,CHAR_HEIGHT
.loop:
	ld a,(hl)
	ld (de),a
	inc d
	dec hl
	djnz .loop
	pop	hl
	pop	de
	ret



;	+ cpl symbol to screen
; 	+ HL - char address
; 	+ DE - screen address
symbol_cpl:
	ld b,CHAR_HEIGHT
.loop:
	ld a,(hl)
	cpl
	ld (de),a
	inc d
	inc hl
	djnz .loop
	ret
;	+ Symbol to screen
; 	+ HL - char address
; 	+ DE - screen address
symbol:
	ld b,CHAR_HEIGHT
.loop:
	ld a,(hl)
	ld (de),a
	inc d
	inc hl
	djnz .loop
	ret
;	+ Symbol to linear buffer 
; 	+ HL - buffer address
; 	+ DE - screen address
symbol_to_buff:
	ld	b,CHAR_HEIGHT
.loop:
	ld	a,(de)
	ld	(hl),a
	inc	d
	inc	hl
	djnz	.loop
	dec	d
	call	scr_to_attr
	ld	a,(de)
	ld	(hl),a
	ret
;	+ отрисовать половинку в символе, слева или справа. Зависит от нулевого бита регистра С.
;	+ C = 0: left side
;	+ C = 1: right side
;	+ HL - char address
;	+ DE - screnn address
draw_half:
	bit	0,c
	jr	nz,half_symbol_right
half_symbol_left:
	push	bc
	ld	b,CHAR_HEIGHT
.loop:
	ld	a,(hl)
	and	%11110000
	ld	c,a
	ld	a,(de)
	or	c
	ld	(de),a
	inc	d
	inc	hl
	djnz	.loop
	pop	bc
	ret
half_symbol_right:
	push	bc
	ld	b,CHAR_HEIGHT
.loop:
	ld	a,(hl)
	and	%00001111
	ld	c,a
	ld	a,(de)
	or	c
	ld	(de),a
	inc	d
	inc	hl
	djnz	.loop
	pop	bc
	ret
;	+ Обозначить особым цветом некоторые символы включая цифры.
;	+ A - char
;	+ DE - screen address
symbols_color:
	cp	'+'
	jr	z,.paint_symbol
	cp	'-'
	jr	z,.paint_symbol
	cp	'>'
	jr	z,.paint_symbol
	cp	'<'
	jr	z,.paint_symbol
	cp	'='
	jr	z,.paint_symbol
	cp	'0'
	ret	c
	cp	'9' + 1
	ret	nc
.paint_symbol:
	push 	de
	call 	scr_to_attr
	ld	a,TEXT_FRAME_DIGIT_COLOR
	ld	(de),a
	pop	de
	ret
;	+ paint text frame area
paint_frame_color:
	ld	hl,TEXT_FRAME_ATTR_ADDR
	ld	de,#20 - TEXT_FRAME_WIDTH
	ld	b,TEXT_FRAME_HEIGHT
	ld	a,TEXT_FRAME_TEXT_COLOR
.loop:
	ld	c,TEXT_FRAME_WIDTH
.line:
	ld	(hl),a
	inc	l
	dec	c
	jr	nz,.line
	add	hl,de
	djnz	.loop
	ret
;	+ clear text frame area
clear_frame:
	ld	de,TEXT_FRAME_SCR_ADDR
	ld	b,TEXT_FRAME_HEIGHT * 8
	ld	l,TEXT_FRAME_WIDTH
.loop:
	xor	a
	ld	c,l
	push	de
.line:
	ld	(de),a
	inc	e
	dec	c
	jr	nz,.line
	pop	de
	call	down_de
	djnz	.loop
	ret
;	+ отчистка места для отображения названия карты
clear_name_space:
	ld	de,TEXT_NAME_SCR_ADDR
	ld	b,8
	ld	l,TEXT_FRAME_WIDTH + 2		; отображение имени происходит над текстом карты и занимает на символ больше с каждой стороны.
	jr	clear_frame.loop
;	+ Отчистить 2 символа подряд.
;	+ DE	-	screen address
;	+ optional return: DE++
clear_two_symbols:			
	call	clear_symbol
	inc	e
;	+ Отчистить 1 символа.
;	+ DE	-	screen address
;	+ optional return: DE == DE (ну типа сохраняется DE)
clear_symbol:				
	xor	a
fill_symbol:				
	push de
	dup 7
	ld	(de),a
	inc	d
	edup
	ld	(de),a
	pop	de
	ret
clear_4_symb:
	ld	b,4
.loop:
	call	clear_symbol
	inc	e
	djnz	.loop
	ret
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
;	+ рендер буквы "D".
;	+ DE - screen address
D_letter:
	ld	hl,#3C00 + 'D' * 8
	call	symbol
	dec	d
	call	scr_to_attr
	ld	a,COLOR_WARNING
	ld	(de),a
	ret
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
;	+ Сдвиг карт на столе.
shift_on_table:

	ld	a,#13
	ld	(CALC.table_x),a

	ld	hl,#484E
	ld	de,#484C
	push	de
	push	hl
	ld	b,8
.lines_8:
	push	bc
	push	de
	push	hl
	ld	bc,32-6
	call	copy_mem_5
	pop	de
	call	down_de
	ex	de,hl
	pop	de
	call	down_de
	pop	bc
	djnz	.lines_8
	pop	de
	call	scr_to_attr
	ex	de,hl
	pop	de
	call	scr_to_attr
	ld	bc,32-6
	call	copy_mem_5
	; shift down on symbol
	ld	hl,#48CC
	ld	de,#48EC
	ld	b,8
.lin_2:
	push	bc,de,hl
	ld	bc,-38
	call	copy_mem_5

	pop	hl,de,bc
	inc	d
	inc	h
	djnz	.lin_2
	
	
	ld	hl,#59CC
	ld	de,#59EC
	ld	bc,-38
	call	copy_mem_5

	; fill black color

	ld	hl,#5972
	ld	de,31
	ld	b,3
	xor	a
.att:
	ld	(hl),a
	inc	l
	ld	(hl),a
	add	hl,de
	djnz	.att
	ld	hl,#594C
	ld	b,8
.n_attr:
	ld	(hl),a
	inc	l
	djnz	.n_attr
	ld	hl,#596C
	ld	(hl),a
	inc	l
	ld	(hl),a
	ret


copy_mem_5:
	ld	a,5
.loop:
	push	bc
	dup	6
	ldi
	edup
	pop	bc
	; ld	bc,-38
	add	hl,bc
	ex	de,hl
	add	hl,bc
	ex	de,hl
	dec	a
	ret	z
	jr	.loop
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
;	+ DE - screen address
; 	+ B - length
paint_line:
	push	bc
	call	scr_to_attr
	push	de
	call 	CARD_UTILS.card_id_by_cursor
	call	CARD_UTILS.card_color_by_id
	ld	a,c
	pop	hl,bc
.loop:
	ld	(hl),a
	inc	l
	djnz	.loop
	ret
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
;	+ HL - screen address
;	+ B - line length
fill_line:
	ld	a,#FF
	ld	(hl),a
	inc	l
	djnz	fill_line + 2
	ret
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
fp_color:
	db	7
;	+ Подсвечивает атрибутыми ходящего.
flash_player:
	ld	a,(fp_color)
.fp:
	inc	a
	and	7
	jr	z,.fp
	ld	(fp_color),a
	ld	hl,#59E0
	call	.line
	ld	hl,#59FC
.line:
	ld	(hl),a
	inc	l
	ld	(hl),a
	inc	l
	ld	(hl),a
	inc	l
	ld	(hl),a
	ret


	endmodule
