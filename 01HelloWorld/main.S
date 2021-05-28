/* 
BEGIN (Limpieza de registros de proposito general)
*/
    .code16
    cli
    /* Setea %cs en 0.*/
    ljmp $0, $1f
    1:
    xor %ax, %ax
    mov %ax, %ds
    mov %ax, %es
    mov %ax, %fs
    mov %ax, %gs
    mov %ax, %bp

    /* Deshabilita automáticamente las interrupciones hasta el final de la siguiente instrucción. */
    mov %ax, %ss

    mov %bp, %sp
    mov %dl, initial_dl
    jmp after_locals
    initial_dl: .byte 0
after_locals:

.code16
    mov $msg, %si
    mov $0x0e, %ah
loop:
    lodsb
    or %al, %al
    jz halt
    int $0x10
    jmp loop
halt:
    hlt
msg:
    .asciz "hello world -> Juan^2"
