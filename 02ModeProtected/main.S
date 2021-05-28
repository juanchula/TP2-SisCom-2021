/* SOURCE: https://github.com/cirosantilli/x86-bare-metal-examples/ */

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

/* 
CLEAR (Limpia la pantalla)
*/
    /* PUSH_ADX */
    push %ax
    push %bx
    push %cx
    push %dx

    mov $0x0600, %ax
    mov $0x7, %bh
    mov $0x0, %cx
    mov $0x184f, %dx
    int $0x10

    /* CURSOR POSITION */
    push %ax
    push %bx
    push %cx
    push %dx
    mov $0x02, %ah
    mov $0x00, %bh
    mov $0, %dh
    mov $0, %dl
    int $0x10
    pop %dx
    pop %cx
    pop %bx
    pop %ax


    pop %dx
    pop %cx
    pop %bx
    pop %ax

/* 
CONFIG/SET PROTECTED MODE 
*/
    .equ CODE_SEG, 8

    /* Obtenemos el tamaño de la tabla */
    .equ DATA_SEG, gdt_data - gdt_start

    /* Carga GDT (Tabla de descriptrores globales) */
    lgdt gdt_descriptor

    /* Setea el bit PE (Modo Protegido) de CRO en 1*/
    mov %cr0, %eax
    orl $0x1, %eax
    mov %eax, %cr0

    /* Salta a la seccion de 32 bits */
    ljmp $CODE_SEG, $protected_mode

    /* Comienza cargado de GDT */
    gdt_start:
    /* Primer elemento de GDT nulo es nulo y de 2 long*/
    gdt_null:
        .long 0x0
        .long 0x0

    /* Cargado del descriptor de codigo */
    gdt_code:
        .word 0xffff        /* Limite de memoria del segmento de codigo (0-15 bit 1er DWord) */
        .word 0x0           /* Inicio de memoria del segmento de codigo (16-31 bit 1er DWord) */
        /* 3.2) */
        // .word 0xaaaa        /* Limite de memoria del segmento de data ((0-15 bit 1er DWord) */
        // .word 0x0           /* Inicio de memoria del segmento de data 16-31 bit 1er DWord) */

        .byte 0x0           /* Direccion Base (0-7 2do DWord) */
        .byte 0b10011010    /* (8-15 2do DWord). Tipo de segmento -> (8-12) ; Nivel de privilegio -> (13-14) ; Present flag -> (15) */
        /*  bit 15    (1)  -> Flag de presencia en memoria. Lo establecemos en 1 porque esta presente.
            bit 13-14 (00) -> Nivel de privilegio requerido (0, 1, 2 o 3). Lo establecemos en 0.
            bit 12    (1)  -> 
            bit 11    (1)  -> Tipo: 1 para codigo, 0 para data. Lo establecemos en 1 (codigo).
            bit 10    (0)  -> Conforming: Si es 1, los segmentos de código menos privilegiados pueden saltar o llamar a este segmento. Lo establecemos en 0.
            bit 9     (1)  -> Lectura (leido o no): En este caso 1 para que se puede leer.
            bit 8     (0)  -> Flag de Acceso (No la utilizamos).
        */
        .byte 0b11001111
        /*  bit 23    (1)   -> Granuladidad. 1 -> El limitador de segmento va a ser multiplicado por 4k para acceder a todo el rengo de memoria.
            bit 21-22 (10)  -> Bit size: 10 -> 32 bits.
            bit 20    (0)   -> Reservado para intel.
            bit 19    (1)   -> Flag "Available to System Programmers": Ignorada por la CPU pero usada por el sistema.
            bit 16-18 (111) -> Ultimos bits en el límite de segmento. del segmento (valor minimo 8 bytes).
        */
        .byte 0x0           /* Direccion base (24-31). Es 0 porque arrancaremos desde 0 */

    /* Cargado del descriptor de data */
    gdt_data:        
        .word 0xffff        /* Limite de memoria del segmento de data ((0-15 bit 1er DWord) */
        .word 0x0           /* Inicio de memoria del segmento de data 16-31 bit 1er DWord) */
        /* 3.2) */
        // .word 0xffff        /* Limite de memoria del segmento de data ((0-15 bit 1er DWord) */
        // .word 0xaaab           /* Inicio de memoria del segmento de data 16-31 bit 1er DWord) */

        .byte 0x0           /* Direccion Base (0-7 2do DWord) */
        .byte 0b10010010    /* (8-15 2do DWord). Tipo de segmento -> (8-12) ; Nivel de privilegio -> (13-14) ; Present flag -> (15) */
        /*  bit 15    (1)  -> Flag de presencia en memoria. Lo establecemos en 1 porque esta presente.
            bit 13-14 (00) -> Nivel de privilegio requerido (0, 1, 2 o 3). Lo establecemos en 0.
            bit 12    (1)  -> 
            bit 11    (0)  -> Tipo: 1 para codigo, 0 para data. Lo establecemos en 0 (data).
            bit 10    (0)  -> Conforming: Si es 1, los segmentos de código menos privilegiados pueden saltar o llamar a este segmento. Lo establecemos en 0.
            bit 9     (1)  -> Lectura (leido o no): En este caso 1 para que se puede leer.
            bit 8     (0)  -> Flag de Acceso (No la utilizamos).
        */
        .byte 0b11001111    /* (16-23 2do DWord). Limite-> (16-19) ; Atributos -> (20-22) ; Granuladidad -> (23) */
        /*  bit 23    (1)   -> Granuladidad. 1 -> El limitador de segmento va a ser multiplicado por 4k para acceder a todo el rengo de memoria.
            bit 21-22 (10)  -> Bit size: 10 -> 32 bits.
            bit 20    (0)   -> Reservado para intel.
            bit 19    (1)   -> Flag "Available to System Programmers": Ignorada por la CPU pero usada por el sistema.
            bit 16-18 (111) -> Ultimos bits en el límite de segmento. del segmento (valor minimo 8 bytes).
        */
        .byte 0x0           /* Direccion base (24-31). Es 0 porque arrancaremos desde 0 */

    gdt_end:
    /* Descriptor de la tabla de segmento */
    gdt_descriptor:
        .word gdt_end - gdt_start   /* Tamaño GDT */
        .long gdt_start             /* Inicio/limite GDT */

    vga_current_line:
        .long 0


/* 
PROTECTED MODE 
*/
    .code32
    protected_mode:
        /* Actualiza cache */
        mov $DATA_SEG, %ax
        mov %ax, %ds
        mov %ax, %es
        mov %ax, %fs
        mov %ax, %gs
        mov %ax, %ss

        mov $0X7000, %ebp
        mov %ebp, %esp

        /* VGA_PRINT_STRING */
        push %eax
        push %ebx
        push %ecx
        push %edx
        mov $message, %ecx
        mov vga_current_line, %eax
        mov $0, %edx

        /* Número de líneas horizontales */
        mov $25, %ebx
        div %ebx
        mov %edx, %eax
        mov $160, %edx          /* 160 == 80 * 2 == ancho de línea * bytes por carácter en la pantalla */
        mul %edx
        lea 0xb8000(%eax), %edx /* 0xb8000 == dirección de memoria de video mágica que se muestra en la pantalla. */
        mov $0x0f, %ah          /* Blanco sobre negro. */

    loop:
        mov (%ecx), %al
        cmp $0, %al
        je end
        mov %ax, (%edx)
        add $1, %ecx
        add $2, %edx
        jmp loop
    end:
        incl vga_current_line
        pop %edx
        pop %ecx
        pop %ebx
        pop %eax
        jmp .
    message:
        .asciz "modo protegido -> Juan^2"