#include <stdio.h>

int main() {
    char op;
    double first, second;

    printf("Digite um operador (+, -, *, /): ");
    scanf(" %c", &op);

    printf("Digite dois operandos: ");
    scanf("%lf %lf", &first, &second);

    switch (op) {
        case '+':
            printf("%.1lf + %.1lf = %.1lf\n", first, second, first + second);
            break;
        case '-':
            printf("%.1lf - %.1lf = %.1lf\n", first, second, first - second);
            break;
        case '*':
            printf("%.1lf * %.1lf = %.1lf\n", first, second, first * second);
            break;
        case '/':
            if (second != 0.0) {
                printf("%.1lf / %.1lf = %.1lf\n", first, second, first / second);
            } else {
                printf("Erro! Divisão por zero não é permitida.\n");
            }
            break;
        default:
            printf("Erro! Operador inválido.\n");
    }

    return 0;
}
