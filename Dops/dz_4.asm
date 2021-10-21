format PE console
entry start

include '%fasminc%/win32wxp.inc'


section '.data' data readable writeable

        Hello              db    'Enter two numbers: X and Y', 0Dh, 0Ah, 0
        Multiply           db    'Result of Multiply: ', 0
        Adding             db    'Result of Adding: ', 0
        Substract          db    'Result of Substract: ', 0
        Division           db    'Result of Division: ', 0

        SpecForPrintf      db    '%d', 0Dh, 0Ah, 0
        SpecForPrintfStr   db    '%s', 0
        SpecForPrintfDiv   db    'int part - %d, remainder - %d', 0Dh, 0Ah, 0
        N                  dd    123

        SpecForScanf       db    '%d', 0

        X                  dd    ?
        Y                  dd    ?


section '.text' code readable executable

        start:
                cinvoke printf, SpecForPrintfStr, Hello

                cinvoke scanf, SpecForScanf, X
                cinvoke scanf, SpecForScanf, Y

                cinvoke printf, SpecForPrintfStr, Multiply
                mov eax, [X]
                mul [Y]
                cinvoke printf, SpecForPrintf, eax

                cinvoke printf, SpecForPrintfStr, Adding
                mov eax, [X]
                add eax, [Y]
                cinvoke printf, SpecForPrintf, eax

                cinvoke printf, SpecForPrintfStr, Substract
                mov eax, [X]
                sub eax, [Y]
                cinvoke printf, SpecForPrintf, eax

                cinvoke printf, SpecForPrintfStr, Division
                mov eax, [X]
                div [Y]
                cinvoke printf, SpecForPrintfDiv, eax, edx

                jmp end_program


        end_program:

                invoke ExitProcess, dword 0


section '.idata' data import readable writeable

        library kernel32, 'kernel32.dll', \
                user32, 'user32.dll', \
                msvcrt, 'msvcrt.dll'

        import kernel32, ExitProcess, 'ExitProcess'
        import user32, MessageBoxA, 'MessageBoxA'
        import msvcrt, printf, 'printf', scanf, 'scanf'

