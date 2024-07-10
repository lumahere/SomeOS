; build with fasm. 
; FASM Docs: https://flatassembler.net/docs.php?article=manual#2.1.25

org 0x7c00

include 'fatspecs.s'

_start:
    jmp main    

include 'print.s'

; macro failure
; [in] char code
macro failure code*
{
    puts fail_msg
    putc code
    cli
    hlt
}

main:

halt:
    jmp halt

fail_msg: db 'CRITICAL ERROR, BOOT HALTED WITH CODE: ', 0x0

times 510 - ($-$$) db 0
dw 0xaa55