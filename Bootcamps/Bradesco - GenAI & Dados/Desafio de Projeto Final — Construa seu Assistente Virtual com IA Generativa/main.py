import os
import requests
import google.generativeai as genai
from dotenv import load_dotenv

# Carrega as variáveis de ambiente do arquivo .env
load_dotenv()

# Configura as chaves de API
GEMINI_API_KEY = os.getenv("GEMINI_API_KEY")
BRAPI_API_KEY = os.getenv("BRAPI_API_KEY")
DADOSDEMERCADO_API_KEY = os.getenv("DADOSDEMERCADO_API_KEY")

# Configura a API Gemini
genai.configure(api_key=GEMINI_API_KEY)
model = genai.GenerativeModel('gemini-pro')

# URLs das APIs
BRAPI_BASE_URL = "https://brapi.dev/api"
DADOSDEMERCADO_BASE_URL = "https://api.dadosdemercado.com.br/v1"

def get_stock_quote(ticker):
    """
    Busca a cotação de uma ação usando a API brapi.
    """
    url = f"{BRAPI_BASE_URL}/quote/{ticker}?token={BRAPI_API_KEY}"
    try:
        response = requests.get(url)
        response.raise_for_status()  # Levanta um erro para códigos de status HTTP ruins (4xx ou 5xx)
        data = response.json()
        if data and 'results' in data and len(data['results']) > 0:
            return data['results'][0]
        return None
    except requests.exceptions.RequestException as e:
        print(f"Erro ao buscar cotação de {ticker}: {e}")
        return None

def get_financial_news(query=None):
    """
    Busca notícias financeiras usando a API Dados de Mercado.
    """
    # A API Dados de Mercado exige um token no header ou como param. Ajuste conforme a documentação.
    headers = {"Authorization": f"Bearer {DADOSDEMERCADO_API_KEY}"}
    url = f"{DADOSDEMERCADO_BASE_URL}/news"
    params = {}
    if query:
        params['q'] = query # Exemplo: se a API suportar query param para busca
    try:
        response = requests.get(url, headers=headers, params=params)
        response.raise_for_status()
        return response.json()
    except requests.exceptions.RequestException as e:
        print(f"Erro ao buscar notícias: {e}")
        return None

def get_company_financial_statements(ticker):
    """
    Busca balanços financeiros de uma empresa usando a API brapi.
    A brapi oferece dados fundamentais. A URL específica pode variar.
    """
    url = f"{BRAPI_BASE_URL}/quote/{ticker}/fundamentals?token={BRAPI_API_KEY}"
    try:
        response = requests.get(url)
        response.raise_for_status()
        return response.json()
    except requests.exceptions.RequestException as e:
        print(f"Erro ao buscar balanços de {ticker}: {e}")
        return None

def analyze_text_with_gemini(text, prompt_instruction):
    """
    Analisa um texto usando a API Gemini e retorna uma resposta gerada.
    """
    try:
        response = model.generate_content(f"{prompt_instruction}\n\n{text}")
        return response.text
    except Exception as e:
        print(f"Erro ao analisar com Gemini: {e}")
        return "Não foi possível gerar uma análise no momento."

def main():
    print("Bem-vindo ao Agente Virtual Financeiro!")
    while True:
        command = input("\nComando (cotação <ticker>, notícias [query], balanço <ticker>, sair): ").lower().strip()

        if command.startswith("cotação"):
            parts = command.split()
            if len(parts) == 2:
                ticker = parts[1].upper()
                quote_data = get_stock_quote(ticker)
                if quote_data:
                    prompt = (f"Explique a cotação da ação {ticker} de forma simples para uma pessoa comum. "
                              f"Inclua o preço atual, variação diária e volume se disponível. "
                              f"Dados: {quote_data}")
                    analysis = analyze_text_with_gemini(str(quote_data), prompt)
                    print(f"\nAnálise da Cotação de {ticker}:\n{analysis}")
                else:
                    print(f"Não foi possível obter a cotação para {ticker}.")
            else:
                print("Uso: cotação <ticker>")
        
        elif command.startswith("notícias"):
            parts = command.split(" ", 1)
            query = parts[1] if len(parts) > 1 else None
            news_data = get_financial_news(query)
            if news_data and 'news' in news_data and len(news_data['news']) > 0:
                # Pegar as 3 primeiras notícias para sumarizar, para não exceder o limite de tokens
                top_news = news_data['news'][:3]
                news_text = "\n".join([f"Título: {n['title']}\nFonte: {n['source']}\nURL: {n['url']}" for n in top_news])
                
                prompt = (f"Resuma as seguintes notícias financeiras para uma pessoa comum, destacando os pontos mais importantes. "
                          f"Dados das notícias:\n{news_text}")
                analysis = analyze_text_with_gemini(news_text, prompt)
                print(f"\nResumo das Notícias:\n{analysis}")
            else:
                print("Não foi possível obter notícias financeiras.")

        elif command.startswith("balanço"):
            parts = command.split()
            if len(parts) == 2:
                ticker = parts[1].upper()
                financial_statements_data = get_company_financial_statements(ticker)
                if financial_statements_data:
                    prompt = (f"Explique os principais pontos do balanço financeiro da empresa {ticker} de forma simples para uma pessoa comum. "
                              f"Destaque indicadores importantes como receita, lucro e endividamento, se disponíveis nos dados. "
                              f"Dados do balanço: {financial_statements_data}")
                    analysis = analyze_text_with_gemini(str(financial_statements_data), prompt)
                    print(f"\nAnálise do Balanço Financeiro de {ticker}:\n{analysis}")
                else:
                    print(f"Não foi possível obter o balanço financeiro para {ticker}.")
            else:
                print("Uso: balanço <ticker>")

        elif command == "sair":
            print("Saindo do Agente Virtual Financeiro. Até mais!")
            break
        else:
            print("Comando inválido. Use 'cotação <ticker>', 'notícias [query]', 'balanço <ticker>' ou 'sair'.")

if __name__ == "__main__":
    main()
