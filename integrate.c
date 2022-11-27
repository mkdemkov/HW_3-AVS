#include <stdio.h>

// функция подсчета значения в функции
double func(double a, double l, double r) {
    return l + r * a * a * a;
}

// Интегрирование методом трапеций
double integrate(int left, int right, int n) {
    double h = (right - left) / n;
    double sum = (func(left, left, right) + func(right, left, right)) / 2;
    for (double i = left + h; i < right; i++) {
        sum += func(i, left, right);
    }
    return sum;
}

int main()
{
    int a, b, n; 
    scanf("%d", &a); // вводим левую границу
    scanf("%d", &b); // вводим правую границу
    scanf("%d", &n); // вводим число отрезков
    double ans = integrate(a, b, n);
    printf("%f", ans);
    return 0;
}