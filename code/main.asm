start:


	;	TODO добавить новый путь тайлов карты.
	;	TODO визуал значений ресурсов компьютера должен начать отображаться после того как курсор прибыл на место.
	;	TODO поменять задник карты на 4х4, обновить визуализацию действий компьютера под такой задник.
	;	FIXME стороны курсора при доп. ходе компьютера иногда моргают - устранить. 

	call	IM.im2_init
	ld	hl,(SYSTEM_TIMER)
	ld	a,r
	xor	h
	ld	h,a
	xor	l
	ld	l,a
	ld	(DATA.global_seed),hl
	ld	hl,#4000
	ld	de,#4001
	ld	bc,6911
	ld	(hl),l ;%01010101
	ldir
	; call	grid
	

	call	GAME.set_resources
	call	GAME.init



	; атрибутная линия под башни, стены.
	ld	hl,#59E0
	ld	b,#20
	ld	a,7
	call	RENDERING.paint_line.loop

.main_loop:
	ei
	halt
	xor 	a
	out 	(254),a

	call	GAME.run

	jr 	.main_loop
	

///////////////////////////////////////////////////////////////////////////////////////////////////////

	include "rendering.asm"
	include "interrupt.asm"
	include "display.asm"
	include "utils.asm"
	include "player.asm"
	include "game.asm"
	include "calc.asm"
	include "main_menu.asm"
	include "input.asm"
	include "card_utils.asm"
cl_start:
	include "card_logic.asm"
cl_end:
	include "./data/text.asm"
c_data:
	include "./data/cards.asm"
c_end:
font4:
	incbin "./gfx/font4double.SpecCHR", 0, 768
card_raw:
	incbin "./gfx/card_sprites_102.spr"
card_back_raw:
	incbin "./gfx/back.spr"		; задник карты
icons:
	incbin "./gfx/l_icon_quarry.spr"
	incbin "./gfx/l_icon_magic.spr"
	incbin "./gfx/l_icon_dungeon.spr"
big_icons:
	incbin "./gfx/b_icon_quarry.spr"
	incbin "./gfx/b_icon_magic.spr"
	incbin "./gfx/b_icon_dungeon.spr"
frame_top_left:
	db	%00000000
	db	%00000000
	db	%00000000
	db	%00000000
	db	%00001110
	db	%00001110
	db	%00001110
	db	%00000000
frame_top_right:
	db	%00000000
	db	%00000000
	db	%00000000
	db	%00000000
	db	%01110000
	db	%01110000
	db	%01110000
	db	%00000000
frame_top:
	db	%00000000
	db	%00000000
	db	%00000000
	db	%00000000
	db	%00000000
	db	%00001110
	db	%01101110
	db	%00000000
frame_left:
	db	%00000000
	db	%00000010
	db	%00000010
	db	%00000000
	db	%00000110
	db	%00000110
	db	%00000110
	db	%00000000
frame_right:
	db	%00000000
	db	%01000000
	db	%01000000
	db	%00000000
	db	%01100000
	db	%01100000
	db	%01100000
	db	%00000000

//////////////////////////////////////////////////////////////////////////////////////////////////////////
	include "./data/probability.asm"
	include "./data/data.asm"
//////////////////////////////////////////////////////////////////////////////////////////////////////////




	display "------------------------------------------------------------------------------"
	display "Card logic size: ", /A, cl_end - cl_start
	display "cards data: ", /A, c_end - c_data
	display "------------------------------------------------------------------------------"
	display "players resources address: ", /A, DATA.player_resources
	display "computer resources address: ", /A, DATA.computer_resources
	display "players card id`s address: ", /A, DATA.player_cards
	display "computer card id`s address: ", /A, DATA.enemy_cards
	display "------------------------------------------------------------------------------"
	display "probability map address: ", /A, probability_map
	display "probability player address: ", DATA.probability_player," | ", DATA.probability_player + MAX_CARDS 
	display "probability computer address: ", DATA.probability_comp," | ", DATA.probability_comp + MAX_CARDS
	display "------------------------------------------------------------------------------"
	display "Message timer address: ", /A, _DISPLAY.mess_timer
	display "icons address: ", /A, icons
	display "------------------------------------------------------------------------------"
	display "FULL SIZE: ", /A, $ - start
	display "END ADDRESS: ", /A, $
	display "------------------------------------------------------------------------------"
