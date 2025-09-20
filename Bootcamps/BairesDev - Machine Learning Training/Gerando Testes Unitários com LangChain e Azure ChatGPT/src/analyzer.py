# src/analyzer.py
"""
Módulo de Análise de Código Estático

Este módulo contém a classe CodeAnalyzer, que utiliza a biblioteca 'ast'
para analisar o código-fonte Python, extrair metadados e calcular métricas
como a complexidade ciclomática.
"""
import ast
from typing import Dict, Any, List

class CodeAnalyzer:
    """
    Analisa um código-fonte Python para extrair informações estruturais e métricas.
    """

    def analyze_code(self, source_code: str) -> Dict[str, Any]:
        """
        Analisa uma string de código Python e extrai uma estrutura de dados
        com informações sobre funções, classes, imports e métricas.

        Args:
            source_code: A string contendo o código Python a ser analisado.

        Returns:
            Um dicionário com os dados da análise ou um dicionário de erro.
        """
        try:
            tree = ast.parse(source_code)
            
            functions = []
            classes = []
            imports = []
            
            for node in ast.walk(tree):
                if isinstance(node, ast.FunctionDef):
                    functions.append({
                        'name': node.name,
                        'parameters': [arg.arg for arg in node.args.args],
                        'line': node.lineno,
                    })
                elif isinstance(node, ast.ClassDef):
                    methods = [n.name for n in node.body if isinstance(n, ast.FunctionDef)]
                    classes.append({
                        'name': node.name,
                        'methods': methods,
                        'line': node.lineno
                    })
                elif isinstance(node, ast.Import):
                    imports.extend([alias.name for alias in node.names])
                elif isinstance(node, ast.ImportFrom) and node.module:
                    imports.append(node.module)

            statistics = {
                'total_functions': len(functions),
                'total_classes': len(classes),
                'total_lines': len(source_code.splitlines()),
                'complexity': self._calculate_complexity(tree)
            }
            
            return {
                'functions': functions,
                'classes': classes,
                'imports': sorted(list(set(imports))), # Remove duplicatas e ordena
                'statistics': statistics,
            }
            
        except SyntaxError as e:
            return {'error': f'Erro de sintaxe no código fornecido: {e}'}
        except Exception as e:
            return {'error': f'Ocorreu um erro inesperado durante a análise: {e}'}

    def _calculate_complexity(self, tree: ast.AST) -> int:
        """
        Calcula uma aproximação da complexidade ciclomática de um código.

        A complexidade ciclomática é uma métrica que quantifica o número de
        caminhos linearmente independentes através do código.

        Args:
            tree: A árvore de sintaxe abstrata do código.

        Returns:
            O valor da complexidade calculada.
        """
        complexity = 1
        
        for node in ast.walk(tree):
            if isinstance(node, (ast.If, ast.While, ast.For, ast.AsyncFor, ast.ExceptHandler)):
                complexity += 1
            elif isinstance(node, ast.BoolOp) and node.op in (ast.And, ast.Or):
                complexity += len(node.values) - 1
        
        return complexity
