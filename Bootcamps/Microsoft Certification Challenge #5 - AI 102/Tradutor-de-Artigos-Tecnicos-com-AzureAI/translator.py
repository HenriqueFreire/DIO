import os
import sys
import requests
from bs4 import BeautifulSoup
from dotenv import load_dotenv
from azure.ai.translation.text import TextTranslationClient
from azure.core.credentials import AzureKeyCredential
from azure.core.exceptions import HttpResponseError

# Carregar variáveis de ambiente
load_dotenv()

def get_config():
    key = os.getenv("AZURE_RESOURCE_KEY")
    region = os.getenv("AZURE_RESOURCE_REGION")
    endpoint = os.getenv("AZURE_RESOURCE_ENDPOINT", "https://api.cognitive.microsofttranslator.com/")
    
    if not key or not region:
        print("Erro: AZURE_RESOURCE_KEY e AZURE_RESOURCE_REGION devem estar configuradas no arquivo .env")
        sys.exit(1)
        
    return key, region, endpoint

def translate_text(text, target_language='pt-br'):
    key, region, endpoint = get_config()
    
    # Inicializar o cliente do SDK
    credential = AzureKeyCredential(key)
    client = TextTranslationClient(credential=credential, endpoint=endpoint, region=region)

    try:
        # O SDK espera 'body' (lista de objetos InputTextItem ou dicionários)
        body = [{"text": text}]
        response = client.translate(body=body, to_language=[target_language], text_type='html')
        translation = response[0] if response else None
        
        if translation:
            return translation.translations[0].text
        return None

    except HttpResponseError as e:
        print(f"Erro na tradução (SDK): {e.status_code} - {e.message}")
        return None
    except Exception as e:
        print(f"Erro inesperado: {e}")
        return None

def extract_article_html(url):
    print(f"Extraindo HTML de: {url}")
    try:
        headers = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'
        }
        response = requests.get(url, headers=headers)
        response.raise_for_status()
        soup = BeautifulSoup(response.text, 'html.parser')
        
        # Seletores específicos do dev.to
        content_container = soup.find('div', id='article-body') or \
                            soup.find('div', class_='crayons-article__main') or \
                            soup.find('article')
        
        if content_container:
            # Retornar o HTML bruto do container para preservar tags de mídia
            return str(content_container)
        
        return str(soup.body) if soup.body else response.text
    except Exception as e:
        print(f"Erro ao extrair artigo: {e}")
        return None

def main():
    if len(sys.argv) < 2:
        print("Uso: python translator.py <URL_DO_ARTIGO> [IDIOMA_DESTINO]")
        sys.exit(1)
        
    url = sys.argv[1]
    target_lang = sys.argv[2] if len(sys.argv) > 2 else 'pt-br'
    
    article_html = extract_article_html(url)
    
    if not article_html:
        print("Não foi possível obter o conteúdo do artigo.")
        return

    print("Traduzindo e preservando layout... (isso pode levar alguns segundos)")
    
    translated_html = translate_text(article_html, target_lang)
    
    if translated_html:
        output_file = "artigo_traduzido.html"
        # Envolver em uma estrutura HTML básica para visualização correta
        full_html = f"""
        <!DOCTYPE html>
        <html lang="{target_lang}">
        <head>
            <meta charset="UTF-8">
            <title>Artigo Traduzido</title>
            <style>
                body {{ font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif; line-height: 1.6; max-width: 800px; margin: 40px auto; padding: 20px; }}
                img {{ max-width: 100%; height: auto; }}
                iframe {{ width: 100%; height: 450px; border: none; }}
                pre {{ background: #f4f4f4; padding: 15px; overflow-x: auto; }}
            </style>
        </head>
        <body>
            {translated_html}
        </body>
        </html>
        """
        with open(output_file, "w", encoding="utf-8") as f:
            f.write(full_html)
        print(f"Tradução concluída! Abra '{output_file}' no seu navegador.")
    else:
        print("Falha na tradução.")

if __name__ == "__main__":
    main()
