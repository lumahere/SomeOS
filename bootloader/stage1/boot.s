; build with fasm.
; FASM Docs: https://flatassembler.net/docs.php?article=manual#2.1.25

org 0x7c00

include 'fatspecs.s'

_start:
    jmp BIOSSKIP

macro failure code*
{
    puts fail_msg
    putc code
    cli
    hlt
}

include 'print.s'

include 'disk.s'

; macro failure
; [in] char code

BIOSSKIP:
    xor ax, ax
    mov ss, ax
    mov es, ax
    mov ds, ax
    mov gs, ax
    mov fs, ax
    mov sp, 0x7c00

EnableA20:
    in al, 0x92
    test al, 2
    jnz afterA20
    or al, 2
    and al, 0xFE
    out 0x92, al
afterA20:
CheckEDD:
    mov ax, 0x41
    mov bx, 0x55aa
    mov dl, 0x80
    int 0x13
    jnc main
    failure 'E'

main:
    read_disk DAP, 0x80

halt:
    jmp halt

DAP DiskAddressPacket 2, 0x7e00, 0, 1

fail_msg: db 'CRITICAL ERROR, BOOT HALTED WITH CODE: ', 0x0
dap_transfer_err: db 'Failure to Transfer disk contents', 0x0
times 510 - ($-$$) db 0
dw 0xaa55
