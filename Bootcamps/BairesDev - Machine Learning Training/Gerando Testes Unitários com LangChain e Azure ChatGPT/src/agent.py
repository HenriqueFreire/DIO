# src/agent.py
"""
Módulo do Agente Gerador de Testes

Este módulo contém a classe TestGeneratorAgent, que atua como uma Facade,
orquestrando os outros componentes (analyzer, llm, config) para gerar
os testes unitários.
"""
import logging
from langchain.prompts import PromptTemplate
from langchain.chains import LLMChain

from .analyzer import CodeAnalyzer
from .llm import create_llm
from .config import config

logger = logging.getLogger(__name__)

class TestGeneratorAgent:
    """
    Facade que orquestra a geração de testes unitários.
    """
    def __init__(self):
        """
        Inicializa o agente, instanciando os componentes necessários.
        """
        self.analyzer = CodeAnalyzer()
        self.llm = create_llm()  # Usa a nossa fábrica para obter o LLM
        logger.info("TestGeneratorAgent inicializado.")
        logger.info(f"Agente operando em modo: {'Simulação' if config.simulate_llm else 'Azure OpenAI'}")

    def _create_prompt_template(self) -> PromptTemplate:
        """
        Cria e retorna o template do prompt para o LangChain.
        """
        prompt_text = '''
        Você é um especialista em testes de software e um programador Python experiente, especializado em pytest.
        Sua tarefa é criar testes unitários para o código Python fornecido abaixo.

        ---
        CÓDIGO A SER TESTADO:
        ```python
        {source_code}
        ```
        ---
        ANÁLISE ESTÁTICA DO CÓDIGO:
        - Funções encontradas: {total_functions}
        - Classes encontradas: {total_classes}
        - Complexidade ciclomática: {complexity}
        ---

        **Instruções Estritas:**
        1.  **Framework:** Use `pytest`.
        2.  **Importações:** Importe as funções/classes necessárias do módulo `src.functions`. (Assuma que o código a ser testado está nesse caminho para fins de importação no teste).
        3.  **Casos de Teste:** Crie funções de teste (`def test_*`) cobrindo:
            *   Caminhos de sucesso.
            *   Casos de falha e exceções (use `pytest.raises`).
            *   Casos de borda (edge cases), como valores negativos, zero, etc.
        4.  **Qualidade:** O código de teste deve ser limpo, legível e completo.
        5.  **Formato da Saída:** Retorne APENAS o código Python dos testes. Não inclua nenhuma explicação ou comentários que não façam parte do código de teste em si.

        Gere agora os testes unitários.
        '''
        return PromptTemplate(
            template=prompt_text,
            input_variables=["source_code", "total_functions", "total_classes", "complexity"]
        )

    def generate_tests(self, source_code: str) -> dict:
        """
        Orquestra o processo de geração de testes para um dado código-fonte.

        Args:
            source_code: A string contendo o código Python.

        Returns:
            Um dicionário com o resultado da geração.
        """
        logger.info("Iniciando análise do código-fonte.")
        analysis = self.analyzer.analyze_code(source_code)

        if 'error' in analysis:
            logger.error(f"Erro na análise do código: {analysis['error']}")
            return {'success': False, 'error': analysis['error']}

        logger.info("Análise concluída. Criando prompt para o LLM.")
        stats = analysis['statistics']
        prompt_template = self._create_prompt_template()
        
        chain = LLMChain(llm=self.llm, prompt=prompt_template)

        try:
            logger.info("Invocando o LLM para gerar os testes...")
            
            inputs = {
                "source_code": source_code,
                "total_functions": stats['total_functions'],
                "total_classes": stats['total_classes'],
                "complexity": stats['complexity']
            }

            result = chain.invoke(inputs)
            generated_test_code = result['text']

            logger.info("Testes gerados com sucesso pelo LLM.")
            return {
                'success': True,
                'test_code': generated_test_code,
                'analysis': analysis
            }

        except Exception as e:
            logger.error(f"Erro durante a invocação do LLM: {e}", exc_info=True)
            return {
                'success': False,
                'error': f"Erro ao comunicar com o LLM: {e}"
            }

