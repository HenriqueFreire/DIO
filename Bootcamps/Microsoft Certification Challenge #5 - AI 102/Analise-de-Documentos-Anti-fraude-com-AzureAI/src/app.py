import streamlit as st
from analyzer import DocumentAnalyzer
import os

st.set_page_config(page_title="Anti-fraud Document Analyzer", layout="wide")

st.title("🛡️ Anti-fraud Document Analyzer")
st.markdown("Analise seus documentos em busca de fraudes e extraia informações automaticamente.")

# Initialize analyzer
try:
    analyzer = DocumentAnalyzer()
except Exception as e:
    st.error(f"Erro ao inicializar o analisador: {e}")
    st.info("Certifique-se de que o arquivo .env está configurado corretamente com o Endpoint e a Key do Azure.")
    st.stop()

uploaded_file = st.file_uploader("Escolha um documento (PDF, PNG, JPG)...", type=["pdf", "png", "jpg", "jpeg"])

if uploaded_file is not None:
    st.subheader("Visualização do Documento")
    if uploaded_file.type == "application/pdf":
        st.write("PDF carregado.")
    else:
        st.image(uploaded_file, width=400)

    if st.button("Analisar Documento"):
        with st.spinner("Analisando..."):
            try:
                result = analyzer.analyze_document(uploaded_file)
                st.success("Análise concluída!")
                
                # Display results
                col1, col2 = st.columns(2)
                
                with col1:
                    st.subheader("Dados Extraídos")
                    for document in result.documents:
                        for name, field in document.fields.items():
                            st.write(f"**{name}:** {field.value if field.value else field.content}")

                with col2:
                    st.subheader("Validação Anti-fraude")
                    issues = analyzer.validate_anti_fraud(result)
                    if issues:
                        for issue in issues:
                            st.warning(issue)
                    else:
                        st.balloons()
                        st.success("Nenhuma irregularidade óbvia detectada.")

            except Exception as e:
                st.error(f"Erro durante a análise: {e}")

st.sidebar.markdown("---")
st.sidebar.info("Este projeto faz parte do Bootcamp Microsoft Certification Challenge #5 na DIO.")
