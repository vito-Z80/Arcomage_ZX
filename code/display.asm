;	+ card_name
;	+ card_text
;	+ 
;	+ resource_icons
;	+ 
;	+ player_cards
;	+ card_frame
;	+ card_sprite
;	+ under_card_line
;	+ 
;	+ cursor
;	+ 
;	+ alignment_resources
;	+ 
;	+ discard_icon
;	+ player_discard
	module _DISPLAY


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
;	Отображение названия карты по индексу типа align right.;  
;	A 	card index
card_name:
	ld	de,map_name_data		; Таблица адресов на имена 
	call	pointer				; HL - корректный адрес текста имени карты.
	push	hl
	call	get_text_length			; B - длина текста имени карты.
	pop	hl
	ld	a,b
	and	%00000001
	ld	c,a				; в 'C' определено в какую часть символа отрисовывать букву.
						; так же 'C' определен как остаток от деления 'B' на 2
	ld	d,high TEXT_NAME_SCR_ADDR	; старший байт адреса отрисовки.
	ld	a,low TEXT_NAME_SCR_ADDR + (TEXT_FRAME_WIDTH + 2)	; младший байт будущего адреса отрисовки на экране, с конца.
	srl	b				; длина текста деленное на 2 (символов для печати в 2 раза меньше чем букв 
						; так как в 1 символ помещается 2 бкувы). Получаем длину символов под отрисовку.
	sub	b				; вычитаем длину символов под отрисовку из младшего байта будущего адреса отрисовки.
	sub 	c				; вычитаем остаток от деления 'B' из младшего байта будущего адреса экрана
						; это определеит с какой стороны символа печатать первую букву.
	ld	e,a				; корректный адрес отрисовки имени карты готов. 
	jr	card_text.loop



///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
;	Отображает на экране текст карты учитывая переходы на новую строку, подкраску цифр и некоторых знаков.
;	Для отображения требуется заранее сформированный текст в специальный буфер DATA.card_text_storage.
card_text:
	ld	de,TEXT_FRAME_SCR_ADDR
	ld 	hl,DATA.card_text_storage
	ld	c,0	; счетчик букв в строке. Нулевой бит С определяет с какой стороны символа рисовать букву: 0 - слева, 1 - справа 
.loop:
	ld 	a,(hl)
	cp	END_CARD_TEXT
	ret	z	; тест закончен
	
	push 	hl,de,bc,af
	push	bc
	call	char_from_font
	pop	bc
	call	RENDERING.draw_half
	pop	af,bc,de,hl
	push	af
	call 	RENDERING.symbols_color
	pop	af
	inc	hl
	call	check_down
	bit	0,c
	jr	z,.no_inc_e
	;	после отрисовки обоих букв в символе переходим к следующему символу.
	inc	e
.no_inc_e:
	inc	c
	jr	.loop

;	перейти на следующую строку в начало, при условии что следующее слово выходит за рамку отображения.
check_down:
	if	NEW_LINE_BY_DOT
	cp	'.'
	jr	z,.new_line
	endif
	cp	' '
	ret	nz
	push	hl
	call	get_text_length_2		; получаем в B длину слова до первого пробела
	ld	a,b
	add	c
	cp	TEXT_FRAME_WIDTH * 2
	pop	hl
	ret	c	;	текст входит в границы
	;	опустить на символ ниже в начало строки
.new_line:
	ld 	a,e
	and	%11100000
	add	(low TEXT_FRAME_SCR_ADDR and #1f)
	ld	e,a
	call	down_symbol
	ld	c,0
	pop	af		; убрать из стека возврат по call
	jr	card_text.loop
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/*
	Пример использования отображения двузначных и трехзначных чисел с впереди стоящими нулями.

	В трехзначной процедуре можно отобразить двузначное значение, во всех можно отобразить однозначное.
	Трехзначная процедура может быть выполнена для отображения любых значений до трех цифр. (но отрисует она всегда 3 цифры)

	ld	de,#4000				; адресс экрана куда отображать
	call	RENDERING.clear_symbol			; отчистить символ перед отображением
	ld	c,0					; 0 - первая отображаямая цифра в левой часте символа, 1 - в правой
	ld	hl,73					; двухзначное значение которое нужно отобразить
	call	_DISPLAY.two_digit_number		; процедура отображения двухзначных чисел

	ld	de,$4021				; адресс экрана куда отображать
	call	RENDERING.clear_two_symbols		; отчистить ДВА символа перед отображением
	dec	e					; скорректировать адрес отображения (после отчистки 2-х символов адрес экрана смещен на 1)
	ld	c,1					; 0 - первая отображаямая цифра в левой часте символа, 1 - в правой
	ld	hl,823					; трехзначное заачение которое нужно отобразить
	call	_DISPLAY.three_digit_number
*/

;	+ diaply two digits for 4 bit font
;	+ C	0 - start from left char; 1 - start from right char; 
;	+ DE	screen address; 
;	+ HL	value; 
two_digit_number:
	push	bc
	push	de
	ld	de,DATA.tenth_storage
	push	de
	call	tenth_ascii
.more:
	pop	hl
	pop	de
	pop	bc
.loop:
	ld	a,(hl)
	cp	END_CARD_TEXT
	ret	z
	push	de,hl,bc
	call	char_from_font
	pop	bc
	call	RENDERING.draw_half
	pop	hl
	inc 	hl
	pop	de
	inc	c
	bit	0,c
	jr	nz,.stay_here
	inc	e
.stay_here:
	jr	.loop
;	+ diaply three digits for 4 bit font
;	+ C	0 - start from left char; 1 - start from right char; 
;	+ DE	screen address; 
;	+ HL	value; 
three_digit_number:
	push	bc
	push	de
	ld	de,DATA.hundred_storage
	push	de
	call	hundred_ascii
	jr	two_digit_number.more
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
resource_icons:
	ld	hl,icons	; first icon address
	push	hl
	ld	de,P_VAL_QUARRY_SCR_ADDR + 1
	call	RENDERING.symbol_cpl
	inc	hl
	ld	de,P_VAL_MAGIC_SCR_ADDR + 1
	call	RENDERING.symbol_cpl
	inc	hl
	ld	de,P_VAL_DUNGEON_SCR_ADDR + 1
	call	RENDERING.symbol_cpl
	pop	hl		; first icon address
	ld	de,E_VAL_QUARRY_SCR_ADDR - 1
	call	RENDERING.symbol_cpl
	inc	hl
	ld	de,E_VAL_MAGIC_SCR_ADDR - 1
	call	RENDERING.symbol_cpl
	inc	hl
	ld	de,E_VAL_DUNGEON_SCR_ADDR - 1
	call	RENDERING.symbol_cpl
	inc	hl
	push	hl
	ld	de,P_ICON_QUARRY_SCR_ADDR
	ld	c,COLOR_QUARRY
	call	.big_icon_bottom
	ld	de,P_ICON_MAGIC_SCR_ADDR
	ld	c,COLOR_MAGIC
	call	.big_icon_bottom
	ld	de,P_ICON_DUNGEON_SCR_ADDR
	ld	c,COLOR_DUNGEON
	call	.big_icon_bottom
	pop	hl
	ld	de,E_ICON_QUARRY_SCR_ADDR
	ld	c,COLOR_QUARRY
	call	.big_icon_bottom
	ld	de,E_ICON_MAGIC_SCR_ADDR
	ld	c,COLOR_MAGIC
	call	.big_icon_bottom
	ld	de,E_ICON_DUNGEON_SCR_ADDR
	ld	c,COLOR_DUNGEON
.big_icon_bottom:
	push	bc
	call	RENDERING.sprite_4x4
	pop	bc
	ld	a,c
	ld	(de),a
	inc	e
	ld	(de),a
	inc	e
	ld	(de),a
	inc	e
	ld	(de),a
	ret
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; 		player resources

p_wall:
	ld	de,P_VAL_WALL_SCR_ADDR
	call	RENDERING.clear_two_symbols
	dec	e
	ld	hl,(DATA.player_resources + RES_OFFSET.WALL)
	ld	c,0
	jp	three_digit_number
p_tower:
	ld	de,P_VAL_TOWER_SCR_ADDR
	call	RENDERING.clear_two_symbols
	dec	e
	ld	hl,(DATA.player_resources + RES_OFFSET.TOWER)
	ld	c,0
	jp	three_digit_number
p_res_quarry:
	ld	de,P_VAL_QUARRY_SCR_ADDR
	call	RENDERING.clear_symbol
	ld	hl,(DATA.player_resources + RES_OFFSET.QUARRY)
	ld	c,0
	jp	two_digit_number
p_res_bricks:
	ld	de,P_VAL_BRICKS_SCR_ADDR
	call	RENDERING.clear_two_symbols
	dec	e
	ld	hl,(DATA.player_resources + RES_OFFSET.BRICKS)
	ld	c,1
	jp	three_digit_number
p_res_magic:
	ld	de,P_VAL_MAGIC_SCR_ADDR
	call	RENDERING.clear_symbol
	ld	hl,(DATA.player_resources + RES_OFFSET.MAGIC)
	ld	c,0
	jp	two_digit_number
p_res_gems:
	ld	de,P_VAL_GEMS_SCR_ADDR
	call	RENDERING.clear_two_symbols
	dec	e
	ld	hl,(DATA.player_resources + RES_OFFSET.GEMS)
	ld	c,1
	jp	three_digit_number
p_res_dungeon:
	ld	de,P_VAL_DUNGEON_SCR_ADDR
	call	RENDERING.clear_symbol
	ld	hl,(DATA.player_resources + RES_OFFSET.DUNGEON)
	ld	c,0
	jp	two_digit_number
p_res_recruits:
	ld	de,P_VAL_RECRUITS_SCR_ADDR
	call	RENDERING.clear_two_symbols
	dec	e
	ld	hl,(DATA.player_resources + RES_OFFSET.RECRUITS)
	ld	c,1
	jp	three_digit_number

;		enemy resources
e_wall:
	ld	de,E_VAL_WALL_SCR_ADDR
	call	RENDERING.clear_two_symbols
	dec	e
	ld	hl,(DATA.computer_resources + RES_OFFSET.WALL)
	ld	c,1
	jp	three_digit_number
e_tower:
	ld	de,E_VAL_TOWER_SCR_ADDR
	call	RENDERING.clear_two_symbols
	dec	e
	ld	hl,(DATA.computer_resources + RES_OFFSET.TOWER)
	ld	c,1
	jp	three_digit_number
e_res_quarry:
	ld	de,E_VAL_QUARRY_SCR_ADDR
	call	RENDERING.clear_symbol
	ld	hl,(DATA.computer_resources + RES_OFFSET.QUARRY)
	ld	c,0
	jp	two_digit_number
e_res_bricks:
	ld	de,E_VAL_BRICKS_SCR_ADDR
	call	RENDERING.clear_two_symbols
	dec	e
	ld	hl,(DATA.computer_resources + RES_OFFSET.BRICKS)
	ld	c,0
	jp	three_digit_number
e_res_magic:
	ld	de,E_VAL_MAGIC_SCR_ADDR
	call	RENDERING.clear_symbol
	ld	hl,(DATA.computer_resources + RES_OFFSET.MAGIC)
	ld	c,0
	jp	two_digit_number
e_res_gems:
	ld	de,E_VAL_GEMS_SCR_ADDR
	call	RENDERING.clear_two_symbols
	dec	e
	ld	hl,(DATA.computer_resources + RES_OFFSET.GEMS)
	ld	c,0
	jp	three_digit_number
e_res_dungeon:
	ld	de,E_VAL_DUNGEON_SCR_ADDR
	call	RENDERING.clear_symbol
	ld	hl,(DATA.computer_resources + RES_OFFSET.DUNGEON)
	ld	c,0
	jp	two_digit_number
e_res_recruits:
	ld	de,E_VAL_RECRUITS_SCR_ADDR
	call	RENDERING.clear_two_symbols
	dec	e
	ld	hl,(DATA.computer_resources + RES_OFFSET.RECRUITS)
	ld	c,0
	jp	three_digit_number


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
;	отчистка и отрисовка рамки для карты текста + сам тест и название карты
card_frame:
	call	RENDERING.clear_frame
	call	RENDERING.clear_name_space
	ld	de,TEXT_NAME_SCR_ADDR
	ld	b,TEXT_FRAME_WIDTH + 2
	call	RENDERING.paint_line
	ld	b,TEXT_FRAME_WIDTH + 2
	ld	de,#482B
	call	RENDERING.paint_line
	ld	hl,#4F2B
	ld	b,TEXT_FRAME_WIDTH + 2
	call	RENDERING.fill_line

	call 	RENDERING.paint_frame_color
	call 	CARD_UTILS.card_id_by_cursor
	push	af
	call 	CARD_UTILS.depack_card_text
	pop	af
	call	_DISPLAY.card_name
	jp	_DISPLAY.card_text
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

;	A	-	card index
card_sprite:
	push	af
	;	расчитать адрес изображения карты.
	ld	l,a
	ld	h,0
	call	mul_144
	ld 	bc,card_raw
	add 	hl,bc
	;	расчитать адрес экрана для отображения карты исходя из расположения курсора.
	ld	a,(DATA.cursor)
	call	card_scr_by_cursor
	call	RENDERING.sprite_4x4
	pop	af
	jr	under_card_line

;	отобразить задник карты.
card_back:
	
	;	TODO

	ret


;	A	-	card index
player_cards:
	push	af
	call	_DISPLAY.card_frame
	pop	af
	ld	hl,DATA.player_cards
	ld	b,CARDS_ON_TABLE
.loop:
	ld	a,6
	sub	b
	call	card_scr_by_cursor	; DE - screen index
	push	hl,bc
	ld	a,(hl)		; card index
	push	af
	call	CALC.card_raw_addr
	ld	a,(DATA.whose_move)
	or	a
	jr	z,.show_card
	;	hide card - show back
	ld	hl,card_back_raw
	call	RENDERING.sprite_4x4
	jr	.sd
.show_card:
	call	RENDERING.sprite_4x4
.sd:
	pop	af
	;	A - card index
	;	DE - attributes addr
	call	under_card_line


	pop	bc,hl
	inc	hl
	djnz	.loop
	ret
;	+ место под картой для отображения цены карты и ее пренадлежности.
;	+ A - card index
;	+ DE - attributes addr (адрес крайнего левого арибута под картой)
under_card_line:
	push	af
	ld	(.ukl + 1),a
	call	CARD_UTILS.card_color_by_id
	; paint
	ld	a,c				;	card color
	ld	(de),a
	inc	e
	ld	(de),a
	inc	e
	ld	(de),a
	inc	e
	ld	(de),a
	dec	e
	dec	e
	dec	e
	call	attr_to_scr
	push	de
	ld	(.line_addr + 1),de
	; clear area
	call	RENDERING.clear_4_symb
	pop	de
	pop	af
	push	de
	; icon
	call	CARD_UTILS.card_icon_by_id
	call	RENDERING.symbol_cpl
.ukl:
	ld	a,0				; A - card index
	call	CARD_UTILS.card_cost
	pop	de
	inc	e
	inc	e
	inc	e
	ld	l,a
	ld	h,0
	ld	c,h
	; cost
	call	two_digit_number
.line_addr:
	ld	hl,0
	ld	b,4
	call	RENDERING.fill_line
	ret
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
discard_word:
	db	"DISCARD!", 0
;	+ Отобразить слово DISCARD! поверх сбрасываемой карты.
discard_mess_on_card:
	ld	a,(DATA.cursor)
	call	card_scr_by_cursor
	ex	de,hl
	ld	bc,64
	add	hl,bc
	ex	de,hl
	push	de,de
	; clear text area
	ld	b,4
.loop:
	push	bc
	call	RENDERING.clear_symbol
	pop	bc
	inc	e
	djnz	.loop
	pop	de
	call	scr_to_attr
	; paint color white on red
	ld	a,COLOR_WARNING
	ld	b,4
.l2:
	ld	(de),a
	inc	de
	djnz	.l2
	pop	de
	ld	hl,TEXT.discard_word
	jr	move_message.loop - 2
; discard_icon_comp:
; 	ld	a,(PLAYER.deceptive_cursor_cur)
; 	jr	discard_icon + 3
;	+ Отображение буквы "D" на карте - обозначение сброшенной карты.
discard_icon:
	ld	a,(DATA.cursor)
	ld	hl,DATA.card_position_table
	cp	#03
	jr	nc,.normal
	; если дальше половины экрана то Х координаты с другой стороны.
	ld	bc,6
	add	hl,bc
.normal:
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	call	symbol_position
	call	RENDERING.D_letter
	ret

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
pl_addr:	equ	#48E0
en_addr:	equ	#48FD


cls:
	ld	b,3
.n_s:
	ld	hl,font4
	push	bc
	push	de
	call	RENDERING.symbol
	pop	de
	inc e
	pop	bc
	djnz	.n_s
	ret	

move_message:

	ld	de,pl_addr
	call	cls
	ld	de,en_addr
	call	cls
	
	ld	hl,TEXT.pl_mess
	ld	de,pl_addr
	ld	a,(DATA.whose_move)
	or	a
	call	nz,.en


	ld	c,0
.loop:
	ld 	a,(hl)
	or	a
	ret	z	
	
	push 	hl,de,bc
	push	bc
	call	char_from_font
	pop	bc
	call	RENDERING.draw_half
	pop	bc
	pop	de
	pop	hl
	inc	c
	bit	0,c
	jr	nz,.l2
	inc	e
.l2:
	inc	hl
	jr	.loop
	
.en:
	ld	hl,TEXT.en_mess
	ld	de,en_addr
	ret	

///////////////////////////////////////////////////////////////////////////////////////////////////////
comp_cards:

	xor	a
.loop:
	push	af
	call	card_scr_by_cursor
	ld	hl,card_back_raw
	push	de
	call	RENDERING.sprite_4x4
	pop	hl
	ld	bc,128
	add	hl,bc
	ex	de,hl
	ld	b,4
.footer:
	push	bc,de
	ld	hl,card_footer
	call	RENDERING.symbol_attr
	pop	de,bc
	inc	e
	djnz	.footer
	
	pop	af
	inc	a
	cp	CARDS_ON_TABLE
	ret	nc
	jr	.loop
///////////////////////////////////////////////////////////////////////////////////////////////////////
;	+ Отображение выровненных ресурсов.
;	+ TODO - отобразить арибуты для выравниваемых ресурсов. Красный и зеленый на уменьшение и увеличение ресурсов соответственно.
;	+ Значения из одного хранилища сравниваются с другим. Как для игрока так и для компьютера.
;	+ Процедура должна выравнивать значения реусурсов и отображать их. Каждый кадр вычесление и отрисовка только для одного ресурса.
;	+ Выровненные ресурсы не отображаются после выравнивания.
;	+ Если все ресурсы выровненны, 16 раз делаются проверки на невыровненные ресурсы. 3250 тактов.
alignment_resources:
	xor	a
	ld	(GAME.is_res_alignment),a
.rot:
	ld	a,#FE
	add	2
	cp	#20
	jr	nz,.not_limit
	;	все возможные ресурсы выровнены.
	ld	a,#FE
	ld	(.rot + 1),a
	ret
.not_limit:
	ld	(.rot + 1),a
	ld	de,DATA.player_resources
	call	low_addr_ret
	ld	(.display_resource + 2),hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)		; DE - адрес ресурса с текущим значением
	ld	bc,RES_OFFSET * 2 - 1
	add	hl,bc		; reset flag C for "sbc	hl,de"
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a		; HL - адрес ресурса с конечным значением
	sbc	hl,de
	jr	z,alignment_resources	; текущий ресурс выровнен, получить следующий
	jr	c,.minus
.plus:
	inc	de
	jr	.display_resource
.minus:
	dec	de
.display_resource:
	ld	(0),de
	ld	a,(.rot + 1)
	ld	de,DATA.res_display_seq
	call	CARD_UTILS.obj_addr_in_map + 1
	jp	(hl)			; jump to display resource address


	ld	a,(de)
	sub	(hl)
	ld	c,a
	dec	de,hl
	ld	a,(de)
	cp	(hl)
	ret	z
	jr	c,.to_up
.to_down:

.to_up:
	adc	c
	ld	(de),a
	ret	c
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
;	Перемещение тайлов карты из точки А в точку В.
move_tiles_sym_seq:
	xor	a
	ld	(GAME.phase_card_from_bottom),a
	call	CARD_UTILS.card_id_by_cursor
	ld	c,a		; card index
	ld	ix,DATA.card_position_table
	ld	iy,DATA.card_end_position_table
	ld	a,(DATA.symbol_counter)
	inc	a
	cp	16
	ld	b,a
	jr	nc,.loop
	ld	(DATA.symbol_counter),a
.loop:
	push	af
	ld	e,a
	ld	a,b
	sub	e
	push	bc
	ld	b,a		; индекс матрицы тайлов
	ld	e,(ix)		; start X 
	ld	d,(ix + 1)	; start Y
	ld	l,(iy)		; end X
	ld	h,(iy + 1)	; end Y
	push	hl
	or	a
	sbc	hl,de
	pop	hl
	call	nz,calc_tile
	inc	ix
	inc	ix
	inc	iy
	inc	iy
	pop	bc
	pop	af
	dec	a
	ret	z
	jr	.loop
set_pos:
	; jr	$
	ld	(GAME.phase_card_from_bottom),a		; A != 0
	call	calc_tile.calc_new_position	; DE - адрес экрана новой позиции.
	ld	(calc_tile.scr_addr + 1),de
	ret
;	+ C - card index
;	+ B - tile matrix index
;	+ DE - card position table
;	+ HL - card end position table
calc_tile:
	ld	a,c
	ld	(.card_id + 1),a
	ld	a,d
	cp	#19		; Y 
	jr	nc,set_pos
	ld	(GAME.phase_card_from_bottom),a		; A != 0
	call	.from_buff_to_scr	; отобразить тайл из буфера на экран на текущую позицию.
	call	.calc_new_position	; DE - адрес экрана новой позиции.
	ld	(.scr_addr + 1),de
.buff_addr:
	ld	hl,0
	call	RENDERING.symbol_to_buff	; сохранить в буфер тайл с экрана на новой позиции
.card_id:
	ld	a,0		; card index
	call	CALC.card_raw_addr
	push	hl
.card_tile_index:
	ld	a,0
	rlca
	rlca
	rlca
	ld	c,a
	ld	b,0		; BC - offset of tile in card image
	add	hl,bc
.scr_addr:
	ld	de,0		; адрес экрана новой позиции.
	call	RENDERING.symbol
	dec	d
	call	scr_to_attr
	pop	hl		; адрес изображения карты.
	ld	a,128
.attr_offset:
	add	0
	ld	b,0
	ld	c,a
	add	hl,bc
	ld	a,(hl)
	ld	(de),a
	ret
;	Выравнивание координат от стартовых к конечным и получение адреса экрана по данным координатам.
.calc_new_position:
	ld	a,d
	cp	h
	jr	z,.set_x
	jr	nc,.minus_1
	inc	d
	jr	.set_x
.minus_1:
	dec	d
.set_x:
	ld	(ix+1),d
	ld	a,e
	sub	l
	jp	z,symbol_position
	jr	nc,.minus_2
	inc	e
	ld	(ix),e
	jp	symbol_position
.minus_2:
	dec	e
	ld	(ix),e
	jp	symbol_position

;	Из буфера на экран.
;	+ DE - Y,X -coordinates
;	+ B - индекс матрицы тайлов.
.from_buff_to_scr:
	push	hl,de,bc
	call	symbol_position
	push	de		; адрес экрана
	ld	a,b		; индекс матрицы тайлов
.mat_addr:
	ld	de,DATA.tiles_matrix_left
	call	low_addr_ret
	ld	a,(hl)		; индекс тайла карты
	ld	(.attr_offset + 1),a
	ld	(.card_tile_index + 1),a
	ld	c,a		; card tile index
	rlca
	rlca
	rlca
	add	c
	ld	c,a
	ld	b,0
	ld	hl,DATA.move_buff
	add	hl,bc		; address of tile in buffer
	ld	(calc_tile.buff_addr + 1), hl
	pop	de
	ld	a,d
	cp	#58
	jr	nc,.fin_	; no draw if DE in attributes address or more
	
	call	RENDERING.symbol
	dec	d
	call	scr_to_attr
	ld	a,(hl)
	ld	(de),a
.fin_
	pop	bc,de,hl
	ret
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
;	+ left-angle, right-angle
;	+ center, left, right
FONT:	equ	#3C00
cursor_tiles_table:
	dw	frame_top_left, frame_top_right, frame_top, frame_left, frame_right
cursor:
	ld	a,(DATA.cursor)
	ld	ix,cursor_tiles_table
	call	card_scr_by_cursor	; DE - screen address
	push	de
	ld	a,e
	sub	33
	ld	e,a
	call	paint_cursor
	pop	de
	
	ld	a,e
	sub	33
	ld	e,a
	ld	b,2
	push	de
	push	de
.angles:
	push	de
	push	bc
	ld	l,(ix)
	ld	h,(ix + 1)
	push	de, hl
	call	RENDERING.symbol
	pop	hl, de
	ld	a,e
	add	224 - 32
	ld	e,a
	call	RENDERING.symbol_inv
	pop	bc
	pop	de
	inc	ix
	inc	ix
	ld	a,e
	add	5
	ld	e,a
	djnz	.angles
	pop	de
	inc	e
	ld	l,(ix)
	ld	h,(ix + 1)
	ld	b,4
.sym_1:
	push	bc,de,hl
	call	RENDERING.symbol
	pop	hl,de,bc
	inc	e
	djnz	.sym_1

	ld	a,e
	add	224 - 33
	ld	e,a
	ld	b,4
.sym_2:
	push	bc,de,hl
	call	RENDERING.symbol_inv
	pop	hl,de,bc
	dec	e
	djnz	.sym_2

	pop	de
	inc	ix
	inc	ix
	ld	l,(ix)
	ld	h,(ix + 1)
	ld	b,5
	push	de
.l_vert:
	ld	a,e
	add	32
	ld	e,a
	push	de,hl,bc
	call	RENDERING.symbol
	pop	bc,hl,de
	djnz	.l_vert


	inc	ix
	inc	ix
	ld	l,(ix)
	ld	h,(ix + 1)
	pop	de
	ld	a,e
	add	5
	ld	e,a
	ld	b,5
.r_vert:
	ld	a,e
	add	32
	ld	e,a
	push	de,hl,bc
	call	RENDERING.symbol
	pop	bc,hl,de
	djnz	.r_vert
	ret
;	+ DE - screen address
paint_cursor:
	push	de
	call	CARD_UTILS.card_id_by_cursor
	call	CARD_UTILS.card_color_by_id
	ld	a,c
	rrca
	rrca
	rrca
	and	7
	or	#40
	ld	c,a
	pop	de
.blck:
	; ld	a,c
	call	scr_to_attr
	ex	de,hl
	call	.attr_hor_line
	ld	de,31
	add	hl,de
	call	.attr_vert_line
	ld	de,-5
	add	hl,de
	call	.attr_hor_line
	ld	de,-160 - 6
	add	hl,de
.attr_vert_line:
	ld	b,5
	ld	de,32
.l2:
	ld	(hl),c
	add	hl,de
	djnz	.l2
	ret
.attr_hor_line:
	ld	b,6
.l1:
	ld	(hl),c
	inc	hl
	djnz	.l1
	ret
clear_cursor:
	ld	a,(DATA.pre_cursor)
	call	card_scr_by_cursor
	ld	a,e
	sub	33
	ld	e,a
	ld	c,0
	jr	paint_cursor.blck
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
;	+ print text
;	+ HL - text address
;	+ DE - screen address
text:
	ld	a,1
	ld	(.half + 1),a
.loop:
	ld	a,(hl)			; char
	cp	END_CARD_TEXT
	ret	z			; end of message
	push	hl
	call	char_from_font		; HL - char address
	push	de
.half:
	ld	c,0
	push	bc
	call	RENDERING.draw_half
	pop	bc
	ld	a,1
	xor	c
	ld	(.half + 1),a
	pop	de
	jr	nz,.no_shift
	inc	e
.no_shift:
	pop	hl
	inc	hl
	jr	.loop
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////






mess_id:		db	#FF
mess_pre_id:		db	#FF
mess_char_addr:		dw	0
mess_scr_addr:		dw	0
mess_timer:		dw	0
;	+ Отобразить информационный текст по одной букве отцентрированный по горизонтали.
;	+ Текст начнет печататься при смене mess_id - индекс информационного сообщения.
info_text:
	ld	hl,mess_id
	ld	a,(hl)			; mess_id
	ld	b,a
	inc	hl
	cp	(hl)			; mess_pre_id
	jr	z,.disp_next_letter
	; new calculate
	ld	(hl),a
	ld	de,TEXT.map
	call	CARD_UTILS.obj_addr_in_map
	ld	(mess_char_addr),hl
	call	get_text_length		; B - text length
	ld	a,b
	rrca
	rrca
	and	#1F
	; sub	-#1f
	ld	c,a
	ld	a,#10
	sub	c
	ld	l,a
	ld	h,#40
	ld	a,c
	and	1
	jr	z,.fin
	dec	l
.fin:
	ld	(.half + 1),a
	ld	(mess_scr_addr),hl
	jr	clear_info

.disp_next_letter:
	ld	hl,(mess_char_addr)
	ld	a,(hl)			; char
	cp	END_CARD_TEXT
	ret	z			; end of message
	push	hl
	call	char_from_font		; HL - char address
	ld	de,(mess_scr_addr)
	push	de
.half:
	ld	c,0
	push	bc
	call	RENDERING.draw_half
	pop	bc
	ld	a,1
	xor	c
	ld	(.half + 1),a
	pop	de
	jr	nz,.no_shift
	inc	e
.no_shift:
	ld	(mess_scr_addr),de
	pop	hl
	inc	hl
	ld	(mess_char_addr),hl
	ld	a,(hl)
	cp	END_CARD_TEXT
	ret	nz
.set_timer:
	ld	a,60* -2		; time
	ld	(mess_timer),a
	ret
in_at_color:
	db	COLOR_DUNGEON
	db	COLOR_MAGIC
	db	COLOR_QUARRY
	db	%01000111
	db	0
info_attr:
	ld	hl,info_attr - 1
	ld	a,(hl)
	or	a
	ret	z
	inc	hl
	ld	(info_attr + 1),hl
.paint:
	ld	de,#5804
	ld	b,24
.loop:
	ld	(de),a
	inc	e
	djnz	.loop
	ret
;	+ A - message index.
launch_info:
	ld	(_DISPLAY.mess_id),a
	ld	a,(#FF)
	ld	(_DISPLAY.mess_pre_id),a
launch_info_attr:
	ld	hl,in_at_color
	ld	(info_attr + 1),hl
	ret
clear_info:
	ld	hl,#4104
	ld	de,#4105
	ld	a,7
.l2:
	push	hl,de
	ld	bc,23 * 256 + 255
	ld	(hl),0
.loop:
	ldi
	djnz	.loop
	pop	de,hl
	inc	d
	inc	h
	dec	a
	ret	z
	jr	.l2
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
tower_wall:
	ld	hl,tower_wall
	pp_xy_de_scr 5,13
	ld	b,16
	push	bc
	push	de
.loop:
	push	bc
	push	de
	ldi
	ldi
	ldi
	pop	de
	call	down_de
	pop	bc
	djnz	.loop
	pop	de
	call	scr_to_attr
	ex	de,hl
	ld	de,32-2
	pop	af
	rrca
	rrca
	rrca
	ld	b,a
	ld	a,COLOR_DUNGEON
.loop_attr:
	ld	(hl),a
	inc	l
	ld	(hl),a
	inc	l
	ld	(hl),a
	add	hl,de
	djnz	.loop_attr
	ret


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	endmodule