;�====================================�
;�          ������ ���������          �
;� (�������� ������ � �������������)  �
;L====================================-
FLAG  equ 37900

      ent 26000
      org 26000

      xor  a          ;��������
      ld   (CLSATR),a ;�����
      call CLS        ;

      ld   hl,44000   ;
      ld   (LDADR),hl ;���������
      ld   hl,FILEZ1  ;�������� #1
      call LOAD       ;

      ld   hl,51000   ;
      ld   (LDADR),hl ;���������
      ld   hl,FILEZ2  ;�������� #2
      call LOAD       ;

      ld   hl,58000   ;
      ld   (LDADR),hl ;���������
      ld   hl,FILEZ3  ;�������� #3
      call LOAD       ;

      ld   b,4
      call RAM

      ld   hl,#C000   ;
      ld   (LDADR),hl ;���������
      ld   hl,FILEZ4  ;����
      call LOAD       ;

      ld   hl,57000   ;
      ld   (LDADR),hl ;���������
      ld   hl,FILEOS  ;��� �����
      call LOAD       ;

      ld   b,3
      call RAM

      ld   hl,#C000   ;
      ld   (LDADR),hl ;���������
      ld   hl,FILEZ5  ;���������
      call LOAD       ;�������

      ld   b,0
      call RAM

      ld   hl,44000
      ld   (BUFF),hl 
      call FI :call PAUSE :call FO

      ld   hl,51000
      ld   (BUFF),hl 
      call FI :call PAUSE :call FO

      ld   hl,58000
      ld   (BUFF),hl 
      call FI :call PAUSE :call FO

      ld  hl,0        ;���� ����������
      ld  (WINBF1),hl ;��� ������� ����
      ld  (WINBF2),hl ;����� 0-���,���
      ld  (WINBF3),hl ;������ #C000

      xor a           ;
      ld  hl,32768    ;�������� ���
      ld  (hl),a      ;������ ���
      ld  de,32769    ;������
      ld  bc,32766    ;
      ldir            ;

      ld   hl,47000   ;������ �����
      ld   (NABOR),hl ;������ � ����-
      ld   (LDADR),hl ;���� ��� � ����
      ld   hl,FILE01  ;�����
      call LOAD

      ld   hl,#C000   ;���������� �����-
      ld   (POZGL),hl ;���� � �����
      ld   (LDADR),hl ;���� �� ������ �
      ld   hl,FILE03  ;���������
      call LOAD       ;���� ���� #00

;�====================================�
;�      �������� ���� ���������       �
;L====================================-

;------ ���������� ������� ����� ------
;------  � ����� ��������� ����  ------

GLV00   ld hl,(POZGL)
        ld de,#8000
GLV01   ld a,(hl) 
        cp #FE
        jr z,GLV02
        ld (de),a 
        inc hl
        inc de 
        jr  GLV01

GLV02   ld  (de),a 
        ld  de,#8000
        ld  (POZIC),de 


;�====================================�
;�    ���� ��������� ������� �����    �
;�   (����������� ����������� �����)  �
;L====================================-

OSN00 ;WWN - Work WiNdow ++++++++++++++
      ld  hl,(POZIC) : ld  a,(hl) 
      cp  "W" : jr nz,OSN01
      inc hl  : ld  a,(hl) 
      cp  "W" : jr nz,OSN01
      inc hl  : ld  a,(hl) 
      cp  "N" : jr nz,OSN01

              call COD00
              inc hl     ;�� ������� ���
              ld  (POZIC),hl 
              jp  OSN00

OSN01 ;WC1 - Window Clear1 +++++++++++++
      ld hl,(POZIC) : ld  a,(hl) 
      cp  "W" : jr nz,OSN02
      inc hl  : ld  a,(hl) 
      cp  "C" : jr nz,OSN02
      inc hl  : ld  a,(hl) 
      cp  "1" : jr nz,OSN02

              inc hl         ;����� ����
              inc hl         ;���� �� ��
              ld  (POZIC),hl ;��������
              call COD01     ;���
              jp  OSN00

OSN02 ;WC2 - Window Clear2 +++++++++++++
      ld hl,(POZIC) : ld  a,(hl) 
      cp  "W" : jr nz,OSN03
      inc hl  : ld  a,(hl) 
      cp  "C" : jr nz,OSN03
      inc hl  : ld  a,(hl) 
      cp  "2" : jr nz,OSN03

              inc hl         ;����� ����
              inc hl         ;���� �� ��
              ld  (POZIC),hl ;��������
              call COD02     ;���
              jp  OSN00

OSN03 ;WCL - Window Color  +++++++++++++
      ld hl,(POZIC) : ld  a,(hl) 
      cp  "W" : jr nz,OSN04
      inc hl  : ld  a,(hl) 
      cp  "C" : jr nz,OSN04
      inc hl  : ld  a,(hl) 
      cp  "L" : jr nz,OSN04

              inc hl         ;����� ����
              inc hl         ;���� �� ��
              ld  (POZIC),hl ;��������
              call COD03     ;���
              jp  OSN00

OSN04 ;WRM - Window Ramka  +++++++++++++
      ld hl,(POZIC) : ld  a,(hl) 
      cp  "W" : jr nz,OSN05
      inc hl  : ld  a,(hl) 
      cp  "R" : jr nz,OSN05
      inc hl  : ld  a,(hl) 
      cp  "M" : jr nz,OSN05

              inc hl         ;����� ����
              inc hl         ;���� �� ��
              ld  (POZIC),hl ;��������
              call COD04     ;���
              jp  OSN00

OSN05 ;WCT - Window CuT  +++++++++++++++
      ld hl,(POZIC) : ld  a,(hl) 
      cp  "W" : jr nz,OSN06
      inc hl  : ld  a,(hl) 
      cp  "C" : jr nz,OSN06
      inc hl  : ld  a,(hl) 
      cp  "T" : jr nz,OSN06

              inc hl         ;����� ����
              inc hl         ;���� �� ��
              ld  (POZIC),hl ;��������
              call COD05     ;���
              jp  OSN00

OSN06 ;WST - Window set  +++++++++++++++
      ld hl,(POZIC) : ld  a,(hl) 
      cp  "W" : jr nz,OSN07
      inc hl  : ld  a,(hl) 
      cp  "S" : jr nz,OSN07
      inc hl  : ld  a,(hl) 
      cp  "T" : jr nz,OSN07

              inc hl         ;����� ����
              inc hl         ;���� �� ��
              ld  (POZIC),hl ;��������
              call COD06     ;���
              jp  OSN00

OSN07 ;WPT - Window PuT  +++++++++++++++
      ld hl,(POZIC) : ld  a,(hl) 
      cp  "W" : jr nz,OSN08
      inc hl  : ld  a,(hl) 
      cp  "P" : jr nz,OSN08
      inc hl  : ld  a,(hl) 
      cp  "T" : jr nz,OSN08

              inc hl         ;����� ����
              inc hl         ;���� �� ��
              ld  (POZIC),hl ;��������
              call COD07     ;���
              jp  OSN00


OSN08 ;WN1 - Window #1  +++++++++++++++
      ld hl,(POZIC) : ld  a,(hl) 
      cp  "W" : jr nz,OSN09
      inc hl  : ld  a,(hl) 
      cp  "N" : jr nz,OSN09
      inc hl  : ld  a,(hl) 
      cp  "1" : jr nz,OSN09

              inc hl         ;����� ����
              inc hl         ;���� �� ��
              ld  (POZIC),hl ;��������
              call COD08     ;���
              jp  OSN00


OSN09 ;W2O - Window 2 Open +++++++++++++
      ld hl,(POZIC) : ld  a,(hl) 
      cp  "W" : jr nz,OSN10
      inc hl  : ld  a,(hl) 
      cp  "2" : jr nz,OSN10
      inc hl  : ld  a,(hl) 
      cp  "O" : jr nz,OSN10

              inc hl         ;����� ����
              inc hl         ;���� �� ��
              ld  (POZIC),hl ;��������
              call COD09     ;���
              jp  OSN00


OSN10 ; ";"- �����������  ++++++++++++++
      ld hl,(POZIC) : ld  a,(hl) 
      cp  ";" : jr nz,OSN11

OSN101        inc hl 
              ld  a,(hl)
              cp  13
              jr  nz,OSN101
              inc hl 
              ld  (POZIC),hl 
              jp   OSN00


OSN11 ; ������� ������  ++++++++++++++++
      ld hl,(POZIC) : ld  a,(hl) 
      cp 13   : jr nz,OSN12

              inc  hl
              ld   (POZIC),hl 
              jp   OSN00


OSN12 ;BNK - BaNK  +++++++++++++++++++++
      ld hl,(POZIC) : ld  a,(hl) 
      cp  "B" : jr nz,OSN13
      inc hl  : ld  a,(hl) 
      cp  "N" : jr nz,OSN13
      inc hl  : ld  a,(hl) 
      cp  "K" : jr nz,OSN13

              inc  hl ;������� ������
              inc  hl 
              ld   a,(hl)
              sub  48
              ld   b,a 
              inc  hl ;���� ������� ���
              inc  hl 
              ld   (POZIC),hl 
              call RAM
              jp   OSN00

OSN13 ;PAU - PAUSE  ++++++++++++++++++++
      ld hl,(POZIC) : ld  a,(hl) 
      cp  "P" : jr nz,OSN14
      inc hl  : ld  a,(hl) 
      cp  "A" : jr nz,OSN14
      inc hl  : ld  a,(hl) 
      cp  "U" : jr nz,OSN14

              inc hl ; ���� ����� ���
              inc hl 
              ld (POZIC),hl 
              call PAUSE
              jp OSN00


OSN14 ;TXT - TeXT  +++++++++++++++++++++
      ld hl,(POZIC) : ld  a,(hl) 
      cp  "T" : jr nz,OSN15
      inc hl  : ld  a,(hl) 
      cp  "X" : jr nz,OSN15
      inc hl  : ld  a,(hl) 
      cp  "T" : jr nz,OSN15

              inc hl       ;�����
              inc hl 
              ld (POZIC),hl 
              call COD14
              jp OSN00

OSN15 ;CLS - Clear Screen  +++++++++++++
      ld hl,(POZIC) : ld  a,(hl) 
      cp  "C" : jr nz,OSN16
      inc hl  : ld  a,(hl) 
      cp  "L" : jr nz,OSN16
      inc hl  : ld  a,(hl) 
      cp  "S" : jr nz,OSN16

              inc hl  ;���� ������
              inc hl
              ld  a,3
              ld  (RAZR),a 
              call CONV
              ld  (CLSATR),a 
              inc hl         ;���
              ld (POZIC),hl 
              call CLS
              jp OSN00


OSN16 ;FDI - FaDe in  ++++++++++++++++++
      ld hl,(POZIC) : ld  a,(hl) 
      cp  "F" : jr nz,OSN17
      inc hl  : ld  a,(hl) 
      cp  "D" : jr nz,OSN17
      inc hl  : ld  a,(hl) 
      cp  "I" : jr nz,OSN17

              inc hl ;������� �� ������
              inc hl ;������� �� �����
              ld  a,5
              ld  (RAZR),a 
              call CONV
              inc hl
              ld  (POZIC),hl
              ld  hl,(CONVR)
              ld  (BUFF),hl 
              call FI
              jp   OSN00


OSN17 ;FDO - FaDe out  +++++++++++++++++
      ld hl,(POZIC) : ld  a,(hl) 
      cp  "F" : jr nz,OSN18
      inc hl  : ld  a,(hl) 
      cp  "D" : jr nz,OSN18
      inc hl  : ld  a,(hl) 
      cp  "O" : jr nz,OSN18

              inc  hl ;���
              inc  hl 
              ld   (POZIC),hl 
              call FO
              jp   OSN00


OSN18 ;CSP - Cut SPait  ++++++++++++++++
      ld hl,(POZIC) : ld  a,(hl) 
      cp  "C" : jr nz,OSN19
      inc hl  : ld  a,(hl) 
      cp  "S" : jr nz,OSN19
      inc hl  : ld  a,(hl) 
      cp  "P" : jr nz,OSN19

              call COD18
              inc hl     ;�� ������� ���
              ld  (POZIC),hl 
              jp  OSN00


OSN19 ;PSP - Put SPait  ++++++++++++++++
      ld hl,(POZIC) : ld  a,(hl) 
      cp  "P" : jr nz,OSN20
      inc hl  : ld  a,(hl) 
      cp  "S" : jr nz,OSN20
      inc hl  : ld  a,(hl) 
      cp  "P" : jr nz,OSN20

              call COD19
              inc hl     ;�� ������� ���
              ld  (POZIC),hl 
              jp  OSN00


OSN20 ;SP1 - SPait #1 ++++++++++++++++++
      ld hl,(POZIC) : ld  a,(hl) 
      cp  "S" : jr nz,OSN21
      inc hl  : ld  a,(hl) 
      cp  "P" : jr nz,OSN21
      inc hl  : ld  a,(hl) 
      cp  "1" : jr nz,OSN21

              call COD20
              inc hl     ;�� ������� ���
              ld  (POZIC),hl 
              jp  OSN00


OSN21 ;SP2 - SPait #2 ++++++++++++++++++
      ld hl,(POZIC) : ld  a,(hl) 
      cp  "S" : jr nz,OSN22
      inc hl  : ld  a,(hl) 
      cp  "P" : jr nz,OSN22
      inc hl  : ld  a,(hl) 
      cp  "2" : jr nz,OSN22

              call COD21
              inc hl     ;�� ������� ���
              ld  (POZIC),hl 
              jp  OSN00


OSN22 ;LDF - LOAD FILE +++++++++++++++++
      ld hl,(POZIC) : ld  a,(hl) 
      cp  "L" : jr nz,OSN23
      inc hl  : ld  a,(hl) 
      cp  "D" : jr nz,OSN23
      inc hl  : ld  a,(hl) 
      cp  "F" : jr nz,OSN23

              call COD22
              inc hl     ;�� ������� ���
              ld  (POZIC),hl 
              jp  OSN00


OSN23 ;JMP - JUMP ++++++++++++++++++++++
      ld hl,(POZIC) : ld  a,(hl) 
      cp  "J" : jr nz,OSN24
      inc hl  : ld  a,(hl) 
      cp  "M" : jr nz,OSN24
      inc hl  : ld  a,(hl) 
      cp  "P" : jr nz,OSN24

            call COD23
            jp   GLV00  ;!!!!!-GLV!!!


OSN24 ;VIB - VIBOR +++++++++++++++++++++
      ld hl,(POZIC) : ld  a,(hl) 
      cp  "V" : jr nz,OSN25
      inc hl  : ld  a,(hl) 
      cp  "I" : jr nz,OSN25
      inc hl  : ld  a,(hl) 
      cp  "B" : jr nz,OSN25

            inc  hl ;������� �� ������
            inc  hl ;�� ���������� �������� ������
            call COD24
            jp   GLV00  ;!!!!!-GLV!!!

OSN25 ;W2C - Window 2 Close ++++++++++++
      ld hl,(POZIC) : ld  a,(hl) 
      cp  "W" : jr nz,OSN26
      inc hl  : ld  a,(hl) 
      cp  "2" : jr nz,OSN26
      inc hl  : ld  a,(hl) 
      cp  "C" : jr nz,OSN26

              inc hl         ;����� ����
              inc hl         ;���� �� ��
              ld  (POZIC),hl ;��������
              call COD25     ;���
              jp  OSN00

OSN26 ;W3O - Window 3 Open +++++++++++++
      ld hl,(POZIC) : ld  a,(hl) 
      cp  "W" : jr nz,OSN27
      inc hl  : ld  a,(hl) 
      cp  "3" : jr nz,OSN27
      inc hl  : ld  a,(hl) 
      cp  "O" : jr nz,OSN27

              inc hl         ;����� ����
              inc hl         ;���� �� ��
              ld  (POZIC),hl ;��������
              call COD26     ;���
              jp  OSN00

OSN27 ;W2C - Window 3 Close ++++++++++++
      ld hl,(POZIC) : ld  a,(hl) 
      cp  "W" : jr nz,OSN28
      inc hl  : ld  a,(hl) 
      cp  "3" : jr nz,OSN28
      inc hl  : ld  a,(hl) 
      cp  "C" : jr nz,OSN28

              inc hl         ;����� ����
              inc hl         ;���� �� ��
              ld  (POZIC),hl ;��������
              call COD27     ;���
              jp  OSN00

OSN28 ;FON - FlagON ++++++++++++++++++++
      ld hl,(POZIC) : ld  a,(hl) 
      cp  "F" : jr nz,OSN29
      inc hl  : ld  a,(hl) 
      cp  "O" : jr nz,OSN29
      inc hl  : ld  a,(hl) 
      cp  "N" : jr nz,OSN29

              call COD28
              inc  hl
              ld   (POZIC),hl 
              jp  OSN00

OSN29 ;JMF - JaMpFlag ++++++++++++++++++
      ld hl,(POZIC) : ld  a,(hl) 
      cp  "J" : jr nz,OSN30
      inc hl  : ld  a,(hl) 
      cp  "M" : jr nz,OSN30
      inc hl  : ld  a,(hl) 
      cp  "F" : jr nz,OSN30

              call COD29
              ld   (POZIC),hl 
              jp   GLV00  ;!!!!!-GLV!!!


OSN30 ;W4O - WIN4OPEN ++++++++++++++++++
      ld hl,(POZIC) : ld  a,(hl) 
      cp  "W" : jr nz,OSN31
      inc hl  : ld  a,(hl) 
      cp  "4" : jr nz,OSN31
      inc hl  : ld  a,(hl) 
      cp  "O" : jr nz,OSN31

              inc hl         ;����� ����
              inc hl         ;���� �� ��
              ld  (POZIC),hl ;��������
              call COD30     ;���
              jp  OSN00

OSN31 ;W4C - WIN4CLOSE +++++++++++++++++
      ld hl,(POZIC) : ld  a,(hl) 
      cp  "W" : jr nz,OSN32
      inc hl  : ld  a,(hl) 
      cp  "4" : jr nz,OSN32
      inc hl  : ld  a,(hl) 
      cp  "C" : jr nz,OSN32

              inc hl         ;����� ����
              inc hl         ;���� �� ��
              ld  (POZIC),hl ;��������
              call COD31     ;���
              jp  OSN00

OSN32 ;FOF - FlagOFF +++++++++++++++++++
      ld hl,(POZIC) : ld  a,(hl) 
      cp  "F" : jr nz,OSN33
      inc hl  : ld  a,(hl) 
      cp  "O" : jr nz,OSN33
      inc hl  : ld  a,(hl) 
      cp  "F" : jr nz,OSN33

              call COD32
              inc  hl
              ld   (POZIC),hl 
              jp   OSN00

OSN33 ;VIN - VICTORI !!! ++++++++++++++
      ld hl,(POZIC) : ld  a,(hl) 
      cp  "V" : jr nz,OSN34
      inc hl  : ld  a,(hl) 
      cp  "I" : jr nz,OSN34
      inc hl  : ld  a,(hl) 
      cp  "N" : jr nz,OSN34

              inc hl         ;����� ����
              inc hl         ;���� �� ��
              ld  (POZIC),hl ;��������
              call COD33     ;���
              jp  OSN00

OSN34 ret 

;�====================================�
;����� ������������ ����������� ����� �
;L====================================-

;    COD00-COD04 ��������� � bib02.C

;-------------- COD ##05 ---------------
;  ��������� ��������� ���� ��� �����

COD05  ld   a,(BANK)
       ld   (RAMTMP),a 
       ld   b,7
       call RAM

       ld   a,(COLW) : ld (SPX),a 
       ld   a,(ROWW) : ld (SPY),a 
       ld   a,(LENW) : ld (SPDL),a 
       ld   a,(HGTW) : ld (SPWS),a 

       ld   a,(WINNMB)
       cp   1
       jr   z,COD051
       cp   2
       jr   z,COD052
       cp   3
       jr   z,COD053

       ld   hl,(WINBF0)
       ld   (SPADR),hl
       call CTSP
       xor  a
       inc  a
       ld   (WINNMB),a
       ld   hl,(SPLST)
       ld   (WINBF1),hl
       ld   a,(RAMTMP)
       ld   b,a
       call RAM
       ret 

COD051 ld   hl,(WINBF1)
       ld   (SPADR),hl
       call CTSP
       ld   a,(WINNMB)
       inc  a 
       ld   (WINNMB),a
       ld   hl,(SPLST)
       ld   (WINBF2),hl
       ld   a,(RAMTMP)
       ld   b,a
       call RAM
       ret 

COD052 ld   hl,(WINBF2)
       ld   (SPADR),hl
       call CTSP
       ld   a,(WINNMB)
       inc  a 
       ld   (WINNMB),a
       ld   hl,(SPLST)
       ld   (WINBF3),hl 
       ld   a,(RAMTMP)
       ld   b,a
       call RAM
       ret 

COD053 ld   hl,(WINBF3)
       ld   (SPADR),hl
       call CTSP
       ld   a,(WINNMB)
       inc  a 
       ld   (WINNMB),a
       ld   a,(RAMTMP)
       ld   b,a
       call RAM
       ret 

RAMTMP defb 0
WINNMB defb 0
WINBF0 defw #C000
WINBF1 defb 0,0
WINBF2 defb 0,0
WINBF3 defb 0,0


;-------------- COD ##06 ---------------
;    ��������� ������ ��������� ����

COD06  call COD01
       call COD03
       call COD04
       ret 


;-------------- COD ##07 ---------------
; ��������������� ����������� ��� ����

COD07  ld   a,(BANK)
       ld   (RAMTMP),a 
       ld   b,7
       call RAM

       ld   a,(COLW) : ld (SPX),a 
       ld   a,(ROWW) : ld (SPY),a 
       ld   a,(LENW) : ld (SPDL),a 
       ld   a,(HGTW) : ld (SPWS),a
       ld   a,#FE    : ld (SPREJ),a 

       ld   a,(WINNMB)
       cp   2
       jr   z,COD072
       cp   3
       jr   z,COD073
       cp   4
       jr   z,COD074

       ld   hl,(WINBF0)
       ld   (SPADR),hl
       call PTSP
       xor  a
       ld   (WINNMB),a
       ld   a,(RAMTMP)
       ld   b,a
       call RAM
       ret 

COD072 ld   hl,(WINBF1)
       ld   (SPADR),hl
       call PTSP
       ld   a,1
       ld   (WINNMB),a
       ld   a,(RAMTMP)
       ld   b,a
       call RAM
       ret 

COD073 ld   hl,(WINBF2)
       ld   (SPADR),hl
       call PTSP
       ld   a,2
       ld   (WINNMB),a
       ld   a,(RAMTMP)
       ld   b,a
       call RAM
       ret 

COD074 ld   hl,(WINBF3)
       ld   (SPADR),hl
       call PTSP
       ld   a,3
       ld   (WINNMB),a
       ld   a,(RAMTMP)
       ld   b,a
       call RAM
       ret 


;-------------- COD ##08 ---------------
;     ��������� ��������� ���� #1

COD08   ld  a,1
        ld  (COLW),a 
        ld  (ROWW),a 
        ld  a,16
        ld  (LENW),a 
        ld  a,21
        ld  (HGTW),a 
        ld  a,48
        ld  (ATRW),a
        ld  a,2
        ld  (ATX),a : ld (ATX42),a
        ld  (TBP42),a
        ld  a,1
        ld  (ATY),a : ld (ATY42),a 
        xor a 
        ld  (CLR42),a 
        call COD01
        call COD03
        ret 


;-------------- COD ##09 ---------------
;       ��������� ������ ���� #2
;   "��������" ��� ������ ��������

COD09 ld a,8 : ld (SPX),a  ;���������
      ld a,19: ld (SPY),a  ;�������
      ld a,3 : ld (SPDL),a ;���� #1
      ld a,1 : ld (SPWS),a ;27 ����
      ld hl,38000 : ld (SPADR),hl 
      call CTSP

      ld a,25: ld (SPX),a  ;���������
      ld a,2 : ld (SPY),a  ;�������
      ld a,2 : ld (SPDL),a ;���� #2
      ld a,2 : ld (SPWS),a ;36 ����
      ld hl,38030 : ld (SPADR),hl 
      call CTSP

      ld a,12 : ld (ATX42),a ;����������
                ld (TBP42),a ;������ ���
      ld a,4  : ld (ATY42),a ;������ �
      ld a,0  : ld (CLR42),a ;��� �����
      ld a,8  : ld (COLW),a  ;���� � ���
      ld a,2  : ld (ROWW),a  ;������ ���
      ld a,19 : ld (LENW),a  ;��� �����
      ld a,18 : ld (HGTW),a  ;����������
      call COD05             ;

      ld b,3 : call RAM
      ld a,1 : ld (SPREJ),a 
      ld hl,#C000 : ld (SPADR),hl 
      call PTSP

      ld a,8 : ld (SPX),a 
      ld a,19: ld (SPY),a 
      ld a,3 : ld (SPDL),a 
      ld a,1 : ld (SPWS),a 
      ld hl,38000 : ld (SPADR),hl 
      call PTSP

      ld a,25: ld (SPX),a 
      ld a,2 : ld (SPY),a 
      ld a,2 : ld (SPDL),a 
      ld a,2 : ld (SPWS),a 
      ld hl,38030 : ld (SPADR),hl 
      call PTSP

      ld b,0 : call RAM
      ret 


;-------------- COD ##14 ---------------
;  ��������� ������ ������ 42 �������

COD14 ld hl,(POZIC)      ;����� ������-
      ld a,(hl)          ;��� ������

      cp 27
         jr   nz,CD141   ;#1B-�����
         inc  hl         ;=���=
         inc  hl 
         ld   (POZIC),hl 
         ret             ;�����

CD141 cp 16              ;DLE
         jr   nz,CD142
         ld   a,2
         ld   (RAZR),a 
         inc  hl         ;���� ������
         inc  hl         ;�� X
         call CONV
         ld   (ATX42),a 
         ld   (TBP42),a 
         inc  hl         ;�� Y
         call CONV
         ld   (ATY42),a 
         inc  hl 
         ld   (POZIC),hl 
         jr   COD14

CD142 cp 17             ;#11-���������
         jr   nz,CD143  ;�����
         ld   a,3
         ld   (RAZR),a 
         inc  hl
         call CONV
         ld   (CLR42),a 
         inc  hl 
         ld   (POZIC),hl 
         jr   COD14

CD143 cp 13               ;�������
         jr   nz,PR42     ;������
         ld   a,(TBP42)   ;X = TAB
         ld   (ATX42),a   ;
         ld   a,(ATY42)   ;Y = Y+1
         inc  a 
         ld   (ATY42),a 
         inc  hl 
         ld   (POZIC),hl 
         jr   COD14

PR42     push hl 
         ld   l,a
         ld   h,0
         add  hl,hl
         add  hl,hl
         add  hl,hl
         ld   de,(NABOR)
         add  hl,de   ;����� ������
         push hl      ;� ������
CHECK    ld   de,(ATX42)
         ld   a,e 
         add  a,a
         ld   e,a
         add  a,a
         add   a,e 
         ld   e,255
         ld   l,8
CHPL1    inc  e
         sub  l
         jr   nc,CHPL1
         add  a,l
         ld   h,a
         ld   a,l
         sub  h
         ld   (SL1-1),a
         ld   (SL2-1),a
ADDRZ    ld   a,d
         and  #18
         add  a,#40
         ld   h,a
         ld   a,d
         and  7
         rrca
         rrca
         rrca 
         add a,e
         ld  l,a
         push hl 
AADDR    ld  a,h
         rrca
         rrca
         rrca
         and #03
         or  #58
         ld  h,a
ATTR     ld   a,(CLR42)   ; ���� 0 ��
         cp   0           ; ������
         jr   z,ATTR2     ; ����� ������
         ld   (hl),a      ; ����
ATTR2    pop  hl 
         pop  de 
         ld   c,8
SCRL     ld   a,(de) 
         ld   b,0
SL1      srl  (hl) 
         djnz SL1
         and  a
         ld   b,0
SL2      rl   a
         rl   (hl)
         djnz SL2
         inc  hl
         ld   (hl),a
         dec  hl
         inc  h
         inc  de 
         dec  c
         jr   nz,SCRL

         pop hl 
         inc hl 
         ld  (POZIC),hl 
         ld  a,(ATX42)
         inc a 
         ld  (ATX42),a 
         jp  COD14

ATX42  defb 0
ATY42  defb 0
CLR42  defb 0
TBP42  defb 0


;-------------- COD ##18 ---------------
;     ��������� ��������� �������

COD18  inc hl       ;������� �� ������
       inc hl       ;������� �� 1 �����

       ld   a,5
       ld   (RAZR),a 
       call CONV        ;�������� �����
       ld   (SPADR),de  ;���� ���������

       inc  hl       ;������� �� 2 �����
       ld   a,2
       ld   (RAZR),a 
       call CONV
       ld   (SPX),a  ;�������� X �����

       inc  hl 
       call CONV
       ld   (SPY),a  ;Y �����

       inc  hl 
       call CONV
       ld   (SPDL),a ;�����

       inc  hl 
       call CONV
       ld   (SPWS),a ;������

       push hl 
       call CTSP
       pop  hl 
       ret 


;-------------- COD ##19 ---------------
;       ��������� ������ �������

COD19  inc hl       ;������� �� ������
       inc hl       ;������� �� 1 �����

       ld   a,5
       ld   (RAZR),a 
       call CONV        ;�������� �����
       ld   (SPADR),de  ;���� ���������

       inc  hl       ;������� �� 2 �����
       ld   a,(hl) 
       sub  48
       ld   (SPREJ),a ;����� �����

       inc  hl       ;���� �������
       inc  hl       ;������� �� 3 �����
       ld   a,2
       ld   (RAZR),a 
       call CONV
       ld   (SPX),a  ;�������� X �����


       inc  hl 
       call CONV
       ld  (SPY),a   ;Y �����

       inc  hl 
       call CONV
       ld   (SPDL),a ;�����

       inc  hl 
       call CONV
       ld   (SPWS),a ;������

       push hl 
       call PTSP
       pop  hl 
       ret 


;-------------- COD ##20 ---------------
; ��������� ������ ������� � ��� ����
;        � ����� "����������"

COD20       ld   a,2
            ld   (RAZR),a
            inc  hl 
            inc  hl
            call CONV
            push hl
            push af 

            ld   b,1
            call RAM

            pop  af 
            ld   b,a 
            ld   hl,#C000
            ld   de,1089
            cp   0
            jr   z,OSN202
OSN201      add  hl,de 
            djnz OSN201
OSN202      ld   (SPADR),hl 
            ld   a,01 : ld (SPREJ),a 
            ld   a,20 : ld (SPX),a 
            ld   a,2  : ld (SPY),a 
            ld   a,11
            ld   (SPDL),a : ld (SPWS),a 
            call PTSP
            ld   b,0
            call RAM
            pop  hl 
            ret 


;-------------- COD ##21 ---------------
; ��������� ������ ������� � ���� �����

COD21       ret 


;-------------- COD ##22 ---------------
;��������� �������� �����

COD22 push hl

      ld a,10 : ld (COLW),a  ;���������
      ld a,5  : ld (ROWW),a  ;���  ���
      ld a,11 : ld (LENW),a  ;�����
      ld a,9  : ld (HGTW),a  ;��������
      call COD05

      ld a,180: ld (RAMW),a  ;����������
      ld a,2  : ld (ATRW),a  ;����
      call COD06

      ld a,(BANK) : ld (RAMTMP),a 
      ld b,3  : call RAM
      ld a,1  : ld (SPREJ),a 
      ld a,12 : ld (SPX),a 
      ld a,6  : ld (SPY),a 
      ld a,7  : ld (SPDL),a 
      ld a,7  : ld (SPWS),a 
      ld hl,#D8E6
      ld (SPADR),hl          ;����������
      call PTSP              ;�������
      ld a,(RAMTMP) : ld b,a 
      call RAM

      pop  hl 
      inc  hl 
      inc  hl  ;������ �� ��� �����
      push hl 
      ld   bc,#C000
      ld   (LDADR),bc 
      call LOAD

      ld a,10 : ld (COLW),a  ;���������
      ld a,5  : ld (ROWW),a  ;���  ���
      ld a,11 : ld (LENW),a  ;�����
      ld a,9  : ld (HGTW),a  ;��������
      call COD07

      pop  hl 
      ld   de,9
      add  hl,de 
      ret 

;-------------- COD ##23 ---------------
;  ����������� ������� �� ������ �����

COD23  ld   a,2
       ld   (RAZR),a 
       inc  hl 
       inc  hl 
       call CONV
       ld   c,a 
       call FINDSC
       ld   (POZGL),hl 
       ret 


;-------------- COD ##24 ---------------
;          ����� ����� (1-4)
COD24  ld  a,2
       ld  (RAZR),a 
       xor a 
       ld  (23560),a 

COD241 ld  a,(23560)
       cp  0
       jr  z,COD241

       ld  e,a ;���� ��������� ��� �������
       ld  a,(hl) 
       sub 48
       ld  d,a ;� d-���������� ���������
       ld  a,e ;������� � a ��� �������

       cp  "1" :jr nz,COD242
         inc  hl     ;�� �����
         inc  hl     ;�� ���1
         call CONV
         ld   c,a 
         call FINDSC ;����� ����� �����
         ld   (POZGL),hl 
         ret 

COD242 dec d   :jr z,COD241
       cp  "2" :jr nz,COD243
         inc  hl ;�� �����
         inc  hl ;�� ����� �����
         inc  hl ;������� ���
         inc  hl ;�� �����

         inc  hl 
         call CONV
         ld   c,a 
         call FINDSC
         ld   (POZGL),hl 
         ret 

COD243 dec d   :jr z,COD241
       cp  "3" :jr nz,COD244
         inc  hl ;�� �����
         inc  hl ;�� ����� �����
         inc  hl ;������� ���
         inc  hl ;�� �����
         inc  hl ;�� ����� �����
         inc  hl ;������� ���
         inc  hl ;�� �����

         inc  hl 
         call CONV
         ld   c,a 
         call FINDSC    ; ����� ����� �����
         ld   (POZGL),hl 
         ret 

COD244 dec d   :jp z,COD241
       cp  "4" :jp nz,COD241
         inc  hl ;�� �����
         inc  hl ;�� ����� �����
         inc  hl ;������� ���
         inc  hl ;�� �����
         inc  hl ;�� ����� �����
         inc  hl ;������� ���
         inc  hl ;�� �����
         inc  hl ;�� ����� �����
         inc  hl ;���� ���
         inc  hl ;�� �����

         inc  hl 
         call CONV
         ld   c,a 
         call FINDSC
         ld   (POZGL),hl 
         ret 

;-------------- COD ##25 ---------------
;     ��������� �������� ���� #2
;            "��������"

COD25 ld a,8  : ld (COLW),a 
      ld a,2  : ld (ROWW),a 
      ld a,19 : ld (LENW),a 
      ld a,18 : ld (HGTW),a 
      call COD07
      ret 


;---------------- COD26 ----------------
;��������� ������ ���� #3 "�������"

COD26 ld a,2  : ld (COLW),a  ;���������
                ld (ROWW),a  ;���  ���
      ld a,26 : ld (LENW),a  ;�����
      ld a,12 : ld (HGTW),a  ;������
      call COD05


      ld b,3  : call RAM
      ld a,1  : ld (SPREJ),a 
      ld a,2  : ld (SPX),a 
                ld (SPY),a 
      ld a,7  : ld (SPDL),a 
      ld a,12 : ld (SPWS),a 
      ld hl,#CC07
      ld (SPADR),hl          ;����������
      call PTSP              ;��������


      ld a,13 : ld (ATX),a 
      ld a,3  : ld (ATY),a 
      ld a,0  : ld (CLR42),a 

      ld a,9  : ld (COLW),a 
      ld a,2  : ld (ROWW),a
      ld a,19 : ld (LENW),a 
      ld a,12 : ld (HGTW),a 
      ld a,188: ld (RAMW),a  ;����������
      ld a,96 : ld (ATRW),a  ;���� ���
      call COD06             ;������
                             ;������
      ld b,0  : call RAM
      ret 

;---------------- COD27 ----------------
;��������� �������� ���� #3 "�������"

COD27 ld a,2  : ld (COLW),a 
                ld (ROWW),a 
      ld a,26 : ld (LENW),a 
      ld a,12 : ld (HGTW),a 
      call COD07
      ret 

;---------------- COD28 ----------------
;��������� ��������� �����

COD28 inc  hl ;���� ����
      inc  hl ;������ �� �����
      ld   a,2
      ld   (RAZR),a 
      call CONV
      ld   a,#FF
      ld   bc,FLAG
      ex   de,hl 
      add  hl,bc 
      ld   (hl),a
      ex   de,hl 
      ret 


;-------------- COD ##29 ---------------
;������� �� ������ �����,���� ���� �����

COD29  ld   a,2
       ld   (RAZR),a 
       inc  hl  ;���
       inc  hl  ;�� �����
       call CONV
       ld   bc,FLAG
       ex   de,hl 
       add  hl,bc 
       ld   a,(hl) 
       ex   de,hl 
       cp   #FF
       jr   z,COD291

          inc  hl 
          call CONV
          ld   c,a 
          call FINDSC
          ld   (POZGL),hl 
          ret 

COD291    inc hl ;����
          inc hl ;������ �����
          inc hl ;���� �����
          inc hl 
          call CONV
          ld   c,a 
          call FINDSC
          ld   (POZGL),hl 
          ret 

;---------------- COD30 ----------------
;��������� ������ ���� #4 "����������"

COD30 ld a,2  : ld (COLW),a  ;���������
                ld (ROWW),a  ;���  ���
      ld a,29 : ld (LENW),a  ;�����
      ld a,8  : ld (HGTW),a 
      call COD05


      ld b,3  : call RAM
      ld a,1  : ld (SPREJ),a 
      ld a,2  : ld (SPX),a 
                ld (SPY),a 
      ld a,6  : ld (SPDL),a 
      ld a,8  : ld (SPWS),a 
      ld hl,#D735
      ld (SPADR),hl          ;����������
      call PTSP              ;������


      ld a,11 : ld (ATX),a 
      ld a,3  : ld (ATY),a 
      ld a,0  : ld (CLR42),a 

      ld a,8  : ld (COLW),a 
      ld a,2  : ld (ROWW),a
      ld a,22 : ld (LENW),a 
      ld a,8  : ld (HGTW),a 
      ld a,196: ld (RAMW),a  ;����������
      ld a,66 : ld (ATRW),a  ;���� ���
      call COD06             ;������
                             ;������
      ld b,0  : call RAM
      ret 

;---------------- COD31 ----------------
;��������� �������� ���� #4 "����������"

COD31 ld a,2  : ld (COLW),a 
                ld (ROWW),a 
      ld a,29 : ld (LENW),a 
      ld a,8 : ld (HGTW),a 
      call COD07
      ret 

;---------------- COD32 ----------------
;��������� ���������� �����

COD32 inc  hl ;���� ����
      inc  hl ;������ �� �����
      ld   a,2
      ld   (RAZR),a 
      call CONV
      xor  a 
      ld   bc,FLAG
      ex   de,hl 
      add  hl,bc 
      ld   (hl),a
      ex   de,hl 
      ret 

;---------------- COD33 ----------------
;���������� �������� ���� �������

COD33 ld hl,FLAG+12
      ld a,(hl) 
      cp #FF
      ret nz 

      ld hl,FLAG+18
      ld a,(hl) 
      cp #FF
      ret nz 

      ld hl,FLAG+19
      ld a,(hl) 
      cp #FF
      ret nz 

      ld   c,31
      call FINDSC
      ld   (POZGL),hl
      pop  hl  ;������� �� ����� �����
               ;�������� � OSN33 �
               ;������ ������� �� GLV00
      jp   GLV00

;=======================================
;��������� ������ �����

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
        inc  hl   ;�� �����
        inc  hl   ;�� ���� ���� �����
        ret 


;=======================================
        include "bib02.C"
        include "bib01.C"

;=======================================
POZGL   defb 0,0 ;2�����!
POZIC   defb 0,0 ;2�����!
NABOR   defb 0,0 ;2�����!

COLW    defb 0
ROWW    defb 0
LENW    defb 0
HGTW    defb 0
ATRW    defb 0
RAMW    defb 0
ATX     defb 0
ATY     defb 0

FILEZ1  defb "zast1   C"
FILEZ2  defb "zast2   C"
FILEZ3  defb "zast3   C"
FILEZ4  defb "zast4   C"
FILEOS  defb "osnscr  C"
FILEZ5  defb "gfx00   C"


FILE01  defb "font    C"
FILE03  defb "blsc00  C"
FILE04  defb "blsp00  C"
FILE05  defb "gfx00   C"

