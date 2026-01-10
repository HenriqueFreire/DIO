# 📱 Portfolio App - Compartilhe Seus Projetos Android!

Este projeto é um aplicativo Android desenvolvido em Kotlin com Jetpack Compose, projetado para exibir e compartilhar seu portfólio de projetos de forma elegante e funcional. Ele demonstra como integrar APIs RESTful usando Retrofit para buscar dados de projetos e apresentá-los em uma interface de usuário moderna.

## ✨ Funcionalidades

*   **Exibição de Projetos:** Lista de projetos com informações essenciais.
*   **Detalhes do Projeto:** Tela dedicada para cada projeto com descrições, tecnologias e links.
*   **Integração com API:** Busca de dados de projetos de uma fonte externa (via Retrofit).
*   **Gerenciamento de Estado:** Utilização de ViewModels para um gerenciamento de estado robusto e reativo.
*   **Interface Moderna:** UI construída com Jetpack Compose, proporcionando uma experiência de usuário fluida e nativa.

## 🚀 Tecnologias Utilizadas

*   **Kotlin:** Linguagem de programação principal.
*   **Android SDK:** Ferramentas e APIs para desenvolvimento Android.
*   **Jetpack Compose:** Toolkit moderno para construção de UI nativa no Android.
*   **Android Architecture Components:**
    *   **ViewModel:** Para gerenciar e armazenar dados relacionados à UI de forma consciente ao ciclo de vida.
*   **Retrofit:** Cliente HTTP Type-safe para Android e Java, utilizado para consumir APIs REST.
    *   `retrofit-converter-gson`: Conversor para JSON usando Gson.
*   **Material Icons Extended:** Conjunto de ícones do Material Design.
*   **Gradle Kotlin DSL:** Para configuração de builds.

## 🛠️ Requisitos

*   Android Studio Arctic Fox (2020.3.1) ou superior.
*   JDK 11 ou superior.
*   Dispositivo Android (API 24+) ou emulador.

## ⚙️ Como Abrir e Executar o Projeto

1.  **Clone o repositório:**
    ```bash
    git clone https://github.com/henrique-scc/Criando-um-App-Android-para-Compartilhar-seu-Portfolio-de-Projetos.git
    ```
2.  **Abra no Android Studio:**
    *   Abra o Android Studio.
    *   Selecione "Open an existing Android Studio project".
    *   Navegue até o diretório onde você clonou o projeto (`Criando-um-App-Android-para-Compartilhar-seu-Portfolio-de-Projetos`) e selecione-o.
    *   Aguarde o Gradle sincronizar o projeto.

3.  **Configuração da API (se aplicável):**
    *   Se o aplicativo depender de uma API externa, certifique-se de configurar o endpoint da API ou chaves de acesso conforme necessário (verifique o código-fonte para detalhes).

4.  **Execute o Aplicativo:**
    *   Conecte um dispositivo Android ao seu computador ou inicie um emulador.
    *   No Android Studio, clique no botão "Run" (ícone de triângulo verde ▶️) na barra de ferramentas.
    *   Selecione seu dispositivo conectado ou emulador e o aplicativo será instalado e iniciado.

## 🤝 Contribuição

Sinta-se à vontade para contribuir com melhorias, novas funcionalidades ou correções de bugs.

## 📄 Licença

Este projeto está licenciado sob a licença MIT. Veja o arquivo `LICENSE` para mais detalhes.
