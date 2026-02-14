import os
from azure.core.credentials import AzureKeyCredential
from azure.ai.formrecognizer import DocumentAnalysisClient
from dotenv import load_dotenv

load_dotenv()

class DocumentAnalyzer:
    def __init__(self):
        endpoint = os.getenv("AZURE_DOCUMENT_INTELLIGENCE_ENDPOINT")
        key = os.getenv("AZURE_DOCUMENT_INTELLIGENCE_KEY")
        
        if not endpoint or not key:
            raise ValueError("Endpoint and Key must be set in environment variables.")
            
        self.client = DocumentAnalysisClient(
            endpoint=endpoint, 
            credential=AzureKeyCredential(key)
        )

    def analyze_document(self, document_path_or_stream):
        poller = self.client.begin_analyze_document(
            "prebuilt-idDocument", document=document_path_or_stream
        )
        result = poller.result()
        return result

    def validate_anti_fraud(self, analysis_result):
        """
        Simple anti-fraud rules.
        """
        issues = []
        
        # Rule 1: Check for expiry date
        for document in analysis_result.documents:
            expiry_date = document.fields.get("ExpirationDate")
            if expiry_date:
                # Basic check: if expiry date is missing or very old?
                # For now, just log what we found
                pass
            else:
                issues.append("Expiration Date not detected. High risk of fraudulent or incomplete document.")

        return issues
