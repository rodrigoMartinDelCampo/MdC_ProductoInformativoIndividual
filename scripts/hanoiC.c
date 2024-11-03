#include <stdio.h>
 
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
