                .586
                .MODEL flat, stdcall

                include Win32API.asm

                .STACK 4096

ASCIIToDecimal  PROTO   C, operandOne:DWORD, operator:BYTE, operandTwo:DWORD
DecimalToASCII  PROTO   C, operandOne:DWORD, operator:BYTE, operandTwo:DWORD

                .DATA
_CR             EQU     0Dh             ;Carriage return character
_LF             EQU     0Ah             ;Line Feed (new line) character
NULL_PTR        EQU     0
_SPACE          EQU     20h             ;Space character

_ADD            EQU     2Bh             ;Represents +
_SUB            EQU     2Dh             ;Represents -
_MULTIPLY       EQU     2Ah             ;Represents *
_DIVIDE         EQU     2Fh             ;Represents /

userPrompt      byte    "Please enter an equation (max 25 characters): ", _CR, _LF          ;Must be of the form "Number ArithmeticOperator Number"
BytesWritten    dword   0

userInput       byte    27 dup (0)      ;Max 25 characters + CR + LF 
BytesRead       dword   0      

hStdOut         dword   0
hStdIn          dword   0
consoleOutput   byte    0


                .CODE
start:
                ;**********************************
                ; Get Handle to Standard Output
                ;**********************************
                invoke  GetStdHandle, STD_OUTPUT_HANDLE
                mov     hStdOut, eax

                ;**********************************
                ; Prompt user to enter an equation
                ;**********************************
                invoke  WriteConsoleA, hStdOut, OFFSET userPrompt, SIZEOF userPrompt, OFFSET BytesWritten, NULL_PTR                
                
                ;**********************************
                ; Get handle to Standard Input
                ;**********************************
                invoke  GetStdHandle, STD_INPUT_HANDLE
                mov     hStdIn, eax

                ;**********************************
                ; Get User Input
                ;**********************************
                invoke  ReadConsoleA, hStdIn, OFFSET userInput, SIZEOF userInput, OFFSET BytesRead, NULL_PTR

                ;*****************************
                ; Display user input [temp]
                ;******************************
                invoke  WriteConsoleA, hStdOut, OFFSET userInput, SIZEOF userInput, OFFSET BytesWritten, NULL_PTR



endProgram:
                invoke ExitProcess, 0
                END start