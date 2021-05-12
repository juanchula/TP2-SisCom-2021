## 1) Desafío: UEFI y coreboot (40 min)

### 1.1) ¿Qué es UEFI? ¿como puedo usarlo? Mencionar además una función a la que podría llamar usando esa dinámica.

> UEFI (Unified Extensible Firmware Interface) es el remplazo de la BIOS. De modo simplificado, es una especificacion que define una interfaz entre el sistema operativo y el firmware. 

### 1.2) ¿Menciona casos de bugs de UEFI que puedan ser explotados?

>Tema de claves privadas. Es muy grande

### 1.3) ¿Qué es Converged Security and Management Engine (CSME), the Intel Management Engine BIOS Extension (Intel MEBx)?

### 1.4) ¿Qué es coreboot ? ¿Qué productos lo incorporan ?¿Cuales son las ventajas de su utilización?

---

## 2) Desafío: Linker

### 2.1) ¿Que es un linker? ¿que hace? 

- Es un programa que toma como entrada un conjunto de archivos object (generados por el compilador) y librerías,
y los combina en un único archivo ejecutable, libería u otro archivo objetct.
- También se encarga de la ubicación y tabla de símbolos de cada módulo.
### 2.2) ¿Que es la dirección que aparece en el script del linker?¿Porqué es necesaria?

Le indica al linker que al linkear el código, lo ubique en la posición 0x7c00.
Es necesaria porque es la dirección de memoria en la que la BIOS carga el MBR.
Es un número mágico que quedo de los tiempos de IBM por retrocompatibilidad.

### 2.3) Compare la salida de objdump con hd, verifique donde fue colocado el programa dentro de la imagen.


### 2.4) Grabar la imagen en un pendrive y probarla en una pc y subir una foto


### 2.6) ¿Para que se utiliza la opción --oformat binary en el linker?

- Se utiliza para que el linker devuelva un archivo binario puro, sin el 
wrapper de un archivo ELF, como es el caso para los ejecutables normales-

## 3) Desafío final: Modo protegido

### 3.1) Crear un código assembler que pueda pasar a modo protegido (sin macros).


### 3.2) ¿Cómo sería un programa que tenga dos descriptores de memoria diferentes, uno para cada segmento (código y datos) en espacios de memoria diferenciados? 


### 3.3) Cambiar los bits de acceso del segmento de datos para que sea de solo lectura, intentar escribir, ¿Que sucede? ¿Que debería suceder a continuación? (revisar el teórico) Verificarlo con gdb. 


### 3.4) n modo protegido, ¿Con qué valor se cargan los registros de segmento? ¿Porque?
