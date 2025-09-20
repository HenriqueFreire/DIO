# src/functions.py

def soma(a: int, b: int) -> int:
    """
    Esta função recebe dois números inteiros e retorna a soma deles.
    """
    return a + b

def divisao(a: float, b: float) -> float:
    """
    Esta função recebe dois números e retorna a divisão de a por b.
    Lança uma exceção ZeroDivisionError se b for zero.
    """
    if b == 0:
        raise ZeroDivisionError("Não é possível dividir por zero.")
    return a / b
