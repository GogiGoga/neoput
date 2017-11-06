

;======================================
;           �������� ������
;======================================
RAM    push bc
       ld   a,b
       ld   (BANK_1),a
       add  a,16
       ld   bc,#7FFD
       out  (c),a
       pop  bc
       ret

BANK_1   defb 0


;======================================
;      �������� ����� �� ��� �����
;======================================
LOAD    di

        ld   c,#13
        call #3D13

        ld   a,9
        ld   (23814),a
        ld   c,#0A
        call #3D13

        ld   a,c
        ld   c,#08
        call #3D13

        ld   hl,(LDADR)
        ld   de,(#5CEB)
        ld   a,(#5CEA)
        ld   b,a
        ld   c,5
        call #3D13
        ei
        ret

LDADR   defb 0,0


;======================================
;     ��������� ����������� ������
;   � �������� ����� ��  �����������
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
;     ��������� ����������� ������
;   � ����� ��������� �� �����������
;======================================
GETATR  ld   a,e
        and  #18
        srl  a
        srl  a
        srl  a
        or   #58
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
;             CUT SPRAIT
;    ��������� ������� �������
;          (���������� ����)
;======================================
CTSP   ld   hl,(SPADR)
       ld   (PTADR),hl
       ld   de,(SPY) ; d-X, e-Y �����
       ld   a,(SPWS)
       ld   b,a      ;������� �� ������

CTSP1  push bc
       call GETADR
       push de
       ld   b,8      ; ���� �� 8 �����

CTSP2  push bc
       push hl
       ld   bc,(SPX) ; � b ������ SPDL
       ld   de,(PTADR)

CTSP3  ld   a,(hl)
       ld   (de),a
       inc  de
       inc  hl
       djnz CTSP3

       ld   (PTADR),de
       pop  hl
       inc  h    ;���������� ������ +1
       pop  bc
       djnz CTSP2

       pop  de
       inc  e    ;Y ���������� +1
       pop  bc
       djnz CTSP1

; -------- ������� ��������� -------
       ld   de,(SPY)  ;d-X, e-Y �����
       ld   a,(SPWS)
       ld   b,a       ;������� �� ������

CTSP4  push bc
       push de
       call GETATR

       ld   bc,(SPX)  ;� b ������ SPDL
       ld   de,(PTADR)
CTSP5  ld   a,(hl)
       ld   (de),a
       inc  de
       inc  hl
       djnz CTSP5

       ld   (PTADR),de
       pop  de
       inc  e
       pop  bc
       djnz CTSP4

       ld   de,(PTADR)
       ld   (SPLST),de

       ret


;======================================
;             PUT SPRAIT
;       ��������� ������ �������
;======================================
PTSP   ld   hl,(SPADR)
       ld   (PTADR),hl
       ld   de,(SPY) ; d-X, e-Y �����
       ld   a,(SPWS)
       ld   b,a      ;������� �� ������

PTSP1  push bc
       call GETADR
       push de
       ld   b,8      ; ���� �� 8 �����

PTSP2  push bc
       push hl
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
       ld   a,(SPREJ)
       cp   0: ret z  ;��� ���� �� ����

       ld   de,(SPY)  ;d-X, e-Y �����
       ld   a,(SPWS)
       ld   b,a       ;������� �� ������

PTSP4  push bc
       push de
       call GETATR

       ld   bc,(SPX)  ;� b ������ SPDL
       ld   de,(PTADR)
PTSP5  ld   a,(de)
       ld   (hl),a
       inc  de
       inc  hl
       djnz PTSP5

       ld   (PTADR),de
       pop  de
       inc  e
       pop  bc
       djnz PTSP4

       ret

SPREJ  defb 0
SPADR  defb 0,0
SPY    defb 0
SPX    defb 0
SPDL   defb 0
SPWS   defb 0
SPLST  defb 0,0
PTADR  defb 0,0


;======================================
;    ��������� ���������� ��������
;          (FADE_IN EFFEKT)
;======================================
FI    xor  a         ;������ �������
      ld   hl,#5800  ;��������� ������
      ld   (hl),a    ;INK � PAPER
      ld   de,#5801  ;
      ld   bc,767    ;
      ldir           ;

      ld   hl,(BUFF) ;������ ��������
      ld   de,#4000  ;�� ������� ��
      ld   bc,6144   ;����� ���� ���
      ldir           ;�����

      ld   (BUFF),hl ;������ hl �����
                     ;�� ������ ������-
                     ;���, ��������� ���
                     ;� BUFF

      ld   b,7
FI1   halt
      ld   hl,22000  ;�����
FI1P  dec  hl        ;++++
      ld   a,l       ;+++
      or   h         ;++
      jr   nz,FI1P   ;+
      ld   hl,(BUFF)
      ld   (BUFF2),hl
      ld   hl,#5800
FI2   push hl
      ld   hl,(BUFF2)
      ld   c,(hl)
      ld   a,c
      and  #38
      ld   d,a
      ld   a,c
      and  7
      ld   e,a
      inc  hl
      ld   (BUFF2),hl
      pop hl
      ld   a,(hl)
      and  #38
      cp   d
      jr   nc,FI3
      add  a,8
      ld   d,a
FI3   ld   a,(hl)
      and  7
      cp   e
      jr   nc,FI4
      inc  a
      ld   e,a
FI4   ld   a,c
      and  #C0
      or   d
      or   e
      ld   (hl),a
      inc  hl
      ld   a,h
      cp   #5B
      jr   nz,FI2
      djnz FI1
      ret

BUFF  defb 0,0
BUFF2 defb 0,0


;======================================
;      ��������� ������� ��������
;          (FADE_OUT EFFEKT)
;======================================
FO    ld   b,7
FO01  halt
      ld   hl,22000
FO02  dec  hl
      ld   a,l
      or   h
      jr   nz,FO02
      ld   hl,22528
FO03  ld   a,(hl)
      and  56
      jr   z,FO04
      sub  8
FO04  ld   c,a
      ld   a,(hl)
      and  7
      jr   z,FO05
      dec  a
FO05  or   c
      ld   (hl),a
      inc  hl
      ld   a,h
      cp   91
      jr   nz,FO03
      djnz FO01
      ret


;======================================
;      ��������� ������� ������ �
;    ��������� ���  ��������� (CLS)
;======================================
CLS    xor  a
       ld   hl,#4000
       ld   (hl),a
       ld   de,#4001
       ld   bc,6144
       ldir

       ld   a,(CLSATR)
       ld   hl,22528
       ld   (hl),a
       ld   de,22529
       ld   bc,768
       ldir
       ret
CLSATR defb 0


;======================================
;       ��������� ��������������
;      ���������� ������  � �����
;======================================
CONV   ld bc,0
       ld (CONVR),bc

       ld a,(RAZR)  ;����� ����� ������
       cp 5         ;��� �������������
       jr z,CNV5    ;���������� ��������
       cp 4         ;�����
       jr z,CNV4
       cp 3
       jr z,CNV3
       cp 2
       jr z,CNV2
       cp 1
       jr z,CNV1

CNV5   ld bc,10000
       call CNVOSN

CNV4   ld bc,1000
       call CNVOSN

CNV3   ld bc,100
       call CNVOSN

CNV2   ld bc,10
       call CNVOSN

CNV1   ld bc,1
       call CNVOSN
       ret        ;����� �� ���������

CNVOSN push hl
       ld  a,(hl) ;����� ����� �� ������
       sub 48     ;�������� �� ��������
       ld  e,a    ;� de �������� �����
       ld  d,0    ;�� ������
       ld  h,b    ;� hl �������� �����-
       ld  l,c    ;���� �������
       call 12457 ;������ de �� hl
       ld  de,(CONVR)
       add hl,de
       ld  (CONVR),hl
       ld  d,h
       ld  e,l
       ld  a,l
       pop hl
       inc hl     ;�� ������ hl �����
       ret        ;��������� �� "," ���
                  ;������� ������
RAZR   defb 0
CONVR  defb 0,0


;======================================
;         ��������� ����� 8)
;======================================
PAUSE   xor a
        ld  (23560),a
PAU1    ld  a,(23560)
        cp  0
        jr  z,PAU1
        ret
