# RELATÓRIO DE IMPLEMENTAÇÃO DE SERVIÇOS AWS
**Data:** 19 de janeiro de 2026
**Empresa:** Abstergo Industries
**Responsável:** Henrique Gabriel

# Relatório: Soluções de Segurança AWS

Este relatório apresenta três soluções de segurança robustas utilizando produtos da Amazon Web Services (AWS) para proteger ambientes e aplicações na nuvem.

---

## 1. AWS Identity and Access Management (IAM)

### Descrição
AWS IAM permite que você gerencie com segurança o acesso a serviços e recursos da AWS. Com o IAM, você pode criar e gerenciar usuários e grupos da AWS e usar permissões para permitir e negar seu acesso a recursos da AWS.

### Solução de Segurança
IAM é fundamental para implementar o princípio do **privilégio mínimo**, garantindo que usuários e serviços tenham apenas as permissões necessárias para realizar suas tarefas.

*   **Controle de Acesso Granular:** Defina políticas de acesso detalhadas para usuários, grupos e perfis (roles), limitando quem pode fazer o quê e em quais recursos.
*   **Autenticação Forte:** Enforce Multi-Factor Authentication (MFA) para todas as contas privilegiadas, adicionando uma camada extra de segurança ao processo de login.
*   **Rotação de Credenciais:** Facilita a rotação regular de chaves de acesso, minimizando o risco de comprometimento de credenciais de longa duração.
*   **Auditoria de Acesso:** Integração com AWS CloudTrail para registrar todas as chamadas de API do IAM, fornecendo um rastro de auditoria completo para conformidade e análise de segurança.

---

## 2. AWS Web Application Firewall (WAF)

### Descrição
AWS WAF é um firewall de aplicativo web que ajuda a proteger seus aplicativos web ou APIs contra exploits web comuns que podem afetar a disponibilidade do aplicativo, comprometer a segurança ou consumir recursos excessivos.

### Solução de Segurança
WAF atua na camada de aplicação (Camada 7 do modelo OSI), protegendo contra ataques que firewalls de rede tradicionais não conseguiriam detectar.

*   **Proteção contra OWASP Top 10:** Ajuda a proteger contra vulnerabilidades comuns como injeção de SQL, Cross-Site Scripting (XSS) e falsificação de solicitação entre sites (CSRF).
*   **Controle de Acesso Baseado em Conteúdo:** Permite a criação de regras personalizadas para bloquear ou permitir tráfego com base em padrões específicos (IPs de origem, cabeçalhos HTTP, strings de consulta, etc.).
*   **Prevenção de DDoS em Aplicação:** Complementa outras proteções DDoS da AWS, filtrando tráfego malicioso antes que ele atinja suas aplicações.
*   **Integração com Serviços AWS:** Integra-se facilmente com Amazon CloudFront, Application Load Balancer (ALB), Amazon API Gateway e AWS AppSync para proteção em diferentes pontos de entrada.

---

## 3. AWS Security Hub

### Descrição
AWS Security Hub fornece uma visão abrangente de alto nível do seu estado de segurança na AWS e ajuda a verificar seu ambiente em relação aos padrões do setor e às práticas recomendadas de segurança.

### Solução de Segurança
Security Hub agrega, organiza e prioriza seus alertas de segurança (ou descobertas) de vários serviços AWS (como GuardDuty, Inspector, Macie, IAM Access Analyzer) e soluções de parceiros.

*   **Visibilidade Centralizada:** Consolida descobertas de segurança de diversas fontes em um único painel, simplificando o monitoramento e a resposta a incidentes.
*   **Avaliação Contínua de Conformidade:** Avalia automaticamente o status de conformidade do seu ambiente AWS em relação a padrões de segurança como CIS AWS Foundations Benchmark, PCI DSS e AWS Foundational Security Best Practices.
*   **Automação da Resposta a Incidentes:** Possibilita a automação de ações de resposta a descobertas de segurança por meio de integração com AWS Lambda e Amazon EventBridge.
*   **Priorização Inteligente:** Ajuda a priorizar as descobertas de segurança mais importantes, usando pontuações de gravidade e contexto de recursos, para que você possa focar nos riscos mais críticos.
**Assinatura do Responsável pelo Projeto:**

Henrique Gabriel
