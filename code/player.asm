;	+ key_polling
;	+ pay
;	+ 
;	+ get_res_addr
;	+ get_indices_addr
;	+ 
;	+ active_calc_res
;	+ non_active_calc_res
;	+ active_res_addr
;	+ non_active_res_addr
	module PLAYER



same_key:
	db	0

key_jump:
	dw	move_left
	dw	move_right
	dw	player_move
	dw	press_discard
	dw	press_pause
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


control_polling:
	ld	hl,DATA.keyboard + 6
	; discard key
	call	INPUT.listener_with_pre
	jp	z,press_discard
	inc	hl
	; pause key
	ld	b,(hl)
	inc	hl
	call	INPUT.listener
	cp	(hl)
	jp	z,press_pause

	ld	a,(MAIN_MENU.select_control + 1)
	rrca
	jp	c,INPUT.keyboard_polling
	jp	INPUT.kempston_polling
.jump
	ex	de,hl
	ld	c,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,c
	ld	a,(DATA.cursor)
	ld	(DATA.pre_cursor),a
	jp	(hl)

move_left:
	sub	1
	jr	nc,.end
	ld	a,CARDS_ON_TABLE - 1
.end:
	ld	(DATA.cursor),a
	call	_DISPLAY.clear_cursor
	call	_DISPLAY.cursor
	jp	_DISPLAY.card_frame
move_right:
	inc	a
	cp	CARDS_ON_TABLE
	jr	c,move_left.end
	xor	a
	jr	move_left.end


press_discard:
	call 	CARD_UTILS.card_id_by_cursor
	cp	39		; 	39	-	+8 TOWER. THIS CARD CAN'T BE DISCARDED WITHOUT PLAYING IT.
	jr	z,.cant_discard
	;	discard card

	call	_DISPLAY.discard_mess_on_card
	call	wait
	call	CALC.tiles_pos
	call	GAME.fill_buff
	; ld	a,(DATA.cursor)
	; call	card_scr_by_cursor
	; call	clear_undercard
.loop:

	ei
	halt

	call	_DISPLAY.move_tiles_sym_seq
	call	_DISPLAY.discard_icon
	call	_DISPLAY.alignment_resources
	ld	a,(GAME.phase_card_from_bottom)
	or	a
	jr	nz,.loop
	ld	(DATA.force_discard_card),a
	call	player_move.un_bo
	call	wait
	jp	pay.move_complete
.cant_discard:
	; Указать индекс для отображения текста что нельзя скинуть эту карту.
	ld	a,1
	jp	_DISPLAY.launch_info
press_pause:
	ret

//////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////////////
show_force_discard_message:
	ld	a,2
	jp	_DISPLAY.launch_info
show_no_money_message:
	xor	a
	jp	_DISPLAY.launch_info

player_move:
	ld	a,(DATA.force_discard_card)
	or	a
	; Показать текст о необходимости скинуть любую карту согласно условиям спец. карт, и выйти.
	jr	nz,show_force_discard_message

	; произвести оплату если возможно, занести новые данные в ресурсы при успешной оплате.
	call	GAME.move_action
	ld	a,(DATA.is_paid)
	or	a
	jr	nz,show_no_money_message		; оплата не прошла, выход.

		
	; расчитать координаты движения тайлов карты, запонение буфер заднего фона задником карты.
	call	CALC.tiles_pos
	call	GAME.fill_buff
	; call	RENDERING.shift_on_table

.loop:
	; движение тайлов карты к месту назначения, выравнивание ресурсов (если еще не завершено)
	ei
	halt
	call	_DISPLAY.move_tiles_sym_seq
	call	_DISPLAY.alignment_resources

	ld	a,(GAME.phase_card_from_bottom)
	or	a
	jr	nz,.loop
	; залить область под картой частью спрайта задника карты.
.un_bo:
; 	ld	a,(DATA.cursor)
; 	call	card_scr_by_cursor
; 	call	clear_undercard
; 	
	call	CALC.tiles_from_bottom
	call	GAME.clear_card_buff
	; создание новой карты.
	call	CARD_UTILS.card_id_by_cursor	;	hl - адрес индекса карты по курсору
	push	hl
	call	CALC.new_card_id_by_diff
	pop	hl
	; call	GAME.new_card_id
	ld	(hl),a
	push	af			; card index
	ld	a,(DATA.cursor)
	call	card_scr_by_cursor
	; jr	$
	ex	de,hl
	ld	bc,#80
	add	hl,bc
	ex	de,hl
	call	scr_to_attr
	pop	af
	call	_DISPLAY.under_card_line
	call	_DISPLAY.card_frame	; отрисовать текст карты и ее название.
	call	_DISPLAY.cursor
	ld	a,32
	call	wait + 2
	; call	wait
.l3:
	; движение тайлов карты из под экрана к позиции курсора, выравнивание ресурсов (если еще не завершено)
	ei
	halt
	call	_DISPLAY.move_tiles_sym_seq
	call	_DISPLAY.alignment_resources
	ld	a,(GAME.phase_card_from_bottom)
	or	a
	jr	nz,.l3
	; call	_DISPLAY.card_sprite	; еще раз отрисовать все тайлы карты (прост там функция орисовки линии значений под картой)
	ld	a,(DATA.play_again)
	dec	a
	call	nz,wait
	ret
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
en_disc:
	db	0
deceptive_cursor_cur:
	db	0
deceptive_cursor_end:
	db	0
;	+ Компьютер всегда ходит первой картой, если ее нельзя оплатить то следующей и т.д.
;	+ Если ни одну из карт нельзя оплатить то компьютер сбрасывает последнюю.
;	+ 
enemy_move:
	ld	a,(DATA.cursor)
	ld	(.fin + 1),a		; save player cursor index
	call	_DISPLAY.clear_cursor + 3

	call CALC.comp_cards_sort	; сортировка карт компьютера от лучшей к худшей.

	ld	a,(DATA.force_discard_card)
	or	a
	; скинуть любую карту согласно условиям спец. карт, и выйти.
	jp	nz,.discard_last_card


	ld	a,20
	call	wait + 2
	call	GAME.new_cursor_id
	ld	(deceptive_cursor_end),a
	ld	a,(deceptive_cursor_cur)
	call	_DISPLAY.cursor + 3
	; оплатить карту либо скинуть.

	xor	a
	ld	b,a		; cursor index.
	ld	(DATA.cursor),a
.set_cur:
	ld	a,b
	cp	CARDS_ON_TABLE
	inc	b
	jp	nc,.discard_last_card	; если ни одну карту не удалось оплатить то сбросить последнюю карту.
	ld	(DATA.cursor),a
	push	bc
	call	GAME.move_action
	pop	bc
	ld	a,(DATA.is_paid)
	or	a
	jr	nz,.set_cur		; оплата не прошла, попробовать следующую карту.



.em_1:
	; отобразить текст карты.
	call	_DISPLAY.card_frame
	call	GAME.fill_buff
	call	comp_cursor_move	; TODO перемещение курсора должно быть перед началом отображения калькуляции значений ресурсов

	; draw card
	ld	a,(DATA.cursor)
	ld	hl,DATA.enemy_cards
	ld	c,a
	ld	b,0
	add	hl,bc
	ld	a,(hl)				; A - card index
	push	af
	call	CALC.card_raw_addr		; HL - card raw addr
	ld	a,(deceptive_cursor_end)
	call	card_scr_by_cursor		; DE - screen address
	call	RENDERING.sprite_4x4
	pop	af
	call 	_DISPLAY.under_card_line


	; расчитать координаты движения тайлов карты, запонение буфера заднего фона задником карты.

	; show discard message above card if
	ld	a,(DATA.cursor)
	push	af
	ld	a,(deceptive_cursor_end)
	ld	(DATA.cursor),a
	ld	a,(en_disc)
	or	a
	call	nz,_DISPLAY.discard_mess_on_card
	
	call	wait
	call	CALC.tiles_pos
	pop	af
	ld	(DATA.cursor),a
.loop:
	; движение тайлов карты к месту назначения, выравнивание ресурсов (если еще не завершено)
	ei
	halt
	call	_DISPLAY.move_tiles_sym_seq
	; show discord icon if
	ld	a,(en_disc)
	or	a
	jr	z,.no_dsc
	ld	a,(deceptive_cursor_end)
	call	_DISPLAY.discard_icon + 3
.no_dsc:
	call	_DISPLAY.alignment_resources
	ld	a,(GAME.phase_card_from_bottom)
	or	a
	jr	nz,.loop
	; reset enemy discard value
	xor	a
	ld	(en_disc),a
	; залить область под картой частью спрайта задника карты.
	; ld	a,(deceptive_cursor_end)
	; call	card_scr_by_cursor
	; call	clear_undercard

	; создание новой карты.
	call	CARD_UTILS.card_id_by_cursor	;	hl - адрес индекса карты по курсору
	push	hl
	call	CALC.new_card_id_by_diff
	pop	hl
	; call	GAME.new_card_id
	ld	(hl),a

	call	wait
	ld	a,(DATA.play_again)
	or	a
	jr	nz,.no_clear
	ld	a,(deceptive_cursor_end)
	call	_DISPLAY.clear_cursor + 3
.no_clear:
.fin:
	ld	a,0
	ld	(DATA.cursor),a
	; ld	a,(DATA.play_again)
	; or	a
	; call	z,_DISPLAY.cursor
	ret
;
.discard_last_card:
	; ld	hl,DATA.comp_cards + CARDS_ON_TABLE - 1
	call 	CARD_UTILS.card_id_by_cursor
	cp	39		; 	39	-	+8 TOWER. THIS CARD CAN'T BE DISCARDED WITHOUT PLAYING IT.
	jr	nz,.discard_ok
	ld	hl,DATA.cursor
	dec	(hl)
	jr	.discard_last_card
.discard_ok:
	;	discard card
	ld	a,h		; A != 0
	ld	(en_disc),a
	xor	a
	ld	(DATA.force_discard_card),a
	call	pay.move_complete
	jp	.em_1
	; ; отобразить текст карты.
	; call	_DISPLAY.card_frame
	; call	GAME.fill_buff
	; call	comp_cursor_move

	; ; draw card
	; ld	a,(DATA.cursor)
	; ld	hl,DATA.enemy_cards
	; ld	c,a
	; ld	b,0
	; add	hl,bc
	; ld	a,(hl)				; A - card index
	; push	af
	; call	CALC.card_raw_addr		; HL - card raw addr
	; ld	a,(deceptive_cursor_end)
	; call	card_scr_by_cursor		; DE - screen address
	; call	RENDERING.sprite_4x4
	; pop	af
	; call 	_DISPLAY.under_card_line


	; call	_DISPLAY.discard_mess_on_card


	; BORDER	7
	; jr	$
	; jr	.no_clear
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
;	+ Движение курсора компьютера от его последнего местоположения к местоположению карты для хода.
;	+ Оба местоположения являются фиктивными, так как компьютер всегда ходит первой картой из списка, которую удается оплатить.
;	+ Это сделано потому что список карт сортируется относительно сложности игры и качества карты перед каждой выдачей новой карты.
comp_cursor_move:
	ld	hl,deceptive_cursor_cur
	ld	a,(deceptive_cursor_end)
	sub	(hl)
	ret	z
	jr	c,.minus
	call	wait_without_res
	ld	a,(hl)
	inc	(hl)
	push	hl
	call	_DISPLAY.clear_cursor + 3
	pop	hl
	ld	a,(hl)
	call	_DISPLAY.cursor + 3
	jr	comp_cursor_move
.minus:
	call	wait_without_res
	ld	a,(hl)
	dec	(hl)
	push	hl
	call	_DISPLAY.clear_cursor + 3
	pop	hl
	ld	a,(hl)
	call	_DISPLAY.cursor + 3
	jr	comp_cursor_move
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
wait_without_res:
	ld	a,10
.l2:
	; задержка.
	ei
	halt
	dec	a
	ret	z
	jr	.l2
	ret
;	+ wait 
wait:
	ld	a,51
.l2:
	; задержка.
	ei
	halt
	push	af,hl,de,bc
	call	_DISPLAY.alignment_resources
	pop	bc,de,hl,af
	dec	a
	jr	nz,.l2
	ret
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
;	+ Оплата карты требуемым ресурсом
;	+ A	-	card index
pay:
	push	af
	xor	a
	ld	(DATA.is_paid),a		; установить значение карты как: ОПЛАЧЕНО
	pop	af
	call	get_res_addr_by_card_type	; HL - адрес ресурса которым нужно оплатить карту.
	push	hl
	call	CARD_UTILS.card_cost		; A - цена карты.
	ld	e,a
	pop	hl				; HL - адрес ресурса которым нужно оплатить карту.
	ld	(.res_addr + 1),hl
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	ld	d,0
	or	a
	sbc	hl,de
	jr	c,.cant_pay			; вычисление меньше нуля = оплата невозможна.
	;	оплата прошла успешна.
	ex	de,hl
.res_addr:
	ld	hl,0
	ld	(hl),e
	inc	hl
	ld	(hl),d			; сохраняем оставшееся кол-во ресурсов которыми была произведена оплата.
	;	Если карту удалось оплатить то ход считается завершенным. 
.move_complete:
	;	отнять 1 ход.
	ld	a,(DATA.play_again)
	dec	a
	ld	(DATA.play_again),a
	ret


.cant_pay:
	ld	a,1
	ld	(DATA.is_paid),a	; установить значение карты как: НЕ ОПЛАЧЕНО.
	ret


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

;	+ Получение адреса ресурса ходящего игрока соответствующего одному из типов карт.
;	+ Типы карт расположены линейно индексам карт:
;	+ BRICKS - (0 - 33)
;	+ GEMS - (34 - 67)
;	+ RECRUITS - (68 - 101)
;	+ A	-	card index.
;	+ return:	HL -	address of resource by card type
get_res_addr_by_card_type:
	push	af
	call	get_res_addr
	pop	af
	ld	bc,6
	add	hl,bc
	dec	c
	dec	c
	cp	MAX_CARDS / 3
	ret	c
	add	hl,bc
	cp	MAX_CARDS / 3 * 2
	ret	c
	add	hl,bc
	ret
;	+ Получаем начало адреса ресурсов.
;	+ return:	HL	-	адрес ресурсов ходящего игрока.
;	+ return:	DE	-	адрес ресурсов ожидающего игрока.
get_res_addr:
	ld	hl,DATA.player_final_resource
	ld	de,DATA.computer_final_resource
.gd
	ld	a,(DATA.whose_move)
	or	a
	ret	z
	ex	de,hl
	ret
;	+ Получаем начало адреса индексов карт.
;	+ return:	HL	-	адрес индексов карт ходящего игрока.
;	+ return:	DE	-	адрес индексов карт ожидающего игрока.
get_indices_addr:
	ld	hl,DATA.player_cards
	ld	de,DATA.enemy_cards
	jr	get_res_addr.gd
;	+ получение адреса ресурса ожидающего игрока 
;	+ математическая операция с ресурсом.
;	+ B - смещение ресурса.
non_active_calc_res:
	call	non_active_res_addr
	jp	CARD_UTILS.calc_resource
;	+ получение адреса ресурса ходящего игрока
;	+ математическая операция с ресурсом.
;	+ B - смещение ресурса.
active_calc_res:
	call	active_res_addr
	jp	CARD_UTILS.calc_resource
;	+ получение адреса ресурса ходящего игрока
;	+ B - смещение ресурса.
;	+ return:	HL - адрес ресурса ходящего игрока
active_res_addr:
	call	get_res_addr
.gpra:
	ld	a,b
	add 	a,l
	ld 	l,a
	adc 	a,h
	sub 	l
	ld 	h,a
	ret
;	+ получение адреса ресурса ходящего игрока
;	+ B - смещение ресурса.
;	+ return:	HL - адрес ресурса ожидающего игрока
non_active_res_addr:
	call	get_res_addr
	ex	de,hl
	jr	active_res_addr.gpra
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	endmodule