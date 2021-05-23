MISMATCH: "[bits 16]"
MISMATCH: "[org 0x7c00]"

    movw $0,%ax
    movw %ax,%ss
    movw $0xFFFC,%sp
    movw $0,%ax
    movw %ax,%ds
    movw %ax,%es
    movw %ax,%fs
    movw %ax,%gs

    cli
MISMATCH: "    lgdt[gdt_descriptor]"
    movl $cr0, %eax
    orl $0x1,%eax
    movl %eax, $cr0
    # TODO why is this needed?
    jmp CODE_SEG:b32

MISMATCH: "[bits 32]"

print32: 
    pusha
    # Video memory address.
    movl $0xb8000,%edx
print32.loop: 
    movb (%ebx),%al
    # White on black.
    movb $0x0f,%ah
    cmpb $0,%al
    je print32.done
    movw %ax,(%edx)
    addl $1,%ebx
    addl $2,%edx
    jmp print32.loop
print32.done: 
    popa
    ret

b32: 
    movw $DATA_SEG, %ax
    movw %ax,%ds
    movw %ax,%es
    movw %ax,%fs
    movw %ax,%gs
    movw %ax,%ss

    movl $0x2000,%ebp
    movl %ebp,%esp

    movl $message, %ebx
    call print32

    jmp $

gdt_start: 

gdt_null: 
    .long 0x0
    .long 0x0

gdt_code: 
    .word 0xffff
    .word 0x0
    .byte 0x0
    .byte 0b10011010
    .byte 0b11001111
    .byte 0x0

gdt_data: 
    .word 0xffff
    .word 0x0
    .byte 0x0
    .byte 0b10010010
    .byte 0b11001111
    .byte 0x0

gdt_end: 

gdt_descriptor: 
MISMATCH: "    dw gdt_end - gdt_start"
MISMATCH: "    dd gdt_start"

MISMATCH: "CODE_SEG equ gdt_code - gdt_start"
MISMATCH: "DATA_SEG equ gdt_data - gdt_start"

MISMATCH: "message db 'hello world', 0"

MISMATCH: "[SECTION signature start=0x7dfe]"
.word 0xAA55

