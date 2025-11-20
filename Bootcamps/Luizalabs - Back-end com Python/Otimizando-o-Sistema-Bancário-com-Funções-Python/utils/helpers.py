# Funções auxiliares

def ler_float(msg):
    while True:
        try:
            return float(input(msg))
        except ValueError:
            print("Valor inválido! Digite um número.")

def ler_int(msg):
    while True:
        try:
            return int(input(msg))
        except ValueError:
            print("Valor inválido! Digite um número inteiro.")
