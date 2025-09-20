import pytest
from src.functions import soma, divisao

# Testes para a função soma
def test_soma_sucesso():
    """Testa a soma de dois números positivos."""
    assert soma(5, 5) == 10

def test_soma_com_zero():
    """Testa a soma com zero."""
    assert soma(10, 0) == 10

def test_soma_com_negativos():
    """Testa a soma de números negativos."""
    assert soma(-5, -5) == -10

def test_soma_positivo_e_negativo():
    """Testa a soma de um número positivo e um negativo."""
    assert soma(10, -5) == 5

# Testes para a função divisao
def test_divisao_sucesso():
    """Testa a divisão de dois números."""
    assert divisao(10, 2) == 5

def test_divisao_por_zero():
    """Testa a divisão por zero, que deve levantar uma exceção."""
    with pytest.raises(ZeroDivisionError):
        divisao(10, 0)

def test_divisao_resultado_decimal():
    """Testa uma divisão que resulta em um número decimal."""
    assert divisao(5, 2) == 2.5

def test_divisao_com_negativos():
    """Testa a divisão com números negativos."""
    assert divisao(-10, 2) == -5
    assert divisao(10, -2) == -5
