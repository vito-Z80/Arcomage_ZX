	module	IM
INT_    equ     #FC00

interrupt:
        push hl,de,bc,af,ix,iy
        exx 
        exa
        push hl,de,bc,af
	

        call    _DISPLAY.info_text
        call	_DISPLAY.info_attr
        ld      a,(_DISPLAY.mess_timer)
        or      a
        jr      z,.no_clear
        inc     a
        ld      (_DISPLAY.mess_timer),a
        cp      #FF
        jr      c,.no_clear
        call    _DISPLAY.clear_info
	xor	a
	ld	(_DISPLAY.mess_timer),a
.no_clear:

        call    RENDERING.flash_player


        pop af,bc,de,hl
        exa
        exx
        pop iy,ix,af,bc,de,hl
        ei
        ret
im2_init:
        ld hl,INT_
        ld a,h
        di
        ld i,a
        inc a
        ld c,a
        ld b,l
.loop:
        ld (hl),c
        inc hl
        djnz .loop
        ld (hl),c
        ld h,c
        ld l,h
        ld (hl),#C3
        inc l
        ld (hl),low interrupt
        inc l
        ld (hl),high interrupt
        im 2
        ei
        ret
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////////////////////////////
/*
        запуск приложения:
                сохранить байт с порта кемпстона
                завести флаг доступности кемпстона = false
        прерывания:
                опрашивать порт кемпстона до тех пор пока текущий принятый байт не будет отличный от сохраненного.
                если достигнуто - включаем флаг доступности кемпстона = true
        редефайн:
                если флаг доступности кемпстона включен = разрешаем определение управления кемпстоном.
                иначе не опрашиваем кемпстон.

*/
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
	endmodule