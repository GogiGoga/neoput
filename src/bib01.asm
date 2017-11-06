

;======================================
;           лемедфеп оюлърх
;======================================
RAM    push bc
       ld   a,b 
       ld   (BANK),a 
       add  a,16
       ld   bc,#7FFD
       out  (c),a
       pop  bc 
       ret 

BANK   defb 0


;======================================
;      гюцпсгйю тюикю он ецн хлемх
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
;     опнжедспю нопедекемхъ юдпеяю
;   б щйпюммнл тюике он  йннпдхмюрюл
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
;     опнжедспю нопедекемхъ юдпеяю
;   б тюике юрпхасрнб он йннпдхмюрюл
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
;    опнжедспю бшпегйх яопюирю
;          (янупюмемхъ нймю)
;======================================
CTSP   ld   hl,(SPADR)
       ld   (PTADR),hl
       ld   de,(SPY) ; d-X, e-Y йннпд
       ld   a,(SPWS)
       ld   b,a      ;явервхй он бшянре

CTSP1  push bc 
       call GETADR
       push de
       ld   b,8      ; явер мю 8 ярпнй

CTSP2  push bc 
       push hl 
       ld   bc,(SPX) ; б b оноюкн SPDL
       ld   de,(PTADR)

CTSP3  ld   a,(hl) 
       ld   (de),a 
       inc  de
       inc  hl
       djnz CTSP3

       ld   (PTADR),de
       pop  hl 
       inc  h    ;охйяекэмюъ ярпнйю +1
       pop  bc 
       djnz CTSP2

       pop  de
       inc  e    ;Y йннпдхмюрю +1
       pop  bc
       djnz CTSP1

; -------- бшпегйю юрпхасрнб -------
       ld   de,(SPY)  ;d-X, e-Y йннпд
       ld   a,(SPWS)
       ld   b,a       ;явервхй он бшянре

CTSP4  push bc 
       push de 
       call GETATR

       ld   bc,(SPX)  ;б b оноюкн SPDL
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
;       опнжедспю бшбндю яопюирю
;======================================
PTSP   ld   hl,(SPADR)
       ld   (PTADR),hl
       ld   de,(SPY) ; d-X, e-Y йннпд
       ld   a,(SPWS)
       ld   b,a      ;явервхй он бшянре

PTSP1  push bc 
       call GETADR
       push de
       ld   b,8      ; явер мю 8 ярпнй

PTSP2  push bc 
       push hl 
       ld   bc,(SPX) ; б b оноюкн SPDL
       ld   de,(PTADR)

PTSP3  ld   a,(de) 
       ld   (hl),a
       inc  de
       inc  hl
       djnz PTSP3

       ld   (PTADR),de
       pop  hl 
       inc  h    ;охйяекэмюъ ярпнйю +1
       pop  bc 
       djnz PTSP2

       pop  de
       inc  e    ;Y йннпдхмюрю +1
       pop  bc
       djnz PTSP1

; ---------- бшбнд юрпхасрнб -------
       ld   a,(SPREJ)
       cp   0: ret z  ;бшу еякх ме мюдн

       ld   de,(SPY)  ;d-X, e-Y йннпд
       ld   a,(SPWS)
       ld   b,a       ;явервхй он бшянре

PTSP4  push bc
       push de 
       call GETATR

       ld   bc,(SPX)  ;б b оноюкн SPDL
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
;    опнжедспю опнъбкемхъ йюпрхмйх
;          (FADE_IN EFFEKT)
;======================================
FI    xor  a         ;гюкхкх накюярэ
      ld   hl,#5800  ;юрпхасрнб вепмшл
      ld   (hl),a    ;INK х PAPER
      ld   de,#5801  ;
      ld   bc,767    ;
      ldir           ;

      ld   hl,(BUFF) ;бшбекх йюпрхмйс
      ld   de,#4000  ;хг асттепю мю
      ld   bc,6144   ;щйпюм онйю аег
      ldir           ;жберю

      ld   (BUFF),hl ;реоепэ hl ярнхр
                     ;мю мювюке юрпхас-
                     ;рнб, янупюмъел щрн
                     ;б BUFF

      ld   b,7
FI1   halt
      ld   hl,22000  ;оюсгю
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
;      опнжедспю цюьемхъ йюпрхмйх
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
;      опнжедспю нвхярйх щйпюмю х
;    сярюмнбйх ецн  юрпхасрнб (CLS)
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
;       опнжедспю опенапюгнбюмхъ
;      яхлбнкэмни ярпнйх  б вхякн
;======================================
CONV   ld bc,0
       ld (CONVR),bc 

       ld a,(RAZR)  ;бгъкх дкхмс ярпнйх
       cp 5         ;врн яннрберярбсер
       jr z,CNV5    ;йнкхвеярбс пюгпъднб
       cp 4         ;вхякю
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
       ret        ;бшунд хг опнжедспш

CNVOSN push hl 
       ld  a,(hl) ;бгъкх жхтпс хг рейярю
       sub 48     ;онксвхкх ее гмювемхе
       ld  e,a    ;б de онксвхкх жхптс
       ld  d,0    ;хг рейярю
       ld  h,b    ;б hl онксвхкх лмнфх-
       ld  l,c    ;рекэ пюгпъдю
       call 12457 ;лмнфхл de мю hl 
       ld  de,(CONVR)
       add hl,de
       ld  (CONVR),hl
       ld  d,h
       ld  e,l
       ld  a,l 
       pop hl
       inc hl     ;мю бшунде hl асдер
       ret        ;сйюгшбюрэ мю "," хкх
                  ;оепебнд ярпнйх
RAZR   defb 0
CONVR  defb 0,0


;======================================
;         опнжедспю оюсгю 8)
;======================================
PAUSE   xor a
        ld  (23560),a
PAU1    ld  a,(23560)
        cp  0
        jr  z,PAU1
        ret 





