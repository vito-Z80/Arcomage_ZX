;------------------------------------------------------------------------------------------------------
;	A - char code
CHAR_FROM_FONT:	macro font_address
	rlca
	ld	h,0
	ld	l,a
	add	hl,hl
	add	hl,hl
	ld	bc,font_address - 256
	add	hl,bc
	ret
	endm
;------------------------------------------------------------------------------------------------------
;	16-bit Integer to ASCII (decimal)
ASCII_CONVERTER:	macro
	; http://map.grauw.nl/sources/external/z80bits.html#5.1
 	; Input: HL = number to convert, DE = location of ASCII string
	; Output: ASCII string at (DE)
Num2Dec	
	ld	bc,-10000
	call	Num1
thousant_ascii:
	ld	bc,-1000
	call	Num1
hundred_ascii:
	ld	bc,-100
	call	Num1
tenth_ascii:
	ld	bc,-10
	call	Num1
	ld	c,b
Num1	ld	a,'0'-1
Num2	inc	a
	add	hl,bc
	jr	c,Num2
	sbc	hl,bc
	ld	(de),a
	inc	de
	ret		
	endm
;---------------------------------------------------------------------------------------------------
;	подсчитывает длину начиная с адреса HL пока не встретиться symbol1, результат в B
LENGTH:	macro symbol1
	ld 	b,0
.loop:
	ld 	a,(hl)
	cp 	symbol1
	ret	z
	inc 	hl
	inc	b
	jr 	.loop		
	endm
;---------------------------------------------------------------------------------------------------
;	подсчитывает длину начиная с адреса HL пока не встретиться symbol1 или symbol2, результат в B
LENGTH_2:	macro symbol1, symbol2
	ld 	b,0
.loop:
	ld 	a,(hl)
	cp 	symbol1
	ret	z
	cp	symbol2
	ret	z
	inc 	hl
	inc	b
	jr 	.loop		
	endm
;---------------------------------------------------------------------------------------------------
;	ADD	HL,A
;	A	value
;	DE	start address
;	result	HL	result
LOW_ADDR:	macro
	add 	a,e
	ld 	l,a
	adc 	a,d
	sub 	l
	ld 	h,a
	endm
;---------------------------------------------------------------------------------------------------
;	A	value
;	DE	start address
;	result	HL	result
LOW_ADDR_RET:	macro
	LOW_ADDR
	ret
	endm
;	A	value
;	DE	start address
;	result	HL	memory address from indexed table. TABLE[ID]
POINTER_BY_ID:	macro
	rlca
	LOW_ADDR
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	ret
	endm
;---------------------------------------------------------------------------------------------------
FONT_4_DOUBLING:	macro font_address
	ld	hl,font_address
	ld	bc,#0300
.loop:
	ld	a,(hl)
	rrca
	rrca
	rrca
	rrca
	or	(hl)
	ld	(hl),a
	inc	hl
	dec	bc
	ld	a,b
	or	c
	jr	nz,.loop
	ret	
	endm
;---------------------------------------------------------------------------------------------------
DOWN_DE:	macro
        ; next screen line address
	inc d
        ld  a,d
        and 7
        ret nz
        ld  a,e
        add a,32
        ld  e,a
        ret c
        ld  a,d
        sub 8
        ld  d,a
        ret  		
	endm
;---------------------------------------------------------------------------------------------------
DOWN_SYMBOL:	macro
	; DE > screen address
	; current symbol address + 8 lines (vertical)
	ld a,e
	add #20
	ld e,a
	ret nc
	ld a,d
	add 8
	ld d,a
	ret		
	endm
;---------------------------------------------------------------------------------------------------
ATTR_GRID:	macro
	ld	c,%00111000
	ld	hl,#5800
.loop:
	ld	(hl),c
	inc	hl
	ld	a,c
	xor	%01000000
	ld	c,a
	ld	a,l
	and	#1F
	cp	0
	jr	nz,.more
	ld	a,c
	xor	%01000000
	ld	c,a
.more:
	ld	a,h
	cp	#5B
	ret	z
	jr	.loop
	endm
;---------------------------------------------------------------------------------------------------
; DE = screen address
; return DE = attributes address
scr_to_attr:	ifused
	ld a,d
	and #58
	rrca
	rrca
	rrca
	or #58
	ld d,a
	ret	
	endif
; DE = attributes address
; return DE = screen address
attr_to_scr:	ifused
	ld	a,d
	and	3
	rlca
	rlca
	rlca
	or	#40
	ld	d,a
	ret
	endif
;---------------------------------------------------------------------------------------------------
WAIT_DOWN_KEY:	macro
        xor a
        in a,(#fe)
        cpl
        and #1f
        jr z,$-6
	ret
	endm
WAIT_UP_KEY:	macro
        xor a
        in a,(#fe)
        cpl
        and #1f
        jr nz,$-6
	ret
	endm
;---------------------------------------------------------------------------------------------------
; + 16-bit xorshift pseudorandom number generator by John Metcalf
; + 20 bytes, 86 cycles (excluding ret)
; + 
; + returns   hl = pseudorandom number
; + corrupts   a
; + 
; + generates 16-bit pseudorandom numbers with a period of 65535
; + using the xorshift method:
; + 
; + hl ^= hl << 7
; + hl ^= hl >> 9
; + hl ^= hl << 8
; +
; + some alternative shift triplets which also perform well are:
; + 6, 7, 13; 7, 9, 13; 9, 7, 13.
rnd_16:	ifused
	push hl
	ld hl,(DATA.global_seed)       ; seed must not be 0
	ld a,h
	rra
	ld a,l
	rra
	xor h
	ld h,a
	ld a,l
	rra
	ld a,h
	rra
	xor l
	ld l,a
	xor h
	ld h,a
	ld (DATA.global_seed),hl
	pop hl
 	ret
	endif
;---------------------------------------------------------------------------------------------------
/*
	HL - multiplied (by rst-7)
*/
mul_144:	ifused
	ld c,h
	ld b,l
	srl b
	rr c
	add hl,hl
	add hl,hl
	add hl,hl
	add hl,hl
	add hl,bc
	ret
	endif

////////////////////////////////////////////////////////////////////////////////////////////////////
;	+ Вычисление координат по символам:
;	+ X (0-31)
;	+ Y (0-23)
;	+ D - Y
;	+ E - X
;	+ return: DE - screen address
symbol_position:	ifused
	ld	a,d
	and	7
	rrca
	rrca
	rrca
	add	e
	ld	e,a		
	ld	a,d
	and	%11111000
	or	#40
	ld	d,a	
	ret
	endif
////////////////////////////////////////////////////////////////////////////////////////////////////
;	+ A - color
;	+ B - width
;	+ C - height
;	+ HL - attributes address
fill_attr_rect:	ifused
	push	bc
	push	hl
.line:
	ld	(hl),a
	inc	l
	djnz	.line
	pop	hl
	ld	bc,#20
	add	hl,bc
	pop	bc
	dec	c
	ret	z
	jr	fill_attr_rect
	endif
////////////////////////////////////////////////////////////////////////////////////////////////////
;	+ B - width
;	+ C - height
;	+ HL - char for fill address
;	+ DE - screen address
fill_scr_rect:	ifused
	ld	(.line + 1),hl
.l2:
	push	bc
	push	de
.line:
	ld	hl,0
	push	bc,de
	call	RENDERING.symbol
	pop	de,bc
	inc	e
	djnz	.line
	pop	de
	call	down_symbol
	pop	bc
	dec	c
	ret	z
	jr	.l2
	endif
////////////////////////////////////////////////////////////////////////////////////////////////////
;	+ A - fill byte
clear_screen:	ifused
	ld	hl,#4000
	ld	de,#4001
	ld	bc,#1AFF
	ld	(hl),a
	ldir
	ret
	endif
////////////////////////////////////////////////////////////////////////////////////////////////////
;	+ Номер первого встречающегося выключенного бита. #FF - не юзать.
;	+ A - байт.
;	+ return: C - номер бита.
first_res_bit:	ifused
	ld	c,#FF
.loop:
	inc	c
	rrca
	ret	nc
	jr	.loop
	endif
////////////////////////////////////////////////////////////////////////////////////////////////////
;	+ Номер первого встречающегося включенного бита.
;	+ A - байт.
;	+ return: C - номер бита.
; first_set_bit:	ifused
; 	ld	c,0
; 	or	a
; 	ret	nz
; .loop:
; 	inc	c
; 	rrca
; 	ret	c
; 	jr	.loop
; 	endif
////////////////////////////////////////////////////////////////////////////////////////////////////
				ASCII_CONVERTER
grid:				ATTR_GRID
; f4d:				FONT_4_DOUBLING font4
char_from_font:			CHAR_FROM_FONT font4
get_text_length:		LENGTH END_CARD_TEXT
get_text_length_2:		LENGTH_2 ' ', END_CARD_TEXT
down_de:			DOWN_DE
down_symbol:			DOWN_SYMBOL
pointer:			POINTER_BY_ID
wait_down_key:			WAIT_DOWN_KEY
wait_up_key:			WAIT_UP_KEY
low_addr_ret:			LOW_ADDR_RET
////////////////////////////////////////////////////////////////////////////////////////////////////
;	+ @sslead
;	+ A - (0-5) cursor position
;	+ return: координата X одной из шести карт на экране.  = (4, 9, 14, 20, 25, 30)
card_x_value:
        inc 	a
        ld 	c,a
        add 	a
        add 	a
        add 	c
        cp 	#10
        sbc 	0
	ret
;	+ A - (0-5) cursor position
;	+ return DE - screen address
card_scr_by_cursor:
	call	card_x_value
	sub	3
	or	#40
	ld	e,a
	ld	d,#50
	ret
////////////////////////////////////////////////////////////////////////////////////////////////////
;	+ A - key
;	+ B - port
;	+ return: HL - char address
char_addr_from_table:
	push	af
	ld	a,b
	call	first_res_bit
	ld	a,c
	; * 5
	rlca
	rlca
	add	c
	ld	de,INPUT.chars
	call	low_addr_ret
	pop	af
	cpl
	call	first_res_bit
	ld	a,c
	ex	de,hl
	call	low_addr_ret
	ld	a,(hl)
	jp	char_from_font
////////////////////////////////////////////////////////////////////////////////////////////////////