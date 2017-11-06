DEVICE zxspectrum128

ORG     #8000
prg_start

include "XXXXXXXX.asm"
include "myasmV7.asm"
include "bib01.asm"
include "bib02.asm"

SAVESNA "myzx.sna",prg_start
