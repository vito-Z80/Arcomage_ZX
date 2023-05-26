;	+ cursor_location
;	+ tmp_resources
;	+ hundred_storage
;	+ tenth_storage
;	+ global_seed
;	+ can_move_in_cur_time
;	+ card_text_storage
;	+ player_resources
;	+ computer_resources
;	+ player_final_resource
;	+ computer_final_resource
;	+ player_cards
;	+ enemy_cards
;	+ 
;	+ player_moves
;	+ computer_moves
;	+ whose_move
;	+ discard
;	+ cant_discard
;	+ play_again
;	+ 
;	+ cursor
;	+ pre_cursor
;	+ 
;	+ is_paid
;	+ is_card_move
;	+ 
;	+ pressed_key
;	+ 
;	+ symbol_counter
;	+ card_position_table
;	+ card_end_position_table
;	+ card_symbol_table
;	+ card_attribute_table
;	+ 
;	+ move_buff
;	+ 
;	+ dificulty
	module DATA
;	+ адреса отображения курсора на экране
; cursor_location:          
;         dw 	#5020
;         dw 	#5025
;         dw 	#502A
;         dw 	#5030
;         dw 	#5035
;         dw 	#503A
	
;	+ Последовательность адресов процедур отображения ресурсов на экране в порядке расположения ресурсов в памяти.
res_display_seq:
	dw	_DISPLAY.p_wall
	dw	_DISPLAY.p_tower
	dw	_DISPLAY.p_res_quarry
	dw	_DISPLAY.p_res_bricks
	dw	_DISPLAY.p_res_magic
	dw	_DISPLAY.p_res_gems
	dw	_DISPLAY.p_res_dungeon
	dw	_DISPLAY.p_res_recruits
	dw	_DISPLAY.e_wall
	dw	_DISPLAY.e_tower
	dw	_DISPLAY.e_res_quarry
	dw	_DISPLAY.e_res_bricks
	dw	_DISPLAY.e_res_magic
	dw	_DISPLAY.e_res_gems
	dw	_DISPLAY.e_res_dungeon
	dw	_DISPLAY.e_res_recruits

tiles_matrix_left:
	db	3, 	2, 	1, 	0
	db	7, 	6, 	5, 	4
	db	11, 	10, 	9, 	8
	db	15, 	14, 	13, 	12

tiles_matrix_right:
	db	0,	1,	2,	3
	db	4,	5,	6,	7
	db	8,	9,	10,	11
	db	12,	13,	14,	15

;	+ стартовые значения ресурсов обоих игроков. 16 байт.
;	+ wall, tower, quarry, bricks, magic, gems, dungeon, recruits
;	+ quarry, magic, dungeon - хотя и двух байтные, реальный результат в одном байте с макс значением 99
;	+ остальные ресурсы двухбайтные и имеют макс значение 999
tmp_resources:
        dw #000A,#0020
        dup 3
        dw #0001,#0007
        edup
;	+ хранилище трехзначного целого числа в виде текста
hundred_storage:
	db	0
;	+ хранилище двузначного целого числа в виде текста
tenth_storage:
	db	0, 0, END_CARD_TEXT


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////// ниже нулевы данные ///////////////
	db	0
global_seed
	dw	0
;	Сложность игры. Обеспечивает уровень качества выдаваемых карт для обоих игроков, выбор карты для хода компьютера.
;	+ 0 - hard
;	+ 1 - normal
;	+ 2 - easy
difficulty:
	db	0
;	+ хранилище распакованного текста карты для последующего отображения на экране.
;	+ +1 для завершающего текст символа определенного в END_CARD_TEXT
card_text_storage:
	block	MAX_CARD_TEXT_LENGTH + 1, 0

;	+ Текущие значения ресурсов игрока. Выравниваются до финальных значений player_final_resource
player_resources:
	block	RES_OFFSET, 0
computer_resources:
	block	RES_OFFSET, 0
;	+ Конечные значения ресурсов иргока. Значения после вычислений логики карт.
player_final_resource:
	block	RES_OFFSET, 0
computer_final_resource:
	block	RES_OFFSET, 0
	

;	+ хранилище индексов карт на руках у игрока - 6 байт (карт на руках всегда 6)
player_cards:
	block	6, 0
;	+ хранилище индексов карт на руках у компьютера - 6 байт (карт на руках всегда 6)
enemy_cards:
	block	6, 0
;	+ кол-во ходов совершонное игроком.
player_moves:
	db	0,0
;	+ кол-во ходов совершонное компьютером.
computer_moves:
	db	0,0

;	+ 0 - ход игрока.
;	+ !0 - ход компьютера.
whose_move:
	db	0
;	+ 0 - передать ход
;	+ !0 - еще один или N ходов.
play_again:
	db	0
;	+ !0 - нельзя скинуть карту.
cant_discard:
	db 	0
;	+ 2 = обязательно скинуть карту вторым ходом. Необходимо для карт с индексами: 38, 72.
force_discard_card:
	db	0
;	+ нажатая клавиша:
;	+ первый байт = порт
;	+ второй байт = бит ряда.
pressed_key:
	db 	0, 0
;	+ индекс курсора
cursor:
	db	0
;	+ предыдущий инедкс курсора
;	+ вроде не особо нужен, FIXME - избавиться
pre_cursor:
	db	0


;	+ 0 - карат оплачена.
;	+ !0 - карта не оплачена, 
is_paid:
	db	0

;	+ Индекс информационного сообщения.
message_id:
	db	0

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
;	+ Вероятность выпадения карт игрока. x2 - Первые 102 значения изменяемые, последующие не изменяемые - для восстановления первых.
probability_player:
	block	MAX_CARDS * 2, 0
;	+ Вероятность выпадения карт компьютера. x2 - Первые 102 значения изменяемые, последующие не изменяемые - для восстановления первых.
probability_comp:
	block	MAX_CARDS * 2, 0
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; is_card_move:
; 	db	0
;	+ Счетчик движущихся символов. (MAX = 16)
symbol_counter:
	db 	0
;	+ таблица начала координат для перемещения карты по символам
card_position_table:
	block	32
;	+ таблица завершающих движение координат для перемещения карты по символам
card_end_position_table:
	block	32
; ;	+ таблица адресов всех символов для перемещаемой карты.
; card_symbol_table:
; 	block	32
; ;	+ таблица адресов всех атрибутов для перемещаемой карты.
; card_attribute_table:
; 	block	32
;	+ Буфер перемещаемых симаолов карты (16 х 8)
move_buff:
	block	144, 0


	display "move_buff: ", /A, move_buff

	endmodule

