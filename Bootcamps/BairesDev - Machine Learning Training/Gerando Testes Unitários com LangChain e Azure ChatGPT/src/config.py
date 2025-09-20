# src/config.py
"""
Módulo de Configuração

Centraliza o gerenciamento de configurações do sistema, carregando
variáveis de ambiente e fornecendo-as de forma estruturada.
"""

import os
from dotenv import load_dotenv

class ConfigManager:
    """
    Gerencia as configurações do sistema a partir de variáveis de ambiente.
    """
    def __init__(self):
        """
        Inicializa o gerenciador de configurações, carregando as variáveis
        de um arquivo .env.
        """
        load_dotenv()

        # Configurações da Azure OpenAI
        self.azure_api_key = os.getenv('AZURE_OPENAI_API_KEY')
        self.azure_endpoint = os.getenv('AZURE_OPENAI_ENDPOINT')
        self.azure_api_version = os.getenv('AZURE_OPENAI_API_VERSION', '2024-02-01')
        self.azure_deployment_name = os.getenv('AZURE_OPENAI_DEPLOYMENT_NAME')

        # Configurações do Modelo LLM
        self.temperature = float(os.getenv('TEMPERATURE', '0.2'))
        self.max_tokens = int(os.getenv('MAX_TOKENS', '2000'))

        # Configurações do Sistema
        self.output_directory = os.getenv('OUTPUT_DIRECTORY', 'generated_tests')
        self.simulate_llm = not (self.azure_api_key and self.azure_endpoint and self.azure_deployment_name)

    def get_azure_config(self) -> dict:
        """Retorna um dicionário com as configurações da Azure para o LLM."""
        return {
            'api_key': self.azure_api_key,
            'azure_endpoint': self.azure_endpoint,
            'api_version': self.azure_api_version,
            'azure_deployment': self.azure_deployment_name,
            'temperature': self.temperature,
            'max_tokens': self.max_tokens
        }

    def __str__(self) -> str:
        """Retorna uma representação em string das configurações."""
        mode = "Azure OpenAI" if not self.simulate_llm else "Simulação"
        return (
            f"Modo de Operação: {mode}\n"
            f"Endpoint: {self.azure_endpoint}\n"
            f"Deployment: {self.azure_deployment_name}\n"
            f"Diretório de Saída: {self.output_directory}"
        )

# Instância única para ser importada por outros módulos.
# Isso simplifica o acesso à configuração em todo o projeto.
config = ConfigManager()
