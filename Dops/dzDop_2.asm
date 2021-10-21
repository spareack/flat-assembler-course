format PE console
entry start

include '%fasminc%/win32wxp.inc'

section '.data' data readable writeable

        Title db 'HeLlO_WoRlD!', 0
        SpecForPrintf db '%d', 0Dh, 0Ah, 0
        SpecForPrintfChar db '%s', 0Dh, 0Ah, 0
        N dd 123

        SpecForScanf db '%d', 0
        X dd ?


section '.text' code readable executable

        start:
                xor ecx, ecx
                call checkSymbol


        checkSymbol:

                cmp byte [Title + ecx], 0
                je end_of_string

                cmp byte [Title + ecx], byte 65
                jl nextIter

                cmp byte [Title + ecx], byte 91
                jnl nextIter

                jmp changeReg


        nextIter:
                inc ecx
                jmp checkSymbol


        changeReg:
                push eax
                mov eax, dword 32
                add eax, dword [Title + ecx]

                mov dword [Title + ecx], eax
                pop eax

                jmp nextIter


        end_of_string:

                cinvoke printf, SpecForPrintfChar, Title
                invoke ExitProcess, dword 0


section '.idata' data import readable writeable

        library kernel32, 'kernel32.dll', \
                user32, 'user32.dll', \
                msvcrt, 'msvcrt.dll'

        import kernel32, ExitProcess, 'ExitProcess'
        import user32, MessageBoxA, 'MessageBoxA'
        import msvcrt, printf, 'printf', scanf, 'scanf'

