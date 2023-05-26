	module CARD_UTILS
;	+ Распаковка текста карты в отведенное хранилище по метке: DATA.card_text_storage
; 	+ A	-	card index
depack_card_text:
	ld	ix,DATA.card_text_storage
	call	clear_text_storage
	ld 	de,map_card_data
	call 	obj_addr_in_map		
	; HL = card data address by index
.loop:
	ld 	a,(hl)
	cp 	END_CARD_TEXT
	ret 	z			; exit by END_CARD_TEXT symbol
	push 	hl
	call	.parse
	pop 	hl
	inc 	hl
	jr 	.loop

.parse:
	sub 	TOKEN_ID
	cp 	TOKEN_NUM
	jr	c,.copy_token
	add	TOKEN_ID - 32
	cp 	96
	jr 	c,.copy_symbol
	add 	32
	;	конвертация байта в двухзначные цифры (2 байта)
	ld 	h,0
	ld	l,a
	ld 	de,DATA.tenth_storage
	call	tenth_ascii
	dec	de
	dec	de			; addres of chars
	ld 	bc,2 * 256 + ('0' + 1)
.v1:
	dec	c
	ld 	a,(de)
	inc 	de
	cp 	c
	jr 	z,.v2
	ld	(ix),a	
	inc	ix
.v2:
	djnz	.v1
	ret
.copy_symbol:
	ld	a,(hl)
	ld	(ix),a
	inc	ix
	ret

.copy_token:
	ld 	de,map_token_data
	call 	obj_addr_in_map
.ct:
	ld 	a,(hl)
	cp	END_CARD_TEXT
	ret	z
	ld	(ix),a
	inc 	ix
	inc 	hl
	jr	.ct
; 	+ Получить адрес из таблицы адресов. Требуется указать адрес начала таблицы и искомый индекс.
; 	+ A 	-	index
;	+ DE 	-	start map address
;	+ return: HL - адрес искомого (объекта)
obj_addr_in_map:
	rlca
	call 	low_addr_ret
	ld 	a,(hl)
	inc 	hl
	ld 	h,(hl)
	ld 	l,a
	ret


;	+ Отчистка хранилища текста распакованного текста.
;	+ FIXME зачем чистить если есть завершающий символ текста ?
clear_text_storage:
	ld 	hl,DATA.card_text_storage
	ld 	de,DATA.card_text_storage + 1
	ld 	bc,MAX_CARD_TEXT_LENGTH - 1
	ld 	(hl),END_CARD_TEXT
	ldir
	ret
;	+ подгоняет значение ресурса к диапазону 0-999.
;	+ HL	-	resource value;
resource_limiter_999:
	ld	a,h
	cp	#FF
	jr	z,.set_zero
	cp	high MAX_RESOURCES
	ret	c
	ld	a,l
	cp	low MAX_RESOURCES
	ret	c
	ld	hl,MAX_RESOURCES
	ret
.set_zero:
	ld	hl,0
	ret

///////////////////////////////////////////////////////////////////////////////////////////////////////
;	+ посчитать значение в С со значением в ресурсе HL
;	+ HL	-	resource address. 
;	+ C	-	value.
;	+ B 	- 	resource offset.
;	+ optional return:	HL	-	адрес измененного ресурса
calc_resource:
	ld	a,b
	cp	RES_OFFSET.QUARRY
	jr	z,.calc_res_99
	cp	RES_OFFSET.MAGIC
	jr	z,.calc_res_99
	cp	RES_OFFSET.DUNGEON
	jr	z,.calc_res_99
	xor	a
	bit	7,c
	jr	z,.positive
	cpl
.positive:
	push	bc
	ld	b,a
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ex	de,hl
	add	hl,bc
	pop	bc
	call	resource_limiter_999
	ex	de,hl
	ld	(hl),d
	dec	hl
	ld	(hl),e
	ret
;	значение в С со значением в ресурсе HL
;	диапазон значений 1-99, по этому юзаем 1 байт (младший)
;	для строений: QUARRY, MAGIC, DUNGEON
.calc_res_99:
	ld	a,(hl)
	dec	a
	add	c
	ld	(hl),a
	cp	MAX_BUILDING
	jr	c,.in_range
	jp	m,.negative
	ld	(hl),MAX_BUILDING
	ret
.negative:
	ld	(hl),MIN_BUILDING
	ret
.in_range:
	inc	(hl)
	ret
///////////////////////////////////////////////////////////////////////////////////////////////////////
;	+ A	-	card index
;	+ return:	A - card cost
;	+ optional return: HL - cost value location address
card_cost:
	ld	de,map_card_cost
	call	low_addr_ret
	ld	a,(hl)
	ret
///////////////////////////////////////////////////////////////////////////////////////////////////////
;	+ return:	A - card index
;	+ return: 	HL - address of this index
card_id_by_cursor:
	call	PLAYER.get_indices_addr
	ld	a,(DATA.cursor)
	ld	c,a
	ld	b,0
	add	hl,bc
	ld	a,(hl)	; A - card index
	; HL - addres of card index
	ret
;	+ A	-	card index.
;	+ return:	C - color
card_color_by_id:
	ld	c,COLOR_QUARRY
	cp	MAX_CARDS / 3
	ret	c
	ld	c,COLOR_MAGIC
	cp	MAX_CARDS / 3 * 2
	ret	c
	ld	c,COLOR_DUNGEON
	ret
;	+ A	-	card index.
;	+ return:	HL - raw icon address
card_icon_by_id:
	ld	hl,icons
	cp	MAX_CARDS / 3
	ret	c
	ld	hl,icons + 9
	cp	MAX_CARDS / 3 * 2
	ret	c
	ld	hl,icons + 18
	ret






///////////////////////////////////////////////////////////////////////////////////////////////////////
	endmodule