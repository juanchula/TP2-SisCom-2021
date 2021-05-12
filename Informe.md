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
> * Actualizaciones de BIOS no autentificadas.
> * BIOS desactualizadas con problemas de seguridad conocidos.
> 
> ![](/images/exploits.png)


### 1.3) ¿Qué es Converged Security and Management Engine (CSME), the Intel Management Engine BIOS Extension (Intel MEBx)?
> Intel CSME es un subsistema integrado y un dispositivo PCIe (Peripheral Component Interconnect Express) que está diseñado para actuar como controlador de seguridad y capacidad de administración en el PCH (Platform Controller Hub).
> 
> Tiene como objetivo implementar un entorno informático aislado del software principal (SW) que ejecuta la CPU, como el BIOS (sistema básico de entrada y salida), el sistema operativo (sistema operativo) y las aplicaciones.
> 
> ![](/images/CSME.png)
> 
>El CSME cumple 3 funciones principales: Inicializacion de silicio, manejabilidad y seguridad. Esta ultima funcionalidad cumple una característica de seguridad que se ejecuta al inicio y es responsable de verificar y autenticar todo el firmware posterior. En otras palabras, proporciona opciones de configuración a nivel de plataforma para poder configurar el Management Engine (ME). Las opciones incluyen la activación y desactivación de funciones individuales y el ajuste de las configuraciones de energía.
> En esencia, es la base de seguridad para verificar todos los procesos sensibles que realiza el chip.
>
> Antes de la versión 11 de ATM, CSME era llamado Intel® Management Engine BIOS Extension (MEBx).


### 1.4) ¿Qué es coreboot? ¿Qué productos lo incorporan? ¿Cuales son las ventajas de su utilización?
> Coreboot es un proyecto de software destinado a reemplazar el firmware propietario (BIOS o UEFI) que se encuentra en la mayoría de las computadoras con un firmware liviano diseñado para realizar solo el número mínimo de tareas necesarias para cargar y ejecutar un sistema operativo moderno de 32 o 64 bits.
> 
> Se puede encontrar coreboot preinstalado en:
> * Dispositivos con Chrome OS (Google), tales como onHub (router inalámbrico) y Pixel C (tablet).
> * Minifree (utiliza la distribución Libreboot).
> * ORWL (ofrece computadoras de escritorio con un principal enfoque en la seguridad).
> * Technoethical (posee hardware con la distribución Libreboot instalada)
> * Purism (fabrica computadoras basándose en el software libre, la seguridad y privacidad en Internet).
> *  System76 (algunos modelos de sus productos tienen el System76 Open Firmware, una distribución open source que incluye el firmare coreboot, EDK2 y aplicaciones de firmware System76).
> 
> Sus ventajas son:
> * Codigo abierto.
> * Flexibilidad: Permite el uso de diferentes payloads, admite SO heredado a traves de SeaBIOS, permite el arranque en red con una ROM iPXE integrada, admite creacion de payloads, permite cargar una pantalla de inicio en formato jpg, etc.
> * Seguridad: Biene con una base informática confiable mínima que reduce la superficie de ataque general. También es compatible con un proceso de arranque seguro llamado VBOOT2. Está escrito en el estándar MISRA-C y proporciona otros lenguajes como Ada para la verificación formal de propiedades especiales. Además, el uso de funciones de la plataforma como IOMMU, protecciones flash y el modo SMM desactivado también aumenta la seguridad.
> * Rendimiento: Está diseñado para arrancar rápidamente. Para equipos de escritorio y portátiles, con frecuencia puede arrancar desde el inicio del sistema operativo en menos de un segundo. En el caso de los servidores, puede reducir el tiempo de arranque en minutos. Algunos proveedores han demostrado una disminución en el tiempo de arranque de más del 70% en comparación con el BIOS OEM.

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


### 3.4) En modo protegido, ¿Con qué valor se cargan los registros de segmento? ¿Porque?
