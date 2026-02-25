# Plano de Ação - LingoLocal Chat Mobile

## Visão Geral do Projeto
Desenvolvimento de uma aplicação de chat mobile (React Native) para prática de inglês, com um backend Python que integra IA local para processamento de áudio/texto, narração e correção de erros. A aplicação é para uso pessoal, **não terá funcionalidades de login ou registro de usuários**, mas manterá o histórico de conversas para um único usuário implícito. A IA irá corrigir erros na fala ou escrita **em português**. A infraestrutura será gerenciada com Nix e Docker, e o desenvolvimento seguirá uma metodologia de Sprints com TDD e Checkpoints.

## Metodologia
*   **Sprints:** Desenvolvimento iterativo, com foco em entrega de funcionalidades incrementais.
*   **TDD (Test-Driven Development):** Escrita de testes antes da implementação do código para garantir a qualidade e corretude das funcionalidades desde o início.
*   **Checkpoints:** Pontos de verificação ao final de cada sprint para avaliar o progresso e garantir que os objetivos foram atingidos.
*   **Ferramentas:** Python (Backend, IA), React Native (Frontend), Docker (Conteinerização), Nix (Gerenciamento de pacotes e ambiente).

## Sprints Detalhadas

---

### Sprint 1: Configuração do Backend e API de Chat Básica (Python, Docker, Nix)

**Objetivo:** Estabelecer um backend Python funcional com endpoints de chat básicos e integração com banco de dados, focado em um único usuário implícito. Dockerizar o backend e configurar o ambiente Nix.

**Checkpoints:**
*   Projeto Python inicializado (FastAPI).
*   Configuração inicial do banco de dados (Ex: SQLAlchemy com SQLite para desenvolvimento).
*   Modelo de mensagens (`Message`) adaptado para um único usuário implícito, armazenando o tipo de remetente (usuário ou IA) e os conteúdos relevantes (original, narrado, corrigido). **O modelo `User` existente e funcionalidades de autenticação serão removidos/ignorados.**
*   Endpoints API básicos para enviar e receber mensagens para o usuário implícito.
*   Dockerfile para o backend.
*   Nix flake/shell para gerenciamento de dependências Python.
*   **TDD:**
    *   Testes unitários para o modelo de mensagens, focando na criação, leitura e atualização de conversas.
    *   Testes de integração para os endpoints da API de chat (envio e recebimento de mensagens), verificando respostas esperadas e tratamento de erros no contexto de um único usuário.

---

### Sprint 2: Integração de IA - Processamento e Correção de Texto (Python)

**Objetivo:** Integrar um modelo de IA local para narração de texto e correção gramatical/ortográfica no backend.

**Checkpoints:**
*   Seleção e integração de uma biblioteca Python para Text-to-Speech (narração local).
*   Seleção e integração de uma biblioteca Python para correção gramatical/ortográfica, **garantindo que as correções sejam fornecidas em português.**
*   Endpoint API para narração de texto (`/ai/narrate`).
*   Endpoint API para correção de texto (`/ai/correct_text`).
*   Atualização do endpoint de chat para utilizar a IA para narração e correção automática de mensagens enviadas, armazenando o texto original, a narração e a correção (se houver) no modelo de `Message`.
*   **TDD:**
    *   Testes unitários para as interfaces dos modelos de IA (entrada/saída).
    *   Testes de integração para os endpoints de narração e correção, cobrindo cenários com texto correto, texto com erros e diferentes opções de narração, **com foco na correção em português.**

---

### Sprint 3: Integração de IA - Processamento de Áudio e Correção (Python)

**Objetivo:** Habilitar o backend para receber áudio, transcrevê-lo para texto e aplicar correção de IA.

**Checkpoints:**
*   Integração de uma biblioteca Python para Speech-to-Text (transcrição de áudio para texto).
*   Endpoint API para receber áudio, transcrever e aplicar correção, **com feedback em português.**
*   Atualização do endpoint de chat para processar mensagens de áudio, incluindo transcrição, narração e correção, armazenando todos os componentes da interação.
*   **TDD:**
    *   Testes unitários para os componentes de processamento de áudio (ex: manipulação de formatos de áudio, segmentação).
    *   Testes de integração para o endpoint de processamento de áudio com diferentes entradas de áudio e verificação da transcrição e correção **em português.**

---

### Sprint 4: Configuração do Frontend Mobile e UI Básica de Chat (React Native, Nix, Docker)

**Objetivo:** Configurar o ambiente de desenvolvimento React Native e implementar a interface de usuário básica do chat para um único usuário.

**Checkpoints:**
*   Projeto React Native inicializado.
*   Configuração de navegação básica (diretamente para a tela de Chat, sem telas de login).
*   Componente para exibição de mensagens no chat, mostrando o texto original, narração e correções.
*   Componente de entrada de texto para envio de mensagens.
*   Configuração do Docker para ambiente de desenvolvimento React Native (opcional, para consistência).
*   Nix flake/shell para gerenciamento de dependências React Native (Node.js, npm/yarn).
*   **TDD:**
    *   Testes unitários para componentes UI (ex: `MessageBubble`, `TextInput`).
    *   Testes de integração para fluxos básicos do usuário (ex: digitar e enviar uma mensagem de texto).

---

### Sprint 5: Frontend - Gravação e Reprodução de Áudio (React Native)

**Objetivo:** Implementar funcionalidades de gravação e reprodução de áudio na aplicação mobile.

**Checkpoints:**
*   Permissões de acesso ao microfone tratadas no React Native.
*   Funcionalidade de gravação de áudio.
*   Funcionalidade de reprodução de áudio para mensagens narradas e correções.
*   Interface do usuário para iniciar/parar gravação e enviar mensagens de áudio.
*   **TDD:**
    *   Testes unitários para a lógica de gravação/reprodução de áudio.
    *   Testes de integração para o fluxo de gravação e envio de uma mensagem de áudio.

---

### Sprint 6: Integração Frontend-Backend e Chat em Tempo Real (React Native, Python)

**Objetivo:** Conectar a aplicação React Native ao backend Python e implementar comunicação em tempo real para um único usuário implícito.

**Checkpoints:**
*   Cliente API para comunicação com o backend (sem necessidade de tratamento de autenticação).
*   Envio de mensagens de texto para o backend.
*   Envio de mensagens de áudio para o backend.
*   Exibição de respostas narradas e correções de IA no chat.
*   Implementação de atualizações em tempo real para novas mensagens (ex: WebSockets ou polling).
*   **TDD:**
    *   Testes de integração para o cliente API.
    *   Testes end-to-end para envio/recebimento de mensagens (texto e áudio) e verificação das respostas da IA, incluindo narração e correções.

---

### Sprint 7: Tratamento de Erros, Refinamentos UI/UX e Preparação para Implantação

**Objetivo:** Melhorar o tratamento de erros, refinar a interface/experiência do usuário e preparar a aplicação para implantação.

**Checkpoints:**
*   Tratamento de erros robusto e exibição de mensagens de feedback claras para o usuário.
*   Indicadores de carregamento para processamento de IA.
*   Aprimoramento geral da UI/UX com base em feedback e testes.
*   Documentação e scripts para implantação (Docker e Nix).
*   **TDD:**
    *   Testes unitários para a lógica de tratamento de erros.
    *   Revisão e melhoria dos testes existentes para cobrir casos de borda e cenários de falha.
