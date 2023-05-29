	module TEXT
map:
			dw	not_enough_res
			dw	cant_discarded
			dw	must_discard

not_enough_res:		db	"Not enough resources to play this card", END_CARD_TEXT
cant_discarded:		db	"This card cannot be discarded", END_CARD_TEXT
must_discard:		db	"You must discard any card", END_CARD_TEXT
///////////////////////////////////////////////////////////////////////////////////////////////////////////
pl_mess:		db	"Player", 0
en_mess:		db	"Enemy", 0
discard_word:		db	"DISCARD!", 0


	endmodule