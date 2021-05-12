## 1) Desafío: UEFI y coreboot (40 min)

### 1.1) ¿Qué es UEFI? ¿como puedo usarlo? Mencionar además una función a la que podría llamar usando esa dinámica.

> UEFI (Unified Extensible Firmware Interface) es el remplazo de la BIOS. Es una especificacion que define una interfaz entre el sistema operativo y el firmware. 
> 
> Ventajas con respecto a la BIOS:
> * Compatibilidad y emulación del BIOS para los sistemas operativos solo compatibles con esta última.
> * Soporte completo para la Tabla de particiones GUID (GPT), se pueden crear hasta 128 particiones por disco, con una capacidad total de 8 ZB.1​
> * Capacidad de arranque desde unidades de almacenamiento grandes, dado que no sufren de las limitaciones del MBR.
> * Independiente de la arquitectura y controladores de la CPU.
> * Entorno amigable y flexible Pre-Sistema Operativo, incluyendo capacidades de red.
> * Diseño modular.
> 
> Todos las computadores, de los ultimos años, vienen de fabrica con ella. Para acceder se debe precionar una tecla especifica al encender la computadora (normalmente F2 o suprimir). Entre las opciones se encuentra:
> * Cambiar orden de boteo de las diferentes particiones.
> * Habilitar el modo legacy (retrocompatibilidad con particiones MBR - de BIOS).
> * Habilitar/Deshabilitar secure boot.
> * Modificar opciones de seguridad (establecer contraseña entre otras cosas).
> * Visualizar estadisticas.

### 1.2) ¿Menciona casos de bugs de UEFI que puedan ser explotados?

> Debido a la gran cantidad de codigo de UEFI (en comparacion con BIOS) y a otras factores, han surgido varias vulnerabilidades desde su creacion.
> 
> Algunas de estas vulnerabilidades son:
> * Bypass de Secure Boot.
> * Escalada de privilegios de SMM.
> * Implante de firmware UEFI.
> * Implante persistente.
> * Implante no persistente.
> * Mala configuracion de la proteccion por parte del fabricante.
> * Raíz de confianza no segura (puede verse comprometida desde el sistema operativo a través de sus interfaces de comunicación con el firmware como SMM).
> * Dispositivos perifericos maliciosos (instalados en la etapa de produccio o entrega).
> * Actualizaciones de BIOS malisiosas (sobretodo en actualizaciones remotas).
> 
> Tema de claves privadas. Es muy grande

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
