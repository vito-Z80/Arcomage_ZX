

;	структура смещений ресурсов игроков
	struct RES_OFFSET
WALL		word
TOWER		word
QUARRY          word
BRICKS          word
MAGIC           word
GEMS            word
DUNGEON         word
RECRUITS        word
	ends

	struct DIFFICULTY
HARD:		byte
NORMAL:		byte
EASY:		byte
	ends

BORDER	macro color
	ld	a,color
	out	(254),a
	endm


;	+ Индексы информационных сообщений.
	struct	_MESSAGE

	ends

////////////////////////////////////////////////////////////////////////////////////////////////////
;	+ если != 0 текст карт переходит на новую строку после точки.
NEW_LINE_BY_DOT			=	1	
////////////////////////////////////////////////////////////////////////////////////////////////////
P_VAL_TOWER_SCR_ADDR		equ	#48e0 + 5
P_VAL_WALL_SCR_ADDR		equ	P_VAL_TOWER_SCR_ADDR + 4

P_ICON_QUARRY_SCR_ADDR		equ	#4000
P_ICON_MAGIC_SCR_ADDR		equ	#40A0
P_ICON_DUNGEON_SCR_ADDR		equ	#4840

E_ICON_QUARRY_SCR_ADDR		equ	#4020 - 4
E_ICON_MAGIC_SCR_ADDR		equ	#40C0 - 4
E_ICON_DUNGEON_SCR_ADDR		equ	#4860 - 4

P_VAL_QUARRY_SCR_ADDR:		equ	#4080
P_VAL_BRICKS_SCR_ADDR:		equ	P_VAL_QUARRY_SCR_ADDR + #02
P_VAL_MAGIC_SCR_ADDR:		equ	#4820
P_VAL_GEMS_SCR_ADDR:		equ	P_VAL_MAGIC_SCR_ADDR + #02
P_VAL_DUNGEON_SCR_ADDR:		equ	#48C0
P_VAL_RECRUITS_SCR_ADDR:	equ	P_VAL_DUNGEON_SCR_ADDR + #02

E_VAL_TOWER_SCR_ADDR		equ	#48FE - 5
E_VAL_WALL_SCR_ADDR		equ	E_VAL_TOWER_SCR_ADDR - 4

E_VAL_QUARRY_SCR_ADDR:		equ	#409F
E_VAL_BRICKS_SCR_ADDR:		equ	E_VAL_QUARRY_SCR_ADDR - #03
E_VAL_MAGIC_SCR_ADDR:		equ	#483F
E_VAL_GEMS_SCR_ADDR:		equ	E_VAL_MAGIC_SCR_ADDR - #03
E_VAL_DUNGEON_SCR_ADDR:		equ	#48dF
E_VAL_RECRUITS_SCR_ADDR:	equ	E_VAL_DUNGEON_SCR_ADDR - #03

TEXT_NAME_SCR_ADDR		equ	#402C - #21	;	card name display address
TEXT_FRAME_SCR_ADDR		equ	#402C
TEXT_FRAME_ATTR_ADDR		equ	#582C
////////////////////////////////////////////////////////////////////////////////////////////////////
TEXT_FRAME_WIDTH		equ	8
TEXT_FRAME_HEIGHT		equ	8
TEXT_FRAME_DIGIT_COLOR		equ	%01000101
TEXT_FRAME_TEXT_COLOR		equ	%01000110

CHAR_HEIGHT			equ	8

MAX_RESOURCES			equ	999		;	максимум ресурсов
MIN_RESOURECS			equ	0		;	минимум ресурсов
MAX_BUILDING			equ	99		;	максимальное значение для зданий
MIN_BUILDING			equ	1		;	минимальное значение для зданий (если будет 0 - ежедневного прироста не будет)
MAX_CARDS			equ	102
CARDS_ON_TABLE			equ	6		; 	карт на столе (отображаемых карт)
////////////////////////////////////////////////////////////////////////////////////////////////////
COLOR_BLACK			equ	0
COLOR_RED			equ	1
COLOR_BLUE			equ	2
COLOR_PURRPLE			equ	3
COLOR_GREEN			equ	4
COLOR_CYAN			equ	5
COLOR_YELLOW			equ	6
COLOR_WHITE			equ	7

COLOR_WARNING			equ	%01010111

COLOR_QUARRY			equ	%01011001
COLOR_MAGIC			equ	%01101001
COLOR_DUNGEON			equ	%01100001

////////////////////////////////////////////////////////////////////////////////////////////////////
//	The system variables:	https://worldofspectrum.org/ZXBasicManual/zxmanchap25.html	  //
////////////////////////////////////////////////////////////////////////////////////////////////////

;	+ Address of BASIC program.
START_BASIC:			equ	23635		
;	+ RAMTOP	Address of last byte of BASIC system area.
END_BASIC:			equ	23730		
;	+ Address of last byte of physical RAM.
END_RAM:			equ	23732		
;	+ 3 byte (least significant first), frame counter. Incremented every 20ms.
SYSTEM_TIMER:			equ	23672		
;	+ Address of start of spare space.
STKEND:				equ	23653		
////////////////////////////////////////////////////////////////////////////////////////////////////
