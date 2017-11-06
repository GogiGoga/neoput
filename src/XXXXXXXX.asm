POZIC   equ 26201     ; 2 �����!

COLW    equ 26203     ; ���������� ���
ROWW    equ 26204     ; ��������� ����
LENW    equ 26205     ;
HGTW    equ 26206     ;
ATRW    equ 26207     ;
RAMW    equ 26208     ;
TEKWIN  equ 26209     ;

NABOR   equ 26210     ; 2 �����!
ATY     equ 26212     ; ���������� ���
ATX     equ 26213     ; ������ ������
CLR     equ 26214     ; ����
TABPOS  equ 26215     ; ������� ���������
PAUSPR  equ 26216     ; ����� ��� ������

BANK    equ 26217

SPREJ   equ 27218
SPBNK   equ 27219
SPADR   equ 27220
SPY     equ 27222
SPX     equ 27223
SPDL    equ 27224
SPWS    equ 27225


;======================================
;          ������ ���������
;======================================
        org 28050

; ---------- �������� ������ ----------
; -   ��� ���� ������� ������� �����  -
; -     ����� �� ������  ���������    -
; -------------------------------------

        di
        ld   c,#18
        call #3D13

        ld   hl,FILE00
        ld   c,#13
        call #3D13

        ld   a,9
        ld   (23814),a
        ld   c,#0A
        call #3D13

        ld   a,c
        ld   c,#08
        call #3D13

        ld   hl,26000
        ld   de,(#5CEB)
        ld   a,(#5CEA)
        ld   b,a
        ld   c,5
        call #3D13      ; ������� �����
        ei

; --- �������� ������������� ������ ---

        ld hl,26000    ; ������ �����
        ld (NABOR),hl  ; ������
        ld hl,#C000    ; ������ �������� �������
        ld (POZIC),hl  ; � ����� ����
        ld a,0         ; ��������� ����
        ld (BANK),a

; -------- ��������� ����� ���� -------
        di
        ld   hl,FILE01
        ld   c,#13
        call #3D13
        ld   c,#0A
        call #3D13
        ld   a,c
        ld   c,#08
        call #3D13
        ld   hl,49152
        ld   de,(#5CEB)
        ld   a,(#5CEA)
        ld   b,a
        ld   c,5
        call #3D13    ; ������� ����� 0
        ei

; ----- �������� ���� ��������� -----
; ----- ��������� ������� ����� -----

OSN00   ld  hl,(POZIC)
        ld  a,(hl)

        cp  01
        jr  nz,OSN02
            call COD01
            inc hl
            ld  (POZIC),hl
            jp  OSN00

OSN02   cp  2
        jr  nz,OSN03
            call COD02
            inc hl
            ld  (POZIC),hl
            jp  OSN00

OSN03   cp  3
        jr  nz,OSN04
            call COD03
            inc hl
            ld  (POZIC),hl
            jp  OSN00

OSN04   cp  04
        jr  nz,OSN05
            inc hl
            ld  (POZIC),hl
            call COD04
            jp  OSN00

OSN05   cp  05
        jr  nz,OSN06
            inc hl
            ld  (POZIC),hl
            call COD05
            jp  OSN00

OSN06   cp  06
        jr  nz,OSN07
            inc hl
            ld  (POZIC),hl
            call COD06
            jp OSN00

OSN07   cp  07
        jr  nz,OSN08
            inc hl
            ld  (POZIC),hl
            call COD07
            jp OSN00

OSN08   cp  8
        jr  nz,OSN09
            inc hl
            ld  (POZIC),hl
            call COD08
            jp OSN00

OSN09   cp  13
            jr nz,OSN10
            inc hl
            ld (POZIC),hl
            jp OSN00

OSN10   cp  9
        jr  nz,OSN16
            inc hl  ;���������� ���13
            inc hl
            ld (POZIC),hl
            call PRINT
            jp OSN00

OSN16  cp   16
       jr   nz,OSN20
            inc hl
            ld (POZIC),hl
            ld bc,0
            call 7997
            jp OSN00

OSN20  cp   20
       jp   nz,EXIT
OSN201      xor  a
            ld   (23560),a

OSN202      ld   a,(23560)
            cp   0
            jr   z,OSN202

            ld   e,a ; ���� ��������� ��� �������
            ld   hl,(POZIC)
            inc  hl
            ld   a,(hl)
            ld   d,a  ; � d-���������� ���������
            ld   a,e  ; ������� � a ��� �������

            cp   "1"
            jr   nz,OSN203
            inc  hl
            ld   b,(hl) ; ����� ����� �����
            inc  hl
            ld   c,(hl) ; ����� ����� �����
            ld   a,(BANK)
            cp   b
            call nz,BANKVKL ; �������� ����� ����
            call FINDSC    ; ����� ����� �����
            ld   (POZIC),hl
            jp   OSN208

OSN203      dec  d
            jr   z,OSN201
            cp   "2"
            jr   nz,OSN204
            inc  hl
            inc  hl
            inc  hl
            ld   b,(hl) ; ����� ����� �����
            inc  hl
            ld   c,(hl) ; ����� ����� �����
            ld   a,(BANK)
            cp   b
            call nz,BANKVKL ; �������� ����� ����
            call FINDSC    ; ����� ����� �����
            ld   (POZIC),hl
            jr   OSN208

OSN204      dec  d
            jr   z,OSN201
            cp   "3"
            jr   nz,OSN205
            inc  hl
            inc  hl
            inc  hl
            inc  hl
            inc  hl
            ld   b,(hl) ; ����� ����� �����
            inc  hl
            ld   c,(hl) ; ����� ����� �����
            ld   a,(BANK)
            cp   b
            call nz,BANKVKL ; �������� ����� ����
            call FINDSC    ; ����� ����� �����
            ld   (POZIC),hl
            jr   OSN208

OSN205      dec  d
            jr   z,OSN201
            cp   "4"
            jr   nz,OSN201
            inc  hl
            inc  hl
            inc  hl
            inc  hl
            inc  hl
            inc  hl
            inc  hl
            ld   b,(hl) ; ����� ����� �����
            inc  hl
            ld   c,(hl) ; ����� ����� �����
            ld   a,(BANK)
            cp   b
            call nz,BANKVKL ; �������� ����� ����
            call FINDSC    ; ����� ����� �����
            ld   (POZIC),hl

OSN208      jp  OSN00

EXIT   ret            ; ����� � ������


;======================================
;    ��������� ������������ �����
;======================================
BANKVKL push bc
        ld   a,b
        ld   (BANK),a
        add  a,16
        ld   bc,#7FFD
        out  (c),a
        pop  bc
        ret


;======================================
;       ��������� ������ �����
;======================================
FINDSC  ld   a,c
        ld   hl,#C000
        cp   0
        ret  z
FINDSC1 push af
FINDSC2 inc  hl
        ld   a,(hl)
        cp   #FE
        jr   nz,FINDSC2
        pop  af
        dec  a
        jr   nz,FINDSC1
        inc  hl
        inc  hl  ; ���� 13
        ret


;======================================
;   ��������� ��������� ����������
;          ������������� ����
;======================================
COD01   inc hl
        ld  a,(hl)
        ld  (COLW),a
        inc hl
        ld  a,(hl)
        ld  (ROWW),a
        inc hl
        ld  a,(hl)
        ld  (LENW),a
        inc hl
        ld  a,(hl)
        ld  (HGTW),a
        inc hl
        ld  a,(hl)
        ld  (ATRW),a
        inc hl
        ld  a,(hl)
        ld  (RAMW),a
        ret

;======================================
;   ��������� ��������� ���� #1
;======================================
COD02   ld  a,0
        ld  (COLW),a
        ld  (ROWW),a
        ld  a,32
        ld  (LENW),a
        ld  a,16
        ld  (HGTW),a
        ld  a,23
        ld  (ATRW),a
        ld  a,180
        ld  (RAMW),a
        ld  a,1
        ld  (ATX),a
        ld  (ATY),a
        ld  (TABPOS),a
        ret

;======================================
;   ��������� ��������� ���� #2
;======================================
COD03  ld  a,0
       ld  (COLW),a
       ld  a,16
       ld  (ROWW),a
       ld  a,32
       ld  (LENW),a
       ld  a,8
       ld  (HGTW),a
       ld  a,33
       ld  (ATRW),a
       ld  a,180
       ld  (RAMW),a
       ld  a,1
       ld  (ATX),a
       ld  (TABPOS),a
       ld  a,17
       ld  (ATY),a
       ret

;======================================
;   ��������� ������ ��������� ����
;======================================
COD04 call COD06
      call COD07
      call COD08
      ret

;======================================
;   ��������� ������� ������ ����
;======================================
COD05  ld   bc,(LENW)
       dec  b        ; ������ -2
       dec  b        ; ������ -2
       dec  c
       dec  c
       ld   a,(ROWW)
       inc  a         ;!!
CD051  push af
       push bc
       call 3742
       ld a,(COLW)
       inc a          ;!!
       add a,l
       ld l,a
       ld b,8
CD052  push hl
       ld e,c
       xor a
CD053  ld (hl),a
       inc hl
       dec e
       jr nz,CD053
       pop hl
       inc h
       djnz CD052
       pop bc
       pop af
       inc a
       djnz CD051

       ld de,#5800
       ld bc,(LENW)
       dec  b        ; ������ -2
       dec  b        ; ������ -2
       dec  c
       dec  c
       ld a,(ROWW)
       ld l,a
       ld h,0
       add hl,hl
       add hl,hl
       add hl,hl
       add hl,hl
       add hl,hl
       add hl,de
       ld a,(COLW)
       add a,l
       ld l,a
       ld a,(ATRW)
COD054 push bc
       push hl
COD055 ld (hl),a
       inc hl
       dec c
       jr nz,COD055
       pop hl
       pop bc
       ld de,32
       add hl,de
       djnz COD054
       ret

;======================================
;   ��������� ������� ����
;======================================
COD06  ld bc,(LENW)
       ld a,(ROWW)
CLRW1  push af
       push bc
       call 3742
       ld a,(COLW)
       add a,l
       ld l,a
       ld b,8
CLRW2  push hl
       ld e,c
       xor a
CLRW3  ld (hl),a
       inc hl
       dec e
       jr nz,CLRW3
       pop hl
       inc h
       djnz CLRW2
       pop bc
       pop af
       inc a
       djnz CLRW1
       ret


;======================================
;   ��������� ��������� ����� ���
;======================================
COD07  ld de,#5800
       ld bc,(LENW)
       ld a,(ROWW)
       ld l,a
       ld h,0
       add hl,hl
       add hl,hl
       add hl,hl
       add hl,hl
       add hl,hl
       add hl,de
       ld a,(COLW)
       add a,l
       ld l,a
       ld a,(ATRW)
ATRW1  push bc
       push hl
ATRW2  ld (hl),a
       inc hl
       dec c
       jr nz,ATRW2
       pop hl
       pop bc
       ld de,32
       add hl,de
       djnz ATRW1
       ret


;======================================
;       ��������� ����� ����
;======================================
COD08  ld  a,(COLW)
       ld  (XWINT),a
       ld  a,(ROWW)
       ld  (YWINT),a
       ld  a,(LENW)
       dec a
       dec a
       ld  (DLINT),a
       ld  a,(HGTW)
       dec a
       dec a
       ld  (WISTT),a
       ld  a,(RAMW)
       ld  (RAMWT),a

       ld  a,(RAMWT)   ;
       call PRRAMW     ; ����� �������
       ld  a,(RAMWT)   ; ����
       inc a           ;
       ld  (RAMWT),a   ;

       ld   a,(DLINT)  ;
       ld   b,a        ;
COD082 push bc         ;
       ld   a,(XWINT)  ;  ����� �������
       inc  a          ;
       ld   (XWINT),a  ;
       ld   a,(RAMWT)  ;
       call PRRAMW     ;
       pop  bc         ;
       djnz COD082     ;

       ld   a,(XWINT)  ;
       inc  a          ;
       ld   (XWINT),a  ; ������ �������
       ld   a,(RAMWT)  ; ����
       inc  a          ;
       ld   (RAMWT),a  ;
       call PRRAMW     ;

       ld   a,(RAMWT)  ;
       inc  a          ;
       ld   (RAMWT),a  ;
       ld   a,(WISTT)  ; ������ �������
       ld   b,a        ;
COD083 push bc         ;
       ld   a,(YWINT)  ;
       inc  a          ;
       ld   (YWINT),a  ;
       ld   a,(RAMWT)  ;
       call PRRAMW     ;
       pop  bc         ;
       djnz COD083     ;

       ld   a,(YWINT)  ;
       inc  a          ;
       ld   (YWINT),a  ; ������ ������
       ld   a,(RAMWT)  ; ����
       inc  a          ;
       ld   (RAMWT),a  ;
       call PRRAMW     ;

       ld   a,(RAMWT)  ;
       inc  a          ;
       ld   (RAMWT),a  ;
       ld   a,(DLINT)  ; ������ �������
       ld   b,a        ;
COD084 push bc         ;
       ld   a,(XWINT)  ;
       dec  a          ;
       ld   (XWINT),a  ;
       ld   a,(RAMWT)  ;
       call PRRAMW     ;
       pop  bc         ;
       djnz COD084     ;

       ld   a,(XWINT)  ;
       dec  a          ;
       ld   (XWINT),a  ; ����� ������
       ld   a,(RAMWT)  ; ����
       inc  a          ;
       ld   (RAMWT),a  ;
       call PRRAMW     ;

       ld   a,(RAMWT)  ;
       inc  a          ;
       ld   (RAMWT),a  ;
       ld   a,(WISTT)  ; ����� �������
       ld   b,a        ;
COD085 push bc         ;
       ld   a,(YWINT)  ;
       dec  a          ;
       ld   (YWINT),a  ;
       ld   a,(RAMWT)  ;
       call PRRAMW     ;
       pop  bc         ;
       djnz COD085     ;

       ret

PRRAMW ld   de,(NABOR)    ;----------
       ld   h,0           ;
       ld   l,a           ;
       add  hl,hl         ;����� �����
       add  hl,hl         ;������� �
       add  hl,hl         ;�����
       add  hl,de         ;
       push hl            ;----------

       ld   a,(XWINT)
       ld   d,a
       ld   a,(YWINT)
       ld   e,a
       and  #18           ;
       or   #40           ;
       ld   h,a           ;���������
       ld   a,e           ;����� �
       and  7             ;������ ��
       or   a             ;����������
       rra                ;����������
       rra                ;
       rra                ;
       rra                ;
       add  a,d           ;
       ld   l,a           ;----------

       pop  de            ;
       ld   b,8           ;
COD081 ld   a,(de)        ;����������
       ld   (hl),a        ;����
       inc  de            ;������
       inc  h             ;
       djnz COD081        ;----------
       ret

XWINT  defb 0
YWINT  defb 0
WISTT  defb 0
DLINT  defb 0
RAMWT  defb 0



;======================================
;       ��������� ������ ������
;======================================
PRINT   push af : push hl
        push bc : push de
        push ix : push iy

PR0     ld   hl,(POZIC)
        ld   a,(hl)         ; ����� ��������� ������

        cp 15
          jr   nz,PR1       ; ��� - 15
          inc  hl           ; ���������� 13
          inc  hl           ;
          ld   (POZIC),hl   ;
          pop  iy : pop ix
          pop  de : pop bc  ; ����� ������
          pop  hl : pop af  ; �����
          ret               ;

PR1     cp 11               ; ��� - 11
          jr   nz,PR2       ;
          inc  hl           ; ���������
          ld   a,(hl)       ; ����� ������
          ld   (ATX),a      ; AT X,Y
          ld   (TABPOS),a
          inc  hl           ;
          ld   a,(hl)
          ld   (ATY),a      ;
          inc  hl           ; ���� 13
          inc  hl           ;
          ld   (POZIC),hl   ;
          jr   PR0          ;

PR2     cp 12
          jr   nz,PR3       ; ��� - 12
          inc  hl           ;
          ld   a,(hl)       ; ���������
          ld   (CLR),a      ; �����
          inc  hl           ; ���� 13
          inc  hl           ;
          ld   (POZIC),hl   ;
          jr   PR0          ;

PR3     cp 13               ; �������
          jr   nz,PR4       ; ������
          ld   a,(TABPOS)   ; X = TAB
          ld   (ATX),a      ;
          ld   a,(ATY)      ; Y = Y+1
          inc  a            ;
          ld   (ATY),a      ;
          inc  hl           ;
          ld   (POZIC),hl   ;
          jr   PR0          ;

PR4     cp 14
          jr   nz,PRSIM
          inc  hl
          ld   a,(hl)
          ld   (PAUSPR),a
          inc  hl          ;���� 13
          inc  hl
          ld   (POZIC),hl
          jr   PR0

PRSIM   push af          ; ���������
        ld   a,(PAUSPR)  ; ������
        cp   7           ; �����, ����
        jr   z,PRSIM0    ; 7 �� �������
        ld   b,0         ; ����� ���
        ld   c,a         ;
        call 7997

PRSIM0  pop  af
        push hl
        ld   de,(NABOR)    ;----------
        ld   h,0           ;
        ld   l,a           ;
        add  hl,hl         ;����� �����
        add  hl,hl         ;������� �
        add  hl,hl         ;�����
        add  hl,de         ;
        push hl            ;----------

        ld   de,(ATY)      ;������ �
        ld   a,e           ;X � Y
        and  #18           ;
        or   #40           ;
        ld   h,a           ;���������
        ld   a,e           ;����� �
        and  7             ;������ ��
        or   a             ;����������
        rra                ;����������
        rra                ;
        rra                ;
        rra                ;
        add  a,d           ;
        ld   l,a           ;----------

        pop  de            ;
        ld   b,8           ;
PRSIM1  ld   a,(de)        ;����������
        ld   (hl),a        ;����
        inc  de            ;������
        inc  h             ;
        djnz PRSIM1        ;----------

        ld   de,(ATY)      ;----------
        ld   a,e           ;
        and  #18           ;
        srl  a             ; �����
        srl  a             ; ����� �
        srl  a             ; ���������
        or   #58           ;
        ld   h,a           ; ���������
        ld   a,e           ; ��� �
        and  7             ; hl
        or   a             ;
        rra                ;
        rra                ;
        rra                ;
        rra                ;
        add  a,d           ;
        ld   l,a           ;----------

        ld   a,(CLR)       ; ���� 0 ��
        cp   0             ; ������
        jr   z,PRSIM2      ; ����� ������
        ld   (hl),a        ; ����

PRSIM2  pop hl
        inc hl
        ld  (POZIC),hl
        ld  a,(ATX)
        inc a
        ld  (ATX),a
        jp   PR0           ;-----------


;======================================
;     ��������� ������ �������
;======================================
PTSP   ld   hl,(SPADR)
       ld   (PTADR),hl
       ld   a,(SPWS)
       ld   b,a      ;������� �� ������
       push bc
       ld   de,(SPY) ; d-X, e-Y �����

PTSP1  call GETADR
       push de
       ld   b,8      ; ���� �� 8 �����

PTSP2  push hl
       push bc
       ld   bc,(SPX) ; � b ������ SPDL
       ld   de,(PTADR)

PTSP3  ld   a,(de)
       ld   (hl),a
       inc  de
       inc  hl
       djnz PTSP3

       ld   (PTADR),de
       pop  hl
       inc  h    ;���������� ������ +1
       pop  bc
       djnz PTSP2

       pop  de
       inc  e    ;Y ���������� +1
       pop  bc
       djnz PTSP1

; ---------- ����� ��������� -------
       ret

PTADR  defb 0,0


;======================================
;   ��������� ����������� ������
;   � �������� ����� �� ����� de
;      �� ������ � hl - �����
;======================================
GETADR   ld   a,e
         and  #18
         or   #40
         ld   h,a
         ld   a,e
         and  07
         or   a
         rra
         rra
         rra
         rra
         add  a,d
         ld   l,a
         ret


;======================================
;   ��������� ����������� ������
;   � ����� ��������� �� ����� de
;      �� ������ � hl - �����
;======================================
GETATR  ld   a,e
        and  #18
        srl  a
        srl  a
        srl  a
        or   #58
        ld   h,l
        ld   a,e
        and  07
        or   a
        rra
        rra
        rra
        rra
        add  a,d
        ld   l,a
        ret


;=======================================
FILE00 defb "MYFONT01C"
FILE01 defb "TEXT-000C"
