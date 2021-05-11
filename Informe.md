## 1) Desafío: UEFI y coreboot (40 min)

### 1.1) ¿Qué es UEFI? ¿como puedo usarlo? Mencionar además una función a la que podría llamar usando esa dinámica.

### 1.2) ¿Menciona casos de bugs de UEFI que puedan ser explotados?

### 1.3) ¿Qué es Converged Security and Management Engine (CSME), the Intel Management Engine BIOS Extension (Intel MEBx)?

### 1.4) ¿Qué es coreboot ? ¿Qué productos lo incorporan ?¿Cuales son las ventajas de su utilización?

---

## 2) Desafío: Linker

### 2.1) ¿Que es un linker? ¿que hace? 


### 2.2) ¿Que es la dirección que aparece en el script del linker?¿Porqué es necesaria?


### 2.3) Compare la salida de objdump con hd, verifique donde fue colocado el programa dentro de la imagen.


### 2.4) Grabar la imagen en un pendrive y probarla en una pc y subir una foto


### 2.6) ¿Para que se utiliza la opción --oformat binary en el linker?

---

## 3) Desafío final: Modo protegido

### 3.1) Crear un código assembler que pueda pasar a modo protegido (sin macros).


### 3.2) ¿Cómo sería un programa que tenga dos descriptores de memoria diferentes, uno para cada segmento (código y datos) en espacios de memoria diferenciados? 


### 3.3) Cambiar los bits de acceso del segmento de datos para que sea de solo lectura, intentar escribir, ¿Que sucede? ¿Que debería suceder a continuación? (revisar el teórico) Verificarlo con gdb. 


### 3.4) n modo protegido, ¿Con qué valor se cargan los registros de segmento? ¿Porque?