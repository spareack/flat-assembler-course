format PE GUI
entry main

include '%fasminc%/win32w.inc'


section '.text' code readable executable writable

        main:
                mov eax, 10

                mov ebx, 20

                mul ebx

                add eax, ebx

                div ebx  ;остаток в edx

                neg eax

                xchg eax, ebx

                sub ebx, edx

                add eax, ebx

                add eax, edx


        end_of_program:

                invoke ExitProcess, 0


section '.idata' import data readable writeable

        library kernel, 'kernel32.dll', \
                user, 'user32.dll'

        import kernel, ExitProcess, 'ExitProcess'
        import user, SoftModalMessageBox, 'SoftModalMessageBox'




