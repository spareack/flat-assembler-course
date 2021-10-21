
format PE GUI
entry start

include '%fasminc%/win32w.inc'

section '.data' data readable writeable

Title db 'My first program on ASSembler', 0
Text db 'HELLo w0r1d!', 0 ;dword - 4 байта

section '.text' code readable executable

start:
        mov al, 'A'
        mov byte [Text] , al ;в eax - адрес переменной Text
        nop
        nop
        nop
        nop
        nop

        invoke MessageBoxA, dword 0, Text, Title, dword MB_OK
        invoke ExitProcess, dword 0


section '.idata' data import readable writeable

library kernel32, 'kernel32.dll', \
        user32, 'user32.dll'

import kernel32, ExitProcess, 'ExitProcess'
;
import user32, MessageBoxA, 'MessageBoxA'