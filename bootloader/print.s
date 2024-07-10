; Macro putc [in] char character
macro putc character*
{
    mov al, character
    call bios_putc
}

; Macro puts:
; [in] char* str
macro puts str*
{
    mov si, str
    call bios_puts
}

; input is directly on al, use the provided macro 
bios_putc:
    push bx
    mov bx, 0   ; page = 0, color = white
    mov ah, 0x0e ; Write Teletype 
    int 0x10  
    pop bx
    ret

bios_puts:
    push si
.puts_loop:
    lodsb
    or al, al
    jz .puts_done
    putc al 
    jmp .puts_loop
.puts_done:
    pop si
    ret
