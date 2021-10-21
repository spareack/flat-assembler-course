format PE GUI
entry start

include '%fasm%/win32w.inc'

section '.data' data readable writeable

Title db 'Bolsheshapova', 0
Text db 'A', 0      ;dword - 4 байта

section '.text' code readable executable

start:
         mov al, 0x5a
         mov byte [Text] , al ;в eax - адрес переменной Text

         invoke MessageBoxA, dword 0, Text,  Title, dword MB_OK

         mov ah, 'B'
         mov byte [Text] , ah

         invoke MessageBoxA, dword 0, Text,  Title, dword MB_OK
         invoke ExitProcess, dword 0



section '.idata' data import readable writeable

library kernel32, 'kernel32.dll', \
        user32, 'user32.dll'

import kernel32, ExitProcess, 'ExitProcess'
;
import user32, MessageBoxA, 'MessageBoxA'