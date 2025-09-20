# src/llm.py
"""
Módulo da Fábrica de LLM (Factory Method)

Responsável por criar e fornecer a instância correta do modelo de linguagem (LLM),
seja o modelo real da Azure ou um modelo simulado para fins de teste.
"""
import logging
from .config import config  # Importa a instância da configuração

# Configuração do logger para este módulo
logger = logging.getLogger(__name__)

class SimulatedLLM:
    """
    LLM simulado para demonstração e testes quando a API da Azure não está configurada.
    Ele imita a interface de um LLM do LangChain, como o método 'invoke'.
    """
    def invoke(self, prompt: dict) -> str:
        """
        Simula uma resposta do LLM, retornando um template de teste genérico.
        O 'prompt' é recebido, mas não utilizado na simulação.
        """
        logger.info("LLM Simulado invocado. Retornando um template de teste.")
        return '''
import pytest

# --- Testes gerados em MODO DE SIMULAÇÃO ---
# Para gerar testes reais, configure suas variáveis de ambiente no arquivo .env

def test_simulado_exemplo_sucesso():
    """Teste de sucesso gerado pelo modo de simulação."""
    assert True

def test_simulado_exemplo_falha():
    """Teste de falha gerado pelo modo de simulação."""
    with pytest.raises(ValueError):
        raise ValueError("Este é um erro de exemplo")
'''

def create_llm():
    """
    Fábrica de LLM (Factory Function).

    Verifica a configuração e decide qual LLM instanciar.
    - Se o modo de simulação estiver ativo, retorna o SimulatedLLM.
    - Caso contrário, tenta instanciar e retornar o AzureChatOpenAI.
    - Se a biblioteca do LangChain não estiver instalada, retorna o SimulatedLLM como fallback.

    Returns:
        Uma instância de um LLM (real ou simulado).
    """
    if config.simulate_llm:
        logger.warning("Modo de simulação ativado. Usando LLM simulado.")
        return SimulatedLLM()
    
    try:
        from langchain_openai import AzureChatOpenAI
        
        logger.info("Modo Azure OpenAI ativado. Instanciando AzureChatOpenAI.")
        
        # Obtém as configurações e as passa para o construtor do AzureChatOpenAI
        azure_config = config.get_azure_config()
        
        return AzureChatOpenAI(
            azure_deployment=azure_config["azure_deployment"],
            api_version=azure_config["api_version"],
            azure_endpoint=azure_config["azure_endpoint"],
            api_key=azure_config["api_key"],
            temperature=azure_config["temperature"],
            max_tokens=azure_config["max_tokens"],
        )

    except ImportError:
        logger.error("O pacote 'langchain-openai' não está instalado.")
        logger.warning("Retornando ao modo de simulação.")
        return SimulatedLLM()
    except Exception as e:
        logger.error(f"Erro ao instanciar o AzureChatOpenAI: {e}")
        logger.warning("Retornando ao modo de simulação.")
        return SimulatedLLM()

