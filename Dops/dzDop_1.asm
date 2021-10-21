format PE console
entry start

include '%fasminc%/win32wxp.inc'

section '.data' data readable writeable

        Title db 'My first program on assembler!', 0
        Text db 'Hello, world!', 0
        SpecForPrintf db '%d', 0Dh, 0Ah, 0
        SpecForPrintfChar db '%s', 0Dh, 0Ah, 0
        N dd 123

        SpecForScanf db '%d', 0
        X dd ?


section '.text' code readable executable

        start:
                xor ecx, ecx
                call next_char

        next_char:

                cmp byte [Title + ecx], 0
                je end_of_string

                cmp byte [Title + ecx], byte " "
                je findSign

                inc ecx
                jmp next_char


        findSign:
                mov byte [Title + ecx], byte "_"
                jmp next_char


        end_of_string:

                cinvoke printf, SpecForPrintfChar, Title
                ;call outputTitle
                call the_end


        the_end:
                invoke ExitProcess, dword 0

                ; invoke MessageBoxA, dword 0, Text, Title, dword MB_OK

section '.idata' data import readable writeable

        library kernel32, 'kernel32.dll', \
                user32, 'user32.dll', \
                msvcrt, 'msvcrt.dll'

        import kernel32, ExitProcess, 'ExitProcess'
        import user32, MessageBoxA, 'MessageBoxA'
        import msvcrt, printf, 'printf', scanf, 'scanf'

