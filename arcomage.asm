	device	zxspectrum128

	include "code/defines.asm"
        macro TAP_LOAD dst, length
                ld ix,dst
                ld de,length
                ld a,#FF
                scf
                call #0556
        endm	

	org 	#5CCB
basic:
    	dw 	#00,end_basic - basic
start_basic:
	db 	#F9,#C0 		; RANDOMIZE USR
	db 	'23774'			; ADDR
    	db 	#3A,#EA
    	db 	#0E,#00,#00
	dw 	start_code   		; ADDR value
	db 	#00
////////////////////////////////////////////////////////////
start_code:
	xor	a
	sub	1
	ld	ix,game_screen
	ld	de,end_game_screen - game_screen
	call	#0556
	sub	1
	ld	ix,main_code
	ld	de,end_code - main_code
	call	#0556
	ld	sp,$
end_basic:
////////////////////////////////////////////////////////////
    	EMPTYTAP Arcomage.tap
	SAVETAP "Arcomage.tap", BASIC,"Arcomage", basic, end_basic-basic, 0
////////////////////////////////////////////////////////////
	TAPOUT 	Arcomage.tap
	org 	#4000
game_screen:
    	incbin 	"gfx/helpcomputer0 - Blue Dragon (2023).scr"
end_game_screen:
	TAPEND
////////////////////////////////////////////////////////////
    	TAPOUT 	Arcomage.tap
    	org 	end_basic
main_code:
    	include "code/main.asm"
end_code:
    	TAPEND





	display "START BASIC: ", /A, start_code
	display "END BASIC: ", /A, end_basic
	

	if __ERRORS__ = 0
		labelslist "user.l"
		shellexec "C:\ZX\emul\Xpeccy0.6.20230425\xpeccy -s3 --labels C:\ZX\projects\Arcomage_tests\user.l Arcomage.tap"
		; shellexec "C:\ZX\emul\US0371\unreal.exe Arcomage.tap"
	endif


	; TODO
	; отработать вейты. (когда еще один ход у игрока - убрать вейт после новой карты) ....

	; FIXME
	; компьютер скидывает карты которые может оплатить.
	; компьютер рисует иконку D всегда справой стороны. (первые 3 карты должны рисовать иконку D с левой стороны при сбросе карты)


	; Основные правила:
	; 
	; Если предназначение урона не указано то урон идет стене. 
	; DAMAGE 12 при WALL = 10 и TOWER = 20 должен иметь результат: WALL = 0 и TOWER = 18
	; DAMAGE 12 TO ENEMY TOWER при тех же значениях даст результат: WALL = 10 и TOWER = 8
	; 
	; Диапазон значений:
	; Цены карт прибиты гвоздями.
	; QUARRY, MAGIC, DUNGEON: (1 - 99) если значение бутет < 1, не будет ежедневного прироста.
	; Остальные: (0 - 999)
	; 
	; 
	; Особое внимание картам: 
	; Карты дающие дополнительный ход и более.
	; Prism, Elven Scout:  (дают 3 хода с учетом хода самой карты, 
	; где второй ход - принудительное скидывание карты. Сработает ли 4-ый ход если на третьем ходе выбрать карту с play again ?)
	; Lodestone: Убедиься что компьютер во время тестирования не сможет сбросить данную карту.
	; 
	; Найти карты которые неправильно калькулируют ресурсы, либо калькулируют необъявленные ресурсы.
	; Например в карте указано: +3 WALL, но помимо этого еще случилось +1 TOWER. 
	; 
	; Соответствие карт: текст, изображение, тип.
	; 
	; Подумать о задержках, что бы игрок смог понять чем походил компьютер и сколько раз.
	; 
	; 
	; 
	; 
	; 
	; 
	; 
	; 
	; 
	; 


	        /*
Xpeccy command line arguments:
-h | --help             show this help
-d | --debug            start debugging immediately
-s | --size {1..4}      set window size x1..x4.
-n | --noflick {0..100} set noflick level
-r | --ratio {0|1}      set 'keep aspect ratio' property                                                                  
-p | --profile NAME     set current profile
-b | --bank NUM         set rampage NUM to #c000 memory window
-a | --adr ADR          set loading address (see -f below)
-f | --file NAME        load binary file to address defined by -a (see above)
-l | --labels NAME      load labels list generated by LABELSLIST in SJASM+
-c | --console  Windows only: attach to console
--fullscreen {0|1}      fullscreen mode
--pc ADR                set PC
--sp ADR                set SP
--bp ADR                set fetch brakepoint to address ADR
--bp NAME               set fetch brakepoint to label NAME (see -l key)
--disk X                select drive to loading file (0..3 | a..d | A..D)
--style                 MacOSX only: use native qt style, else 'fusion' will be forced
--xmap FILE             Load *.xmap file
        */