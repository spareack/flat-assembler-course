format PE GUI
entry start

include '%fasm%/win32w.inc'

section '.data' data readable

Title db 'My first program on ASSembler', 0
Text db 'HELLo w0r1d!', 0

section '.text' code readable executable

start:

         nop
         nop
         nop
         nop
         nop

         invoke MessageBoxA, dword 0, Text,  Title, dword MB_OK
         invoke ExitProcess, dword 0
;the_end:
;         invoke ExitProcess, dword 0


;start:
;       invoke ExitProcess, 0      push - в стек переменную хуярит а колл как я понял это инструкция которая помещает в стек адрес возврата
;        push dword 0
;        call [ExitProcess]
;        nop

section '.idata' data import readable writeable

library kernel32, 'kernel32.dll', \ ; library как она у нас называться будет, 'название библиотеки.*', \ <- типа перенос строки
        user32, 'user32.dll'

import kernel32, ExitProcess, 'ExitProcess'
;       имя библиотеки, имя функции у нас в проге, имя функции в библиотеки
import user32, MessageBoxA, 'MessageBoxA' ;ANSI !!! (1 байт на каждый символ)