	module TEXT
map:
			dw	not_enough_res
			dw	cant_discarded
			dw	must_discard

not_enough_res:		db	"Not enough resources to play this card", END_CARD_TEXT
cant_discarded:		db	"This card cannot be discarded", END_CARD_TEXT
must_discard:		db	"You must discard any card", END_CARD_TEXT
///////////////////////////////////////////////////////////////////////////////////////////////////////////
pl_mess:		db	"PLAYER", 0
en_mess:		db	"ENEMY", 0
discard_word:		db	"DISCARD!", 0
///////////////////////////////////////////////////////////////////////////////////////////////////////////
control:		db	"1 - ", END_CARD_TEXT
redefine_keys:		db	"2 - REDEFINE", END_CARD_TEXT
difficulty:		db	"3 - ", END_CARD_TEXT

dif_state_easy:		db	"EASY", END_CARD_TEXT
dif_state_hard:		db	"HARD", END_CARD_TEXT
control_kempston_5:	db	"KEMPSTON 5", END_CARD_TEXT
control_kempston_8:	db	"KEMPSTON 8", END_CARD_TEXT
control_keyboard:	db	"KEYBOARD", END_CARD_TEXT
fire_to_start:		db	"FIRE TO START", END_CARD_TEXT
///////////////////////////////////////////////////////////////////////////////////////////////////////////
key_left:		db	"Left", END_CARD_TEXT
key_right:		db	"Right", END_CARD_TEXT
key_move:		db	"Move", END_CARD_TEXT
key_discard:		db	"Discard", END_CARD_TEXT
key_pause:		db	"Pause", END_CARD_TEXT
///////////////////////////////////////////////////////////////////////////////////////////////////////////
try_kempston:		db	"PUSH THE LEFT ON KEMPSTON JOYSTICK, IF YOU HAVE, OR SPACE.", END_CARD_TEXT
///////////////////////////////////////////////////////////////////////////////////////////////////////////

	endmodule