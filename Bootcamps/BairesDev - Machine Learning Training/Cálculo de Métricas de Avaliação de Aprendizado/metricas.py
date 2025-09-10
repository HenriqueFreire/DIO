# -*- coding: utf-8 -*-
"""
Este módulo contém funções para calcular métricas de avaliação de modelos de classificação.
"""

def calculate_accuracy(tp, tn, fp, fn):
    """Calcula a acurácia."""
    total = tp + tn + fp + fn
    if total == 0:
        return 0.0
    return (tp + tn) / total

def calculate_recall(tp, fn):
    """Calcula a sensibilidade (recall)."""
    total = tp + fn
    if total == 0:
        return 0.0
    return tp / total

def calculate_specificity(tn, fp):
    """Calcula a especificidade."""
    total = tn + fp
    if total == 0:
        return 0.0
    return tn / total

def calculate_precision(tp, fp):
    """Calcula a precisão."""
    total = tp + fp
    if total == 0:
        return 0.0
    return tp / total

def calculate_f_score(precision, recall):
    """Calcula o F-score."""
    total = precision + recall
    if total == 0:
        return 0.0
    return 2 * (precision * recall) / total

if __name__ == "__main__":
    # Exemplo de uma matriz de confusão arbitrária
    # VP: Verdadeiro Positivo
    # VN: Verdadeiro Negativo
    # FP: Falso Positivo
    # FN: Falso Negativo
    tp = 100
    tn = 50
    fp = 10
    fn = 5

    print(f"Matriz de Confusão Exemplo:")
    print(f"Verdadeiros Positivos (VP): {tp}")
    print(f"Verdadeiros Negativos (VN): {tn}")
    print(f"Falsos Positivos (FP): {fp}")
    print(f"Falsos Negativos (FN): {fn}")
    print("-" * 30)

    # Calculando as métricas
    accuracy = calculate_accuracy(tp, tn, fp, fn)
    recall = calculate_recall(tp, fn)
    specificity = calculate_specificity(tn, fp)
    precision = calculate_precision(tp, fp)
    
    if precision > 0 and recall > 0:
        f_score = calculate_f_score(precision, recall)
    else:
        f_score = 0.0

    print("Resultados das Métricas:")
    print(f"Acurácia: {accuracy:.4f}")
    print(f"Sensibilidade (Recall): {recall:.4f}")
    print(f"Especificidade: {specificity:.4f}")
    print(f"Precisão: {precision:.4f}")
    print(f"F-score: {f_score:.4f}")
