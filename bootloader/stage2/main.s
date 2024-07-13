; build with fasm.
; FASM Docs: https://flatassembler.net/docs.php?article=manual#2.1.25

jmp main

include 'print.s'

main:
    puts hello

halt:
    jmp halt


hello: db 'Hello from kernel', 0xa, 0x0
