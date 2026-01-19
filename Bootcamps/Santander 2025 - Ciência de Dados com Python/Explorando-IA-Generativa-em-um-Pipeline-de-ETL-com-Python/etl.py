
import pandas as pd
import openai
import os

def get_openai_api_key():
    """Obtém a chave da API OpenAI a partir das variáveis de ambiente."""
    api_key = os.getenv("OPENAI_API_KEY")
    if not api_key:
        raise ValueError("A variável de ambiente OPENAI_API_KEY não foi configurada. Por favor, defina-a.")
    return api_key

def extract_users(file_path):
    """Lê os dados dos usuários de um arquivo CSV."""
    print("1. Iniciando a extração de dados...")
    try:
        df = pd.read_csv(file_path)
        print(f"   - {len(df)} usuários encontrados em '{file_path}'.")
        return df
    except FileNotFoundError:
        print(f"   - ERRO: O arquivo '{file_path}' não foi encontrado.")
        exit()

def generate_marketing_message(user_name, openai_client):
    """Gera uma mensagem de marketing personalizada usando a API da OpenAI."""
    try:
        completion = openai_client.chat.completions.create(
            model="gpt-3.5-turbo",
            messages=[
                {
                    "role": "system",
                    "content": "Você é um especialista em marketing bancário."
                },
                {
                    "role": "user",
                    "content": f"Crie uma mensagem de marketing para {user_name} oferecendo nossos novos planos de investimento (máximo de 100 caracteres)."
                }
            ]
        )
        return completion.choices[0].message.content.strip()
    except Exception as e:
        print(f"   - ERRO ao gerar mensagem para {user_name}: {e}")
        return "Falha na comunicação com a IA."

def transform_data(df, openai_client):
    """Aplica a transformação nos dados, gerando mensagens de marketing."""
    print("\n2. Iniciando a transformação de dados...")
    df['MarketingMessage'] = df['Name'].apply(lambda name: generate_marketing_message(name, openai_client))
    print("   - Mensagens de marketing geradas.")
    return df

def load_data(df, output_path):
    """Salva os dados transformados em um novo arquivo CSV."""
    print(f"\n3. Iniciando o carregamento dos dados...")
    try:
        df.to_csv(output_path, index=False)
        print(f"   - Pipeline ETL concluído. Resultado salvo em '{output_path}'.")
    except Exception as e:
        print(f"   - ERRO ao salvar o arquivo: {e}")

def main():
    """Função principal para orquestrar o pipeline ETL."""
    try:
        api_key = get_openai_api_key()
        openai_client = openai.OpenAI(api_key=api_key)
    except ValueError as e:
        print(f"ERRO DE CONFIGURAÇÃO: {e}")
        return

    input_file = 'users.csv'
    output_file = 'users_with_messages.csv'

    # Orquestração do Pipeline
    user_data = extract_users(input_file)
    if user_data is not None:
        transformed_data = transform_data(user_data, openai_client)
        load_data(transformed_data, output_file)

        print("\n--- Amostra do Resultado ---")
        print(transformed_data.head())

if __name__ == "__main__":
    main()
