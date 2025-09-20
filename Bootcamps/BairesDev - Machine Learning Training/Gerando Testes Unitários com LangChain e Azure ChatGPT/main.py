# main.py
"""
Sistema de Geração de Testes Unitários com LangChain e Azure ChatGPT

Interface de linha de comando (CLI) principal para interagir com o agente de testes.
"""

import os
import sys
import json
import logging
import argparse
from pathlib import Path
from datetime import datetime
from typing import Optional, List, Dict, Any

# Configuração básica de logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

# Importa os módulos do nosso projeto
from src.config import config
from src.llm import SimulatedLLM # Para o banner de simulação
from src.analyzer import CodeAnalyzer
from src.agent import TestGeneratorAgent

class TestGeneratorCLI:
    """
    Interface de linha de comando principal para o sistema de geração de testes.
    """
    def __init__(self):
        """
        Inicializa a CLI, o gerenciador de configurações e o agente de testes.
        """
        self.config = config # A instância global de configuração
        self.agent = TestGeneratorAgent()
        self.analyzer = CodeAnalyzer() # Para análise rápida e display
        self.statistics = {
            'total_generations': 0,
            'successful_generations': 0,
            'failed_generations': 0,
            'start_time': datetime.now()
        }
        
        # Cria diretórios necessários
        self._create_necessary_directories()
    
    def _create_necessary_directories(self):
        """Cria diretórios de saída e logs."""
        Path(self.config.output_directory).mkdir(parents=True, exist_ok=True)
        Path('logs').mkdir(exist_ok=True) # Exemplo: para logs mais detalhados
        logger.info(f"Diretório de saída criado/verificado: {self.config.output_directory}")

    def display_banner(self):
        """Exibe o banner de boas-vindas do sistema."""
        banner = """
╔══════════════════════════════════════════════════════════════════════════════╗
║                     SISTEMA DE GERAÇÃO DE TESTES UNITÁRIOS                  ║
║                          LangChain + Azure ChatGPT                          ║
║                                                                              ║
║  Desenvolvido por: Edson Gomes (Adaptado por Gemini)                        ║
║  Bootcamp: DIO + BairesDev Machine Learning                                 ║
║  GitHub: @edsongom1                                                          ║
╚══════════════════════════════════════════════════════════════════════════════╝
        """
        print(banner)
        
        if self.config.simulate_llm:
            print("⚠️  MODO SIMULAÇÃO ATIVO")
            print("   Configure as variáveis Azure OpenAI no seu .env para usar o modo completo.")
        
        print()
    
    def display_main_menu(self):
        """Exibe o menu principal de opções para o usuário."""
        print("OPÇÕES DISPONÍVEIS:")
        print("─" * 50)
        print("1. 📝 Gerar testes para código Python (interativo)")
        print("2. 📁 Processar arquivo(s) de código")
        print("3. 🔍 Analisar código (sem gerar testes)")
        print("4. 🧪 Executar exemplo de demonstração")
        print("5. ⚙️  Configurações do sistema")
        print("6. 📊 Estatísticas da sessão")
        print("7. ❓ Ajuda e documentação")
        print("8. 🚪 Sair")
        print()
    
    def get_user_choice(self, max_option: int) -> int:
        """
        Obtém a escolha do usuário a partir do menu.
        """
        while True:
            try:
                choice = input(f"Escolha uma opção (1-{max_option}): ").strip()
                choice_int = int(choice)
                if 1 <= choice_int <= max_option:
                    return choice_int
                else:
                    print(f"❌ Por favor, escolha um número entre 1 e {max_option}")
            except ValueError:
                print("❌ Por favor, digite um número válido.")
            except KeyboardInterrupt:
                print("\n\n👋 Programa interrompido pelo usuário.")
                sys.exit(0)
    
    def run(self):
        """Executa o loop principal da interface de linha de comando."""
        self.display_banner()
        
        while True:
            self.display_main_menu()
            choice = self.get_user_choice(8) # 8 opções no menu
            
            if choice == 1:
                self.generate_tests_interactive()
            elif choice == 2:
                self.process_files()
            elif choice == 3:
                self.analyze_code_only()
            elif choice == 4:
                self.run_demonstration()
            elif choice == 5:
                self.show_system_configuration()
            elif choice == 6:
                self.show_statistics()
            elif choice == 7:
                self.show_help()
            elif choice == 8:
                self._safe_exit()
                break
    
    def generate_tests_interactive(self):
        """Permite ao usuário colar código para gerar testes interativamente."""
        print("\n" + "=" * 60)
        print("📝 GERAÇÃO DE TESTES INTERATIVA")
        print("=" * 60)
        
        print("\nCole ou digite seu código Python abaixo.")
        print("Para finalizar a entrada, digite 'END' em uma linha separada:")
        print("─" * 40)
        
        code_lines = []
        while True:
            try:
                line = input()
                if line.strip().upper() == 'END':
                    break
                code_lines.append(line)
            except KeyboardInterrupt:
                print("\n❌ Entrada cancelada pelo usuário.")
                return
        
        source_code = '\n'.join(code_lines).strip()
        
        if not source_code:
            print("❌ Nenhum código fornecido.")
            return
        
        # Análise rápida para feedback
        quick_analysis = self.analyzer.analyze_code(source_code)
        if 'error' in quick_analysis:
            print(f"❌ Erro de sintaxe no código: {quick_analysis['error']}")
            return
        
        print(f"\n🔍 Código analisado: {quick_analysis['statistics']['total_functions']} funções, {quick_analysis['statistics']['total_classes']} classes.")
        
        confirm = input("Continuar com a geração de testes? (S/n): ").strip().lower()
        if confirm in ['n', 'no', 'não']:
            print("❌ Geração cancelada.")
            return
        
        print("\n🔄 Gerando testes...")
        self._process_code_generation(source_code)
    
    def process_files(self):
        """Permite processar um arquivo único ou um diretório de arquivos Python."""
        print("\n" + "=" * 60)
        print("📁 PROCESSAMENTO DE ARQUIVOS")
        print("=" * 60)
        
        print("\nOpções:")
        print("1. Processar arquivo único")
        print("2. Processar diretório")
        print("3. Voltar ao menu principal")
        
        choice = self.get_user_choice(3)
        
        if choice == 1:
            self._process_single_file()
        elif choice == 2:
            self._process_directory()
    
    def _process_single_file(self):
        """Processa um único arquivo Python."""
        file_path_str = input("\n📄 Caminho do arquivo Python (.py): ").strip()
        
        if not file_path_str:
            print("❌ Caminho não fornecido.")
            return
        
        file_path = Path(file_path_str)
        
        if not file_path.exists():
            print(f"❌ Arquivo não encontrado: {file_path_str}")
            return
        
        if not file_path.suffix == '.py':
            print("❌ Arquivo deve ter extensão .py.")
            return
        
        try:
            source_code = file_path.read_text(encoding='utf-8')
            print(f"✅ Arquivo carregado: {file_path.name}")
            
            self._process_code_generation(source_code, file_path.stem)
            
        except Exception as e:
            print(f"❌ Erro ao ler arquivo: {e}")
    
    def _process_directory(self):
        """Processa todos os arquivos Python em um diretório."""
        dir_path_str = input("\n📁 Caminho do diretório: ").strip()
        
        if not dir_path_str:
            print("❌ Caminho não fornecido.")
            return
        
        dir_path = Path(dir_path_str)
        
        if not dir_path.exists() or not dir_path.is_dir():
            print(f"❌ Diretório não encontrado: {dir_path_str}")
            return
        
        py_files = list(dir_path.glob("**/*.py"))
        
        if not py_files:
            print("❌ Nenhum arquivo Python encontrado no diretório.")
            return
        
        print(f"📄 Encontrados {len(py_files)} arquivo(s) Python:")
        for i, file in enumerate(py_files[:10], 1):
            print(f"  {i}. {file.relative_to(dir_path)}")
        
        if len(py_files) > 10:
            print(f"  ... e mais {len(py_files) - 10} arquivo(s).")
        
        confirm = input(f"\nProcessar {len(py_files)} arquivo(s)? (S/n): ").strip().lower()
        if confirm in ['n', 'no', 'não']:
            return
        
        for file_path in py_files:
            try:
                source_code = file_path.read_text(encoding='utf-8')
                print(f"\n🔄 Processando {file_path.name}...")
                self._process_code_generation(source_code, file_path.stem)
            except Exception as e:
                print(f"⚠️  Erro ao ler ou processar {file_path.name}: {e}")
    
    def _process_code_generation(self, source_code: str, filename: Optional[str] = None):
        """
        Função auxiliar para chamar o agente e exibir/salvar os resultados.
        """
        start_time = datetime.now()
        
        try:
            result = self.agent.generate_tests(source_code)
            
            execution_time = (datetime.now() - start_time).total_seconds()
            
            print(f"\n{'✅' if result['success'] else '❌'} Geração {'concluída' if result['success'] else 'falhou'}")
            print(f"⏱️  Tempo de execução: {execution_time:.2f}s")
            
            if result['success']:
                stats = result['analysis'].get('statistics', {})
                
                print(f"📊 Estatísticas do Código Analisado:")
                print(f"   Funções: {stats.get('total_functions', 0)}")
                print(f"   Classes: {stats.get('total_classes', 0)}")
                print(f"   Complexidade: {stats.get('complexity', 0)}")
                
                self._display_generated_tests(result['test_code'])
                self._offer_save_tests(result['test_code'], filename)
                
                self.statistics['successful_generations'] += 1
            else:
                print(f"💥 Erro: {result['error']}")
                self.statistics['failed_generations'] += 1
                
            self.statistics['total_generations'] += 1
            
        except Exception as e:
            logger.error(f"Erro inesperado no processamento de geração: {e}", exc_info=True)
            print(f"❌ Erro inesperado: {e}")
            self.statistics['failed_generations'] += 1
            self.statistics['total_generations'] += 1
    
    def analyze_code_only(self):
        """Permite ao usuário colar código para análise sem geração de testes."""
        print("\n" + "=" * 60)
        print("🔍 ANÁLISE DE CÓDIGO")
        print("=" * 60)
        
        print("\nCole seu código Python abaixo (digite 'END' para finalizar):")
        
        code_lines = []
        while True:
            try:
                line = input()
                if line.strip().upper() == 'END':
                    break
                code_lines.append(line)
            except KeyboardInterrupt:
                print("\n❌ Análise cancelada.")
                return
        
        source_code = '\n'.join(code_lines).strip()
        
        if not source_code:
            print("❌ Nenhum código fornecido.")
            return
        
        try:
            analysis = self.analyzer.analyze_code(source_code)
            
            if 'error' in analysis:
                print(f"❌ Erro na análise: {analysis['error']}")
                return
            
            self._display_code_analysis(analysis)
            
        except Exception as e:
            logger.error(f"Erro inesperado na análise: {e}", exc_info=True)
            print(f"❌ Erro inesperado na análise: {e}")
    
    def run_demonstration(self):
        """Executa um exemplo de demonstração com um código pré-definido."""
        print("\n" + "=" * 60)
        print("🧪 DEMONSTRAÇÃO DO SISTEMA")
        print("=" * 60)
        
        demo_code = '''def calcular_area_retangulo(largura, altura):
    """Calcula a área de um retângulo."""
    if largura <= 0 or altura <= 0:
        raise ValueError("Largura e altura devem ser positivas")
    return largura * altura

def calcular_perimetro_retangulo(largura, altura):
    """Calcula o perímetro de um retângulo."""
    if largura <= 0 or altura <= 0:
        raise ValueError("Largura e altura devem ser positivas")
    return 2 * (largura + altura)

class ContaBancaria:
    def __init__(self, saldo_inicial=0):
        if saldo_inicial < 0:
            raise ValueError("Saldo inicial não pode ser negativo")
        self._saldo = saldo_inicial
    
    def depositar(self, valor):
        if valor <= 0:
            raise ValueError("Valor deve ser positivo")
        self._saldo += valor
        return self._saldo
    
    def sacar(self, valor):
        if valor <= 0:
            raise ValueError("Valor deve ser positivo")
        if valor > self._saldo:
            raise ValueError("Saldo insuficiente")
        self._saldo -= valor
        return self._saldo
    
    @property
    def saldo(self):
        return self._saldo'''
        
        print("Código de demonstração:")
        print("─" * 30)
        print(demo_code[:300] + "..." if len(demo_code) > 300 else demo_code)
        print("─" * 30)
        
        confirm = input("\nProsseguir com a demonstração? (S/n): ").strip().lower()
        if confirm in ['n', 'no', 'não']:
            return
        
        print("\n🔄 Gerando testes de demonstração...")
        self._process_code_generation(demo_code, "demo_code")
    
    def show_system_configuration(self):
        """Mostra as configurações atuais do sistema."""
        print("\n" + "=" * 60)
        print("⚙️ CONFIGURAÇÕES DO SISTEMA")
        print("=" * 60)
        
        print(self.config) # Usa o __str__ do ConfigManager
        
        if self.config.simulate_llm:
            print("\n🔧 Para ativar Azure OpenAI, configure as variáveis de ambiente no seu arquivo .env:")
            print("  - AZURE_OPENAI_API_KEY=sua_chave_api")
            print("  - AZURE_OPENAI_ENDPOINT=https://seu-recurso.openai.azure.com/")
            print("  - AZURE_OPENAI_API_VERSION=2024-02-01 (ou a versão que você usa)")
            print("  - AZURE_OPENAI_DEPLOYMENT_NAME=nome_do_seu_deployment")
    
    def show_statistics(self):
        """Mostra estatísticas de uso da sessão atual."""
        print("\n" + "=" * 60)
        print("📊 ESTATÍSTICAS DA SESSÃO")
        print("=" * 60)
        
        runtime = datetime.now() - self.statistics['start_time']
        success_rate = 0
        if self.statistics['total_generations'] > 0:
            success_rate = (self.statistics['successful_generations'] / 
                          self.statistics['total_generations']) * 100
        
        print(f"\n📈 ESTATÍSTICAS GERAIS:")
        print(f"   Tempo total de sessão: {str(runtime).split('.')[0]}")
        print(f"   Total de gerações tentadas: {self.statistics['total_generations']}")
        print(f"   Gerações bem-sucedidas: {self.statistics['successful_generations']}")
        print(f"   Gerações falharam: {self.statistics['failed_generations']}")
        print(f"   Taxa de sucesso: {success_rate:.1f}%")
    
    def show_help(self):
        """Exibe informações de ajuda e uso do sistema."""
        print("\n" + "=" * 60)
        print("❓ AJUDA E DOCUMENTAÇÃO")
        print("=" * 60)
        
        help_text = """
COMO USAR O SISTEMA:

1. 📝 GERAR TESTES INTERATIVAMENTE:
   - Cole seu código Python diretamente no terminal.
   - Digite 'END' em uma nova linha para finalizar a entrada.
   - O sistema analisará e gerará testes automaticamente.

2. 📁 PROCESSAR ARQUIVOS:
   - Escolha entre processar um único arquivo Python ou todos os arquivos .py em um diretório.
   - Os testes gerados serão salvos automaticamente no diretório de saída configurado.

3. 🔍 ANÁLISE DE CÓDIGO:
   - Cole seu código Python para obter uma análise estática detalhada (funções, classes, complexidade) sem gerar testes.

4. 🧪 EXECUTAR EXEMPLO DE DEMONSTRAÇÃO:
   - Gera testes para um código de exemplo pré-definido.

CONFIGURAÇÃO AZURE (opcional):
- Para usar o Azure OpenAI, configure as seguintes variáveis de ambiente no seu arquivo `.env`:
  - AZURE_OPENAI_API_KEY="sua_chave_api"
  - AZURE_OPENAI_ENDPOINT="https://seu-recurso.openai.azure.com/"
  - AZURE_OPENAI_API_VERSION="2024-02-01" (ou a versão que você usa)
  - AZURE_OPENAI_DEPLOYMENT_NAME="nome_do_seu_deployment"

MODO SIMULAÇÃO:
- Se as variáveis do Azure não estiverem configuradas, o sistema operará em "Modo Simulação", gerando templates de teste básicos.

DIRETÓRIO DE SAÍDA:
- Os testes gerados são salvos na pasta 'generated_tests/' por padrão. Você pode mudar isso na variável de ambiente OUTPUT_DIRECTORY.

SUPORTE:
- Desenvolvido por Edson Gomes (Bootcamp DIO + BairesDev Machine Learning)
- Adaptado e refatorado por Gemini.
        """
        
        print(help_text)
    
    def _display_generated_tests(self, test_code: str):
        """Exibe o código dos testes gerados no console."""
        print(f"\n🧪 CÓDIGO DOS TESTES GERADOS:")
        print("─" * 60)
        
        if len(test_code) > 1500: # Limita a exibição para códigos muito longos
            print(test_code[:1500])
            print(f"\n... (código truncado - {len(test_code)} caracteres totais)")
            
            show_full = input("\nMostrar código completo? (s/N): ").strip().lower()
            if show_full in ['s', 'sim', 'y', 'yes']:
                print(test_code)
        else:
            print(test_code)
        
        print("─" * 60)
    
    def _display_code_analysis(self, analysis: Dict):
        """Exibe uma análise detalhada do código no console."""
        print(f"\n🔍 ANÁLISE DETALHADA DO CÓDIGO:")
        print("─" * 50)
        
        stats = analysis.get('statistics', {})
        print(f"📊 Estatísticas:")
        print(f"   Funções encontradas: {stats.get('total_functions', 0)}")
        print(f"   Classes encontradas: {stats.get('total_classes', 0)}")
        print(f"   Linhas de código: {stats.get('total_lines', 0)}")
        print(f"   Complexidade ciclomática: {stats.get('complexity', 0)}")
        
        functions = analysis.get('functions', [])
        if functions:
            print(f"\n📋 Funções ({len(functions)}):")
            for func in functions:
                params = ', '.join(func['parameters'])
                print(f"   • {func['name']}({params}) (linha {func['line']})")
        
        classes = analysis.get('classes', [])
        if classes:
            print(f"\n📦 Classes ({len(classes)}):")
            for cls in classes:
                print(f"   • {cls['name']} (linha {cls['line']})")
                if cls['methods']:
                    for method in cls['methods'][:3]:
                        print(f"      - {method}()")
                    if len(cls['methods']) > 3:
                        print(f"      ... e mais {len(cls['methods']) - 3} método(s)")
        
        imports = analysis.get('imports', [])
        if imports:
            print(f"\n📥 Imports ({len(imports)}):")
            for imp in imports[:5]:
                print(f"   • {imp}")
            if len(imports) > 5:
                print(f"   ... e mais {len(imports) - 5} import(s)")
    
    def _offer_save_tests(self, test_code: str, base_filename: Optional[str] = None):
        """Oferece ao usuário a opção de salvar os testes gerados em um arquivo."""
        save = input("\n💾 Deseja salvar os testes em arquivo? (S/n): ").strip().lower()
        if save not in ['n', 'no', 'não']:
            if base_filename:
                filename = f"test_{base_filename}_{datetime.now().strftime('%Y%m%d_%H%M%S')}.py"
            else:
                filename = f"test_generated_{datetime.now().strftime('%Y%m%d_%H%M%S')}.py"
            
            try:
                test_dir = Path(self.config.output_directory)
                test_dir.mkdir(parents=True, exist_ok=True) # Garante que o diretório exista
                
                file_path = test_dir / filename
                file_path.write_text(test_code, encoding='utf-8')
                print(f"✅ Testes salvos em: {file_path}")
                    
            except Exception as e:
                logger.error(f"Erro ao salvar arquivo {file_path}: {e}", exc_info=True)
                print(f"❌ Erro ao salvar arquivo: {e}")
    
    def _safe_exit(self):
        """Realiza um encerramento seguro do programa, exibindo estatísticas finais."""
        print("\n👋 Finalizando sistema...")
        
        if self.statistics['total_generations'] > 0:
            runtime = datetime.now() - self.statistics['start_time']
            success_rate = (self.statistics['successful_generations'] / 
                          self.statistics['total_generations']) * 100
            
            print(f"📊 Estatísticas da sessão:")
            print(f"   Tempo total: {str(runtime).split('.')[0]}")
            print(f"   Gerações tentadas: {self.statistics['total_generations']}")
            print(f"   Gerações bem-sucedidas: {self.statistics['successful_generations']}")
            print(f"   Gerações falharam: {self.statistics['failed_generations']}")
            print(f"   Taxa de sucesso: {success_rate:.1f}%")
        
        print("✅ Sistema finalizado com sucesso.")


def create_argument_parser():
    """Cria e configura o parser de argumentos de linha de comando."""
    parser = argparse.ArgumentParser(
        description='Sistema de Geração de Testes Unitários com LangChain e Azure ChatGPT',
        epilog='Desenvolvido por Edson Gomes - Bootcamp DIO + BairesDev (Adaptado por Gemini)'
    )
    
    parser.add_argument(
        '--file', '-f',
        type=str,
        help='Caminho para um arquivo Python (.py) para gerar testes.'
    )
    
    parser.add_argument(
        '--directory', '-d',
        type=str,
        help='Caminho para um diretório contendo arquivos Python para processar em lote.'
    )
    
    parser.add_argument(
        '--version', '-v',
        action='version',
        version='Sistema de Geração de Testes v1.0.0'
    )
    
    return parser


def process_command_line_args(args):
    """
    Processa os argumentos de linha de comando e executa a ação apropriada.
    """
    cli = TestGeneratorCLI()
    
    if args.file:
        logger.info(f"Processando arquivo via CLI: {args.file}")
        cli._process_single_file_from_cli(args.file) # Chama o método auxiliar
    
    elif args.directory:
        logger.info(f"Processando diretório via CLI: {args.directory}")
        cli._process_directory_from_cli(args.directory) # Chama o método auxiliar
    
    else:
        # Se nenhum argumento específico for fornecido, executa o modo interativo
        cli.run()
    
    return 0

# Métodos auxiliares para CLI (para serem chamados por process_command_line_args)
# Estes são wrappers para os métodos existentes na classe CLI
def _process_single_file_from_cli(self, file_path_str: str):
    file_path = Path(file_path_str)
    if file_path.exists() and file_path.suffix == '.py':
        source_code = file_path.read_text(encoding='utf-8')
        print(f"✅ Arquivo carregado: {file_path.name}")
        self._process_code_generation(source_code, file_path.stem)
    else:
        print(f"❌ Arquivo não encontrado ou inválido: {file_path_str}")

def _process_directory_from_cli(self, dir_path_str: str):
    dir_path = Path(dir_path_str)
    if dir_path.exists() and dir_path.is_dir():
        py_files = list(dir_path.glob("**/*.py"))
        if py_files:
            print(f"📄 Encontrados {len(py_files)} arquivo(s) Python:")
            for file_path in py_files:
                try:
                    source_code = file_path.read_text(encoding='utf-8')
                    print(f"\n🔄 Processando {file_path.name}...")
                    self._process_code_generation(source_code, file_path.stem)
                except Exception as e:
                    print(f"⚠️  Erro ao ler ou processar {file_path.name}: {e}")
        else:
            print(f"❌ Nenhum arquivo Python encontrado em: {dir_path_str}")
    else:
        print(f"❌ Diretório não encontrado: {dir_path_str}")


def main():
    """Função principal do programa."""
    try:
        parser = create_argument_parser()
        args = parser.parse_args()
        
        # Injeta os métodos auxiliares na instância da CLI para acesso direto
        # Isso é um pequeno hack para evitar passar a instância da CLI para as funções globais
        # ou refatorar process_command_line_args para ser um método da CLI.
        # Para um projeto maior, process_command_line_args seria um método da CLI.
        TestGeneratorCLI._process_single_file_from_cli = _process_single_file_from_cli
        TestGeneratorCLI._process_directory_from_cli = _process_directory_from_cli

        exit_code = process_command_line_args(args)
        sys.exit(exit_code)
        
    except KeyboardInterrupt:
        print("\n\n👋 Programa interrompido pelo usuário.")
        sys.exit(0)
    except Exception as e:
        print(f"\n❌ Erro fatal: {e}")
        logger.error(f"Erro fatal: {e}", exc_info=True)
        sys.exit(1)


if __name__ == "__main__":
    main()
