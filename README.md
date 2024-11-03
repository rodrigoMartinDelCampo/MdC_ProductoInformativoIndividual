
# Instituto Tecnológico y de Estudios Superiores de Occidente

## Producto Informativo Especializado

### Solución Recursiva al Rompecabezas Torres de Hanoi en Ensamblador (Arquitectura RISC-V)

**Presenta:** Rodrigo Martín del Campo Arroyo

**Asignatura:** Información y Autoaprendizaje en la Era Digital

**Profesor:** Guillermo López Villegas


---



## Índice

1. [Introducción](#introduccion)
2. [Glosario](#glosario)
3. [Capítulo 1](#capitulo-1)
   - [1.1 Qué es el problema de las Torres de Hanoi y cómo se pueden implementar algoritmos para su solución](#que-es-el-problema-de-las-torres-de-hanoi-y-como-se-pueden-implementar-algoritmos-para-su-solucion)
   - [1.2 Arquitectura RISC-V y su ISA (características, etc.)](#arquitectura-risc-v-y-su-isa-caracteristicas-etc)
4. [Capítulo 2](#capitulo-2)
   - [Implementación de algoritmo de solución de las Torres de Hanoi en lenguaje ensamblador para arquitectura RISC-V (Proceso de investigación, fuentes, cómo es una implementación recursiva, por qué vamos a hacer una implementación recursiva para su solución, etc.)](#implementacion-de-algoritmo-de-solucion-de-las-torres-de-hanoi-en-lenguaje-ensamblador-para-arquitectura-risc-v)
5. [Capítulo 3](#capitulo-3)
   - [Análisis y breakdown del código generado y comparación con código en C](#analisis-y-breakdown-del-codigo-generado-y-comparacion-con-codigo-en-c)
6. [Capítulo 4](#capitulo-4)
   - [Análisis matemático de los resultados cuantitativos de la implementación del algoritmo](#analisis-matematico-de-los-resultados-cuantitativos-de-la-implementacion-del-algoritmo)
7. [Conclusiones](#conclusiones)
   - [Por qué la implementación del algoritmo es la ideal](#por-que-la-implementacion-del-algoritmo-es-la-ideal)
8. [Bibliografía](#bibliografia)
9. [Vínculos al Código Fuente](#vinculos-al-codigo-fuente)

---
<a id="introduccion"></a>

## Introducción

En este trabajo, abordaré la pregunta: **¿cómo se puede implementar el algoritmo de las Torres de Hanoi de manera recursiva en un lenguaje ensamblador de arquitectura RISC-V y hacerlo lo más eficaz posible?** A lo largo del desarrollo, mencionaré diversas fuentes y consideraciones a tener en cuenta al realizar una implementación de este tipo.

Mi investigación surgió de la necesidad de llevar a cabo una implementación para una práctica de mi clase de **Organización y Arquitectura de Computadoras**. Sin embargo, encontré que es difícil acceder a información precisa que ofrezca una guía clara sobre cómo realizar esta implementación. En línea, no he encontrado una solución específica con la **ISA** de arquitectura **RISC-V** en ninguna de las principales plataformas para desarrolladores, como GeeksforGeeks o GitHub.

A pesar de los avances significativos en inteligencia artificial y en herramientas como ChatGPT y Copilot, hasta ahora, estas aplicaciones no han logrado generar un código funcional que cumpla con los requisitos necesarios para una **implementación óptima del algoritmo**.

Este trabajo pretende cubrir, aunque de manera superficial, las bases y consideraciones necesarias para implementar el algoritmo de las Torres de Hanoi en ensamblador **RISC-V**. Además, proporcionaré acceso a una solución optimizada, explicada y cuyos resultados cuantitativos serán analizados para respaldar el resultado óptimo al que he llegado.

**Palabras clave:** **ISA**, **lenguaje ensamblador**, **arquitectura de computadora**, **organización de computadora**, **optimización de código**, **recursividad**.

<a id="glosario"></a>

## Glosario

**ISA (Arquitectura del Conjunto de Instrucciones):** El ISA define el conjunto de instrucciones y operaciones que una CPU puede realizar. Es el puente entre el hardware y el software, proporcionando las instrucciones que la máquina debe ejecutar para procesar tareas específicas. Incluye instrucciones aritméticas, de control y de manipulación de datos. (Wikipedia - Instruction Set Architecture)

**Lenguaje Ensamblador:** Es un lenguaje de programación de bajo nivel que utiliza instrucciones simbólicas, fáciles de recordar, para controlar directamente el hardware de una computadora. A diferencia de los lenguajes de alto nivel, el ensamblador permite a los programadores trabajar de cerca con la arquitectura de la máquina, proporcionando control detallado sobre la CPU y la memoria. (Britannica - Assembly Language)

**Arquitectura de Computadora:** Se refiere a los atributos visibles para un programador que impactan el comportamiento lógico de un sistema informático, como el conjunto de instrucciones, la organización del almacenamiento y los tipos de datos. La arquitectura de computadoras define cómo el sistema de hardware y el software interactúan para ejecutar tareas específicas. (Britannica - Computer Architecture)

**Organización de Computadora:** Se refiere a la estructura interna de la computadora, incluyendo sus componentes físicos como la CPU, la memoria y los dispositivos de entrada/salida, y cómo estos interactúan. Aunque está relacionada con la arquitectura, la organización se enfoca más en la implementación y el diseño físico del sistema. (Britannica - Computer Organization)

**Optimización de Código:** Es el proceso de mejorar un programa para reducir su consumo de recursos (como tiempo de ejecución o uso de memoria) y mejorar su eficiencia general. Este proceso implica técnicas como la eliminación de redundancias, la reestructuración del código y el uso eficiente de recursos de hardware. (Wikipedia - Code Optimization)

**Recursividad:** Es un método en programación donde una función se llama a sí misma para resolver un problema, dividiéndolo en subproblemas más pequeños hasta llegar a un caso base. Es especialmente útil para problemas que pueden descomponerse en pasos repetitivos, como el cálculo factorial o la resolución del problema de la torre de Hanoi. (Britannica - Recursion)

<a id="capitulo-1"></a>

## Capítulo 1

<a id="que-es-el-problema-de-las-torres-de-hanoi-y-como-se-pueden-implementar-algoritmos-para-su-solucion"></a>

### 1.1 Qué es el problema de las Torres de Hanoi y cómo se pueden implementar algoritmos para su solución
### ¿Qué es la Torre de Hanoi?

La **Torre de Hanoi** es un rompecabezas clásico que consta de tres estacas y una serie de discos de diferentes tamaños que pueden colocarse en estas estacas. Como lo explican Mataix-Cols y Bartres-Faz:

> "El rompecabezas de la Torre de Hanoi consta de tres estacas y un número de discos de tamaños graduados que encajan en las estacas. Los discos se disponen inicialmente en la estaca de inicio más a la izquierda y se requiere que los participantes muevan los discos desde la estaca de inicio y los rearmen en el orden original en la estaca más a la derecha, respetando las siguientes dos reglas: (a) Solo se puede mover un disco a la vez, y (b) no se puede colocar un disco más grande sobre un disco más pequeño. Se puede usar cualquier número de discos; el número mínimo de movimientos para una solución es \(2^n - 1\), donde \(n\) es el número de discos."  
> — *Mataix-Cols, D., & Bartres-Faz, D. (2002). Is the Use of the Wooden and Computerized Versions of the Tower of Hanoi Puzzle Equivalent? Applied Neuropsychology, 9(2), 117–120.*  
> [https://doi-org.ezproxy.iteso.mx/10.1207/S15324826AN0902_8](https://doi-org.ezproxy.iteso.mx/10.1207/S15324826AN0902_8)

Tomando en cuenta que lo que describen Mataix-Cols y Bartres-Faz, es en escencia un algoritmo, a continuación se muestra una imagen que facilita la comprensión de éste así como de sus pasos y restricciones para un caso en el que se trabaja con 3 discos:

![foto-hanoi](assets/img/tower-of-hanoi.png)

*Program for Tower of Hanoi Algorithm. GeeksforGeeks.*


<a id="arquitectura-risc-v-y-su-isa-caracteristicas-etc"></a>

### 1.2 Arquitectura RISC-V y su ISA (características, etc.)
(Tu contenido aquí)

<a id="capitulo-2"></a>

## Capítulo 2

<a id="implementacion-de-algoritmo-de-solucion-de-las-torres-de-hanoi-en-lenguaje-ensamblador-para-arquitectura-risc-v"></a>

### Implementación de algoritmo de solución de las Torres de Hanoi en lenguaje ensamblador para arquitectura RISC-V
(Tu contenido aquí sobre el proceso de investigación, fuentes, cómo es una implementación recursiva y por qué vamos a usarla para la solución)

<a id="capitulo-3"></a>

## Capítulo 3

<a id="analisis-y-breakdown-del-codigo-generado-y-comparacion-con-codigo-en-c"></a>

### Análisis y breakdown del código generado y comparación con código en C


### Código en C

A continuación, se muestra la función recursiva en C que resuelve el rompecabezas de las Torres de Hanoi:

```c
// Función recursiva en C para resolver el rompecabezas de la torre de Hanoi
void towerOfHanoi(int n, char from_rod, char to_rod, char aux_rod)
{
    if (n == 1)
    {
        printf("\n Mover disco 1 desde la varilla %c a la varilla %c", from_rod, to_rod);
        return;
    }
    towerOfHanoi(n-1, from_rod, aux_rod, to_rod);
    printf("\n Mover disco %d desde la varilla %c a la varilla %c", n, from_rod, to_rod);
    towerOfHanoi(n-1, aux_rod, to_rod, from_rod);
}

int main()
{
    int n = 4; // Número de discos
    towerOfHanoi(n, 'A', 'C', 'B');  // A, B y C son nombres de las varillas
    return 0;
}
```
**Explicación del Código en C**

*Función towerOfHanoi:*

- La función recibe cuatro parámetros: el número de discos n, la varilla de origen from_rod, la varilla de destino to_rod, y la varilla auxiliar aux_rod.
Caso base: Si n es igual a 1, imprime que se mueve el disco desde la varilla de origen a la varilla de destino y termina la función.

```c
if (n == 1)
{
    printf("\n Mover disco 1 desde la varilla %c a la varilla %c", from_rod, to_rod);
    return;
}
```


Llamadas recursivas:
- Llama a sí misma para mover n-1 discos de la varilla de origen a la varilla auxiliar.
- Luego, imprime que se mueve el disco n de la varilla de origen a la varilla de destino.
- Finalmente, llama a sí misma de nuevo para mover n-1 discos de la varilla auxiliar a la varilla de destino.


```c
towerOfHanoi(n-1, from_rod, aux_rod, to_rod);
printf("\n Mover disco %d desde la varilla %c a la varilla %c", n, from_rod, to_rod);
towerOfHanoi(n-1, aux_rod, to_rod, from_rod);
```

*Función main:*

- Define el número de discos (4 en este caso) y llama a la función towerOfHanoi para iniciar el proceso de mover los discos desde la varilla 'A' a la varilla 'C', usando 'B' como varilla auxiliar.

```c
int main()
{
    int n = 4; // Número de discos
    towerOfHanoi(n, 'A', 'C', 'B');  // A, B y C son nombres de las varillas
    return 0;
}
```

### Código en Ensamblador RISC-V

```asm
.text

main:
    # variable n = x cantidad de discos
    addi s0, zero, 15

    # apuntador a torre 1, 2, y 3
    lui s1, 0x10010
    addi s2, s1, 4
    addi s3, s2, 4
    
    # variables de apoyo
    addi t1, zero, 1 
    add t2, zero, s0 
    addi t3, zero, 1
    
    # creacion torre 1 e inicializar torre 2 y torre 3
for: 
    blt t2, t1, endFor
        # agregamos el disco más pequeño en el apuntador más "alto" de la torre 1 (disco más pequeño = 1)
        sw t3, 0(s1)
        
        # decrementamos el valor de la variable de apoyo t2 para la función del ciclo
        addi t2, t2, -1
        
        # aumentamos el valor de la variable de apoyo t3 para que en la próxima entrada al ciclo, su valor sea 2 (el siguiente disco más pequeño)
        addi t3, t3, 1
        
        # recorremos el apuntador de la torre 1, 2, y 3 hacia abajo para que quede de la altura n
        addi s1, s1, 32
        addi s2, s2, 32
        addi s3, s3, 32
        
        # retornamos al ciclo
        jal ra, for

endFor:
    # dejamos establecido el apuntador de la primera torre (su posición más "alta") y llamamos a la función de torre de hanoi
    lui s1, 0x10010    
    jal ra, towerOfHanoi
    jal zero, endCode
    
towerOfHanoi:
    # verificamos si n == 1, en cuyo caso realizamos el movimiento base
    beq s0, t1, baseCase    # if n == 1, ir a caso base

    # guardamos en el stack ra y s0 antes de la recursión
    addi sp, sp, -8        # ajustamos el offset del stack para realizar los push en 3 líneas 
    sw ra, 0(sp)           # push de ra en el stack
    sw s0, 4(sp)           # push del disco al stack con offset 4

    # decrementamos n en 1 (n -= 1)
    addi s0, s0, -1

    # hacemos swap entre torre 2 y torre 3 para hacer los movimientos de los discos como en la función en C
    add s4, zero, s2          # aux = torre 2
    add s2, zero, s3          # torre 2 = torre 3
    add s3, zero, s4          # torre 3 = aux

    # primera llamada recursiva: movemos n-1 discos de torre 1 a torre 2
    jal ra, towerOfHanoi

    # regresamos torres 2 y 3 a su estado original luego de la recursion
    add s5, zero, s2          # aux = torre 2
    add s2, zero, s3          # torre 2 = torre 3
    add s3, zero, s5          # torre 3 = aux

    # pops del stack (s0 y ra)
    lw s0, 4(sp)              # pop del disco
    lw ra, 0(sp)              # pop de ra
    addi sp, sp, 8            # ajustamos stack

    # mover disco desde torre 1 a torre destino
    sw zero, 0(s1)            # quitamos el disco de la torre origen o torre 1
    addi s1, s1, 32           # ajustamos el apuntador de torre 1 para que apunte al siguiente disco
    addi s3, s3, -32          # ajustamos el apuntador de torre 3 para que apunte al espacio en memoria correcto
    sw s0, 0(s3)              # colocamos el disco en torre destino

    # guardamos en el stack antes de la segunda recursión
    addi sp, sp, -8           # ajustamos el offset del stack para realizar los push en 3 líneas 
    sw ra, 0(sp)              # push de ra en el stack
    sw s0, 4(sp)              # push del disco al stack con offset 4

    # decrementamos n nuevamente en 1 (n -= 1)
    addi s0, s0, -1

    # swapeamos torre 1 y torre 2
    add s6, zero, s2          # aux = torre 2
    add s2, zero, s1          # torre 2 = torre 1
    add s1, zero, s6          # torre 1 = aux

    # segunda llamada recursiva: movemos n-1 discos de torre 2 a torre 3
    jal ra, towerOfHanoi

    # regresamos las torres 1 y 2 a sus valores originales
    add s7, zero, s2          # aux = torre 2
    add s2, zero, s1          # torre 2 = torre 1
    add s1, zero, s7          # torre 1 = aux

    # restauramos el stack luego de la segunda recursion
    lw s0, 4(sp)              # pop del disco
    lw ra, 0(sp)              # pop de ra
    addi sp, sp, 8            # ajustamos stack

    # retorno
    jalr zero, ra, 0     

baseCase:
    # caso base: mover un solo disco de torre 1 a torre 3
    sw zero, 0(s1)            # eliminamos el disco de torre 1
    addi s1, s1, 32           # ajustamos el apuntador de torre 1 
    addi s3, s3, -32          # ajustamos el apuntador de torre 3 
    sw s0, 0(s3)              # colocamos el disco en torre 3

    # retorno
    jalr zero, ra, 0         

endCode: 
    nop

```

**Explicación del Código en RISC-V ISA**

*Variables y Punteros:*

- Inicialmente, se establece el número de discos n en 15. Los punteros a las tres torres se inicializan, apuntando a direcciones de memoria para las torres.

*Ciclo para Inicializar Torres:*

- Se usa un ciclo for para llenar la primera torre con los discos, comenzando con el más pequeño. Cada disco se almacena en la memoria y el puntero se ajusta para reflejar el nuevo estado de la torre.

*Función towerOfHanoi:*

- Esta función realiza el algoritmo de la Torre de Hanoi de manera recursiva. Comienza verificando si n es 1, en cuyo caso realiza el movimiento base (mover un disco de la torre 1 a la torre 3).

*Guardado de Contexto:*

- Antes de hacer llamadas recursivas, se guarda el estado de los registros ra (retorno) y s0 (número de discos) en el stack.

*Movimiento de Discos:*

- Después de mover n-1 discos de la torre 1 a la torre 2, se mueve el disco más grande directamente a la torre 3. Luego, se restauran las torres a su estado original y se realizan más movimientos recursivos.

*Caso Base:*

- Cuando se alcanza el caso base, un solo disco se mueve directamente de la torre 1 a la torre 3.

*Uso del Stack:*

- Las instrucciones `sw` (store word) y `lw` (load word) se utilizan para manipular el stack, la cual es nuestra estructura de datos a usar para no perder el flujo ni los valores de los discos cuando entremos en las distintas recursiones. A continuación, se explica cómo se emplean en este contexto:

- *Almacenamiento en el Stack (`sw`)*:
  - Antes de hacer la llamada recursiva, el valor de `s0` (el número de discos) y la dirección de retorno `ra` se almacenan en el stack con las siguientes instrucciones:

    ```asm
    addi sp, sp, -8      # Ajustar el puntero de stack para hacer espacio
    sw ra, 0(sp)         # Almacenar la dirección de retorno en el stack
    sw s0, 4(sp)         # Almacenar el valor del disco en el stack
    ```

  - Aquí, el puntero del stack `sp` se decrementa para hacer espacio para dos palabras (8 bytes en total). `ra` se almacena en la parte superior del stack y `s0` se almacena justo debajo.

- *Recuperación del Stack (`lw`)*:
  - Después de que se completa la llamada recursiva, se recuperan los valores de `s0` y `ra` con las instrucciones:

    ```asm
    lw s0, 4(sp)         # Recuperar el valor del disco del stack
    lw ra, 0(sp)         # Recuperar la dirección de retorno del stack
    addi sp, sp, 8       # Ajustar el puntero de stack de nuevo
    ```

  - Las instrucciones `lw` cargan los valores de vuelta a los registros correspondientes, y luego se ajusta `sp` para volver a su posición original.

*Uso de los Swaps de Torres:*

- Los swaps se utilizan para cambiar las torres de origen y destino antes de realizar una llamada recursiva. Esto es esencial para la lógica del algoritmo de la Torre de Hanoi, donde movemos discos de una torre a otra.

  - *Swapeamos torre 1 y torre 2*:

    ```asm
    add s6, zero, s2          # aux = torre 2
    add s2, zero, s1          # torre 2 = torre 1
    add s1, zero, s6          # torre 1 = aux
    ```

- En este bloque, el contenido de la torre 2 se guarda en el registro s6, luego el contenido de la torre 1 se asigna a la torre 2, y finalmente, el contenido de s6 (originalmente torre 2) se asigna a la torre 1. Esto cambia efectivamente el papel de las torres para la llamada recursiva.

  - *Regresamos las torres 1 y 2 a sus valores originales:*

    ```asm
    add s7, zero, s2          # aux = torre 2
    add s2, zero, s1          # torre 2 = torre 1
    add s1, zero, s7          # torre 1 = aux
    ```

- Después de la llamada recursiva, los valores se restauran a su estado original para que la función pueda continuar con su ejecución sin perder el contexto de las torres. Este enfoque asegura que la función recursiva maneje correctamente los movimientos de los discos, manteniendo la lógica del algoritmo de la Torre de Hanoi.

*Ciclo de Movimiento:*

- Cuando se mueve un disco de la torre 1 a la torre 3, se utiliza sw para eliminar el disco de la torre de origen y colocarlo en la torre de destino.
- La instrucción sw zero, 0(s1) elimina el disco de la torre 1, y sw s0, 0(s3) coloca el disco en la torre 3, manteniendo así el seguimiento de los discos en cada torre a medida que se realizan las operaciones.

### Comparación Implementación en C y Ensamblador

| Aspecto                    | Código en C                                      | Código en Ensamblador                                   |
|----------------------------|--------------------------------------------------|--------------------------------------------------------|
| Estructura de Recursión     | Automática con llamadas a sí mismo               | Manual usando `jal` y `jalr`                            |
| Manejo del Stack            | Automático, gestionado por el compilador         | Manual, requiere `sw` y `lw`                            |
| Intercambio de Torres       | Cambia en los argumentos de la función           | Cambios directos en registros con `add`                 |
| Simplicidad del Código      | Más conciso y fácil de entender                  | Más detallado y complejo                               |
| Eficiencia y Control Directo| Control limitado (gestionado por el compilador)  | Control total (optimizable pero propenso a errores)     |


<a id="capitulo-4"></a>

## Capítulo 4

<a id="analisis-matematico-de-los-resultados-cuantitativos-de-la-implementacion-del-algoritmo"></a>

### Análisis matemático de los resultados cuantitativos de la implementación del algoritmo
(Tu contenido aquí)

<a id="conclusiones"></a>

## Conclusiones

<a id="por-que-la-implementacion-del-algoritmo-es-la-ideal"></a>

### Por qué la implementación del algoritmo es la ideal
(Tu contenido aquí)

<a id="bibliografia"></a>

## Bibliografía

> - *Mataix-Cols, D., & Bartres-Faz, D. (2002). Is the Use of the Wooden and Computerized Versions of the Tower of Hanoi Puzzle Equivalent? Applied Neuropsychology, 9(2), 117–120.* [https://doi-org.ezproxy.iteso.mx/10.1207/S15324826AN0902_8](https://doi-org.ezproxy.iteso.mx/10.1207/S15324826AN0902_8)
> 
> - GeeksforGeeks. (2024, 9 mayo). *Program for Tower of Hanoi Algorithm.* GeeksforGeeks. [https://www.geeksforgeeks.org/c-program-for-tower-of-hanoi/](https://www.geeksforgeeks.org/c-program-for-tower-of-hanoi/)

<a id="vinculos-al-codigo-fuente"></a>

## Vínculos al Código Fuente

- [Implementación del algoritmo en C.](https://github.com/rodrigoMartinDelCampo/MdC_ProductoInformativoIndividual/blob/main/scripts/hanoiC.c) 
- [Implementación del algoritmo en ensamblador.](https://github.com/rodrigoMartinDelCampo/MdC_ProductoInformativoIndividual/blob/main/scripts/hanoiAssembly.asm)

