;�====================================�
;�          ������ ���������          �-
;� (�������� ������ � �������������)  �-
;L====================================--
; --------------------------------------

;-------------- COD ##00 ---------------
;    ��������� ��������� ����������
;          ������������� ����

COD00  inc hl              ;�� ������
       ld   a,2
       ld   (RAZR),a 

       inc hl : call CONV
       ld  (COLW),a        ;X �����

       inc hl : call CONV
       ld   (ROWW),a       ;Y �����

       inc hl : call CONV
       ld  (LENW),a        ;������

       inc hl : call CONV
       ld  (HGTW),a        ;������

       ld  a,3
       ld  (RAZR),a 
       inc hl : call CONV
       ld  (ATRW),a        ;����

       inc hl : call CONV
       ld  (RAMW),a        ;��� �����

       ld   a,2
       ld   (RAZR),a 
       inc hl : call CONV
       ld  (ATX42),a       ;X ������
       ld  (TBP42),a
       ld  (ATX),a 

       inc hl : call CONV
       ld  (ATY42),a       ;Y ������
       ld  (ATY),a 

       ret 


;-------------- COD ##01 ---------------
;    ��������� ������� ����� ����

COD01  ld   bc,(LENW)
       ld   a,(ROWW)
CLRW1  push af 
       push bc 
       call 3742
       ld   a,(COLW)
       add  a,l 
       ld   l,a 
       ld   b,8
CLRW2  push hl 
       ld   e,c 
       xor  a 
CLRW3  ld   (hl),a 
       inc  hl 
       dec  e 
       jr   nz,CLRW3
       pop  hl 
       inc  h 
       djnz CLRW2
       pop  bc 
       pop  af 
       inc  a 
       djnz CLRW1

       ld  a,(ATX)
       ld  (ATX42),a 
       ld  (TBP42),a 
       ld  a,(ATY)
       ld  (ATY42),a 

       ret 

;-------------- COD ##02 ---------------
;    ��������� ������� ������ ����

COD02  ld   bc,(LENW)
       dec  b        ; ������ -2
       dec  b        ; ������ -2
       dec  c
       dec  c 
       ld   a,(ROWW)
       inc  a         ;!!
CD021  push af 
       push bc 
       call 3742
       ld a,(COLW)
       inc a          ;!!
       add a,l 
       ld l,a 
       ld b,8
CD022  push hl 
       ld e,c 
       xor a 
CD023  ld (hl),a 
       inc hl 
       dec e 
       jr nz,CD023
       pop hl 
       inc h 
       djnz CD022
       pop bc 
       pop af 
       inc a 
       djnz CD021

       ld  a,(ATX)
       ld  (ATX42),a 
       ld  (TBP42),a 
       ld  a,(ATY)
       ld  (ATY42),a 

       ret 


;-------------- COD ##03 ---------------
;      ������� ����� ���� ������

COD03  ld de,#5800
       ld bc,(LENW)
       ld a,(ROWW)
       ld l,a 
       ld h,0
       add hl,hl : add hl,hl 
       add hl,hl : add hl,hl 
       add hl,hl : add hl,de 
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


;-------------- COD ##04 ---------------
;   ��������� ��������� ����� ����

COD04
       ld  a,(RAMW)
       cp  0
       ret z 
       ld  (RAMWT),a 

       ld  a,(COLW)
       ld  (XWINT),a 
       ld  a,(ROWW)
       ld  (YWINT),a 
       ld  a,(LENW)
       dec a : dec a 
       ld  (DLINT),a 
       ld  a,(HGTW)
       dec a : dec a 
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
COD042 push bc         ;
       ld   a,(XWINT)  ;  ����� �������
       inc  a          ;
       ld   (XWINT),a  ;
       ld   a,(RAMWT)  ;
       call PRRAMW     ;
       pop  bc         ;
       djnz COD042     ;

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
COD043 push bc         ;
       ld   a,(YWINT)  ;
       inc  a          ;
       ld   (YWINT),a  ;
       ld   a,(RAMWT)  ;
       call PRRAMW     ;
       pop  bc         ;
       djnz COD043     ;

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
COD044 push bc         ;
       ld   a,(XWINT)  ;
       dec  a          ;
       ld   (XWINT),a  ;
       ld   a,(RAMWT)  ;
       call PRRAMW     ;
       pop  bc         ;
       djnz COD044     ;

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
COD045 push bc         ;
       ld   a,(YWINT)  ;
       dec  a          ;
       ld   (YWINT),a  ;
       ld   a,(RAMWT)  ;
       call PRRAMW     ;
       pop  bc         ;
       djnz COD045     ;

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
COD041 ld   a,(de)        ;����������
       ld   (hl),a        ;����
       inc  de            ;������
       inc  h             ;
       djnz COD041        ;----------
       ret 

XWINT  defb 0
YWINT  defb 0
WISTT  defb 0
DLINT  defb 0
RAMWT  defb 0

