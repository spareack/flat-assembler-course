format PE GUI
entry start

include '%fasminc%/win32w.inc'

section '.data' data readable writeable

        Title db 'Windows', 0
        Text db 'Local drive C: was formatted successfully!', 0

section '.text' code readable executable

        start:

                invoke MessageBoxA, dword 0, Text, Title, dword MB_OK
                invoke ExitProcess, dword 0


section '.idata' data import readable writeable

        library kernel32, 'kernel32.dll', \
                user32, 'user32.dll'

        import kernel32, ExitProcess, 'ExitProcess'
        import user32, MessageBoxA, 'MessageBoxA'