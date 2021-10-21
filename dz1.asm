format PE GUI
entry start

include '%fasminc%/win32w.inc'

section '.data' data readable writeable

        Title db 'My first program on Assembler', 0
        Text db 'Hello World!', 0

section '.text' code readable executable

        start:

                invoke MessageBoxA, dword 0, Text, Title, dword MB_OK

                mov byte [Text + 2], byte 'B'
                mov byte [Text + 3], byte 'y'
                mov byte [Text + 4], byte 'e'

                invoke MessageBoxA, dword 0, Text + 2, Title, dword MB_OK

                invoke ExitProcess, dword 0


section '.idata' data import readable writeable

        library kernel32, 'kernel32.dll', \
                user32, 'user32.dll'

        import kernel32, ExitProcess, 'ExitProcess'
        import user32, MessageBoxA, 'MessageBoxA'