import os
from dotenv import load_dotenv
from openai import AzureOpenAI
from azure.identity import DefaultAzureCredential, get_bearer_token_provider
from azure.search.documents import SearchClient

load_dotenv()

def get_context(query, index_name):
    # Lógica para buscar os trechos mais relevantes no Azure AI Search (Hybrid Search)
    return "Contexto recuperado do PDF..."

def chat_loop():
    client = AzureOpenAI(
        azure_endpoint=os.getenv("AZURE_OPENAI_ENDPOINT"),
        api_key=os.getenv("AZURE_OPENAI_API_KEY"),
        api_version="2024-02-15-preview"
    )

    print("Chatbot Pronto! (Digite 'sair' para encerrar)")
    while True:
        user_input = input("Você: ")
        if user_input.lower() == 'sair':
            break
        
        context = get_context(user_input, "pdf-index")
        
        response = client.chat.completions.create(
            model=os.getenv("AZURE_DEPLOYMENT_ID", "chat-model"),
            messages=[
                {"role": "system", "content": f"Você é um assistente útil. Use o seguinte contexto para responder: {context}"},
                {"role": "user", "content": user_input}
            ]
        )
        
        print(f"Bot: {response.choices[0].message.content}")

if __name__ == "__main__":
    # chat_loop()
    print("Script de chat carregado. Configure as variáveis no .env para testar.")
