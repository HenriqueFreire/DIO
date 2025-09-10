# -*- coding: utf-8 -*-
"""
Este módulo define Callbacks personalizados para o Keras.
"""

import tensorflow as tf
import numpy as np
from metricas import (
    calculate_accuracy,
    calculate_recall,
    calculate_specificity,
    calculate_precision,
    calculate_f_score
)

class MetricsCallback(tf.keras.callbacks.Callback):
    """
    Callback para calcular e exibir métricas de classificação ao final de cada época.
    """
    def __init__(self, validation_data):
        super().__init__()
        self.validation_data = validation_data

    def on_epoch_end(self, epoch, logs=None):
        logs = logs or {}
        
        # Inicializa contadores para a matriz de confusão
        tp, tn, fp, fn = 0, 0, 0, 0

        # Itera sobre o conjunto de validação para obter as predições
        for x_val, y_val in self.validation_data:
            predictions = self.model.predict(x_val, verbose=0)
            # Converte logits para predições binárias (0 ou 1)
            y_pred = (np.sign(predictions) + 1) / 2
            y_pred = y_pred.flatten().astype(int)
            y_true = y_val.numpy().flatten().astype(int)

            # Calcula VP, VN, FP, FN para o batch atual
            tp += np.sum((y_true == 1) & (y_pred == 1))
            tn += np.sum((y_true == 0) & (y_pred == 0))
            fp += np.sum((y_true == 0) & (y_pred == 1))
            fn += np.sum((y_true == 1) & (y_pred == 0))

        # Calcula as métricas usando as funções importadas
        accuracy = calculate_accuracy(tp, tn, fp, fn)
        recall = calculate_recall(tp, fn)
        specificity = calculate_specificity(tn, fp)
        precision = calculate_precision(tp, fp)
        
        if precision > 0 and recall > 0:
            f_score = calculate_f_score(precision, recall)
        else:
            f_score = 0.0

        # Exibe o relatório da época
        print(f"\n--- Relatório da Época {epoch + 1} ---")
        print(f"Matriz de Confusão: VP={tp}, VN={tn}, FP={fp}, FN={fn}")
        print(f"Acurácia de Validação (calculada): {accuracy:.4f}")
        print(f"Sensibilidade (Recall): {recall:.4f}")
        print(f"Especificidade: {specificity:.4f}")
        print(f"Precisão: {precision:.4f}")
        print(f"F-score: {f_score:.4f}")
        print("-----------------------------------\n")
