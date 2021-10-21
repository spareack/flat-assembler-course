format PE console
entry start

include '%fasminc%/win32w.inc'


struct  MSGBOXDATA
        params              MSGBOXPARAMS <>
        dwunk               dd           ?
        pwndOwner           dd           ?
        wLanguageId         dd           ?
        pidButton           dd           ?         ; // Array of button IDs
        ppszButtonText      dd           ?         ; // Array of button text strings
        cButtons            dd           ?
        DefButton           dd           ?
        CancelId            dd           ?
        Timeout             dd           ?
        unk2                dd           5 dup (?)
ends


section '.data' data readable writeable

        sCaption        du      'Windows', 0
        sTitle          du      'Choose the arithmetic operation...', 0
        sTitleDead      du      'Answer is: ', 0
        sBTN1           du      'Multiply', 0
        sBTN2           du      'Adding', 0
        sBTN3           du      'Substract', 0
        sBTN4           du      'Division', 0

        dwBtnIds        dd      1,2,3,4
        dwTxtTbl        dd      sBTN1, sBTN2, sBTN3, sBTN4
        dwTxtTblDead    dd      sBTN1, sBTN2, sBTN3, sBTN4

        mbxDead MSGBOXDATA <sizeof.MSGBOXPARAMS, 0, 0, sTitleDead, sCaption, MB_YESNOCANCEL, 0, 0, 0, 0>, \
                           0, 0, 0, dwBtnIds, dwTxtTblDead, 4, 0, 2, -1
        mbxDead1 MSGBOXDATA <sizeof.MSGBOXPARAMS, 0, 0, sTitle, sCaption, MB_YESNOCANCEL, 0, 0, 0, 0>, \
                            0, 0, 0, dwBtnIds, dwTxtTblDead, 4, 0, 2, -1

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


section '.text' code readable executable writable

        start:
                cinvoke printf, SpecForPrintfStr, Hello

                cinvoke scanf, SpecForScanf, X
                cinvoke scanf, SpecForScanf, Y

                jmp choseOperation

        label_Multiply:
                cinvoke printf, SpecForPrintfStr, Multiply
                mov eax, [X]
                mul [Y]
                cinvoke printf, SpecForPrintf, eax
                jmp choseOperation

        label_Adding:
                cinvoke printf, SpecForPrintfStr, Adding
                mov eax, [X]
                add eax, [Y]
                cinvoke printf, SpecForPrintf, eax
                jmp choseOperation

        label_Substract:
                cinvoke printf, SpecForPrintfStr, Substract
                mov eax, [X]
                sub eax, [Y]
                cinvoke printf, SpecForPrintf, eax
                jmp choseOperation

        label_Division:
                cinvoke printf, SpecForPrintfStr, Division
                mov eax, [X]
                div [Y]
                cinvoke printf, SpecForPrintfDiv, eax, edx
                jmp choseOperation


        choseOperation:
                invoke SoftModalMessageBox, mbxDead1

                cmp eax, 1
                jz label_Multiply
                cmp eax, 2
                jz label_Adding
                cmp eax, 3
                jz label_Substract
                cmp eax, 4
                jz label_Division

                jmp end_program

        end_program:
                invoke ExitProcess, dword 0


section '.idata' data import readable writeable

        library kernel32, 'kernel32.dll', \
                user32, 'user32.dll', \
                msvcrt, 'msvcrt.dll'

        import kernel32, ExitProcess, 'ExitProcess'

        import user32, MessageBoxA, 'MessageBoxA', \
                       SoftModalMessageBox, 'SoftModalMessageBox'

        import msvcrt, printf, 'printf', \
                       scanf, 'scanf'