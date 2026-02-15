import os
from dotenv import load_dotenv
from azure.identity import DefaultAzureCredential
from azure.search.documents import SearchClient
from azure.search.documents.indexes import SearchIndexClient
from azure.search.documents.indexes.models import (
    SearchIndex,
    SimpleField,
    SearchFieldDataType,
    SearchableField,
    SearchField,
    VectorSearch,
    HnswAlgorithmConfiguration,
    VectorSearchProfile,
    AzureOpenAIVectorizer,
    AzureOpenAIVectorizerParameters,
    SearchIndexCustomVectorizer,
)
from pypdf import PdfReader

load_dotenv()

def get_pdf_text(path):
    reader = PdfReader(path)
    text = ""
    for page in reader.pages:
        text += page.extract_text()
    return text

def create_index(index_name):
    # Lógica simplificada para criar o índice no Azure AI Search
    # Aqui configuraríamos os campos e a busca vetorial (HNSW)
    pass

def ingest_document(file_path):
    print(f"Lendo {file_path}...")
    content = get_pdf_text(file_path)
    # Lógica para chunking e envio para o Azure
    print("Injetando no Azure AI Search...")
    # client.upload_documents(documents=[...])

if __name__ == "__main__":
    # Garantir que a pasta data existe
    if not os.path.exists("data"):
        os.makedirs("data")
        print("Adicione seus PDFs na pasta 'data/'")
    
    # Exemplo de uso
    # ingest_document("data/documento.pdf")
