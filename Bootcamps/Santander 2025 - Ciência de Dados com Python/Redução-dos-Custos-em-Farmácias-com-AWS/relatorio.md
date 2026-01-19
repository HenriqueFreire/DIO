# RELATÓRIO DE IMPLEMENTAÇÃO DE SERVIÇOS AWS

**Data:** 19 de janeiro de 2026
**Empresa:** Abstergo Industries
**Responsável:** Henrique Gabriel

## Introdução
Este relatório apresenta o processo de implementação de ferramentas na empresa Abstergo Industries, realizado por Henrique Gabriel. O objetivo do projeto foi elencar 3 serviços AWS, com a finalidade de realizar diminuição de custos imediatos no hub de distribuição farmacêutico.

## Descrição do Projeto
O projeto de implementação de ferramentas foi dividido em 3 etapas, cada uma com seus objetivos específicos. A seguir, serão descritas as etapas do projeto:

**Etapa 1:**
- **Nome da ferramenta:** Amazon S3 (Simple Storage Service)
- **Foco da ferramenta:** Armazenamento de dados escalável e de baixo custo.
- **Descrição de caso de uso:** O hub de distribuição gera um volume massivo de dados diariamente (notas fiscais, registros de inventário, logs de temperatura da cadeia de frio, dados de transporte). Atualmente, esses dados são mantidos em servidores locais caros e de capacidade limitada. A migração para o Amazon S3 criará um "Data Lake" centralizado, reduzindo drasticamente os custos com hardware, manutenção e energia. Além disso, servirá como uma fonte de dados única e confiável para as próximas etapas.

**Etapa 2:**
- **Nome da ferramenta:** AWS IoT Core
- **Foco da ferramenta:** Monitoramento em tempo real da cadeia de frio.
- **Descrição de caso de uso:** Muitos produtos farmacêuticos exigem controle de temperatura rigoroso. Serão instalados sensores de temperatura e umidade nos armazéns e na frota de veículos de entrega. Esses sensores enviarão dados em tempo real para o AWS IoT Core. Caso a temperatura de um lote de medicamentos saia da faixa segura, um alerta automático será enviado para a equipe de logística, permitindo uma ação corretiva imediata. Isso previne a perda de lotes inteiros de produtos, evitando prejuízos financeiros significativos e garantindo a conformidade com as normas sanitárias.

**Etapa 3:**
- **Nome da ferramenta:** Amazon SageMaker
- **Foco da ferramenta:** Previsão de demanda com Machine Learning.
- **Descrição de caso de uso:** A compra excessiva ou insuficiente de medicamentos gera custos, seja pelo armazenamento e risco de vencimento, seja pela perda de vendas. Utilizando o histórico de vendas e dados sazonais (armazenados no S3), um modelo no SageMaker pode prever a demanda futura de produtos por região. Isso permite otimizar os níveis de estoque, reduzindo o capital parado em produtos desnecessários e minimizando as perdas por vencimento, o que gera uma economia substancial.

## Conclusão
A implementação de ferramentas na empresa Abstergo Industries tem como esperado **uma significativa redução de custos operacionais através da otimização de inventário, prevenção de perdas de produtos sensíveis à temperatura e modernização da infraestrutura de dados**, o que aumentará a eficiência e a produtividade da empresa. Recomenda-se a continuidade da utilização das ferramentas implementadas e a busca por novas tecnologias que possam melhorar ainda mais os processos da empresa.

## Anexos

- Planilha de Custos: On-Premise vs. AWS
- Desenho da Arquitetura de Referência da Solução
- Cronograma de Implementação do Projeto

Assinatura do Responsável pelo Projeto:

Henrique Gabriel
