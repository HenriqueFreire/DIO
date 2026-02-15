# Azure Machine Learning Automation - Previsão de Preço do Milho

Este projeto automatiza a configuração e o treinamento de um modelo de Machine Learning no Azure AI (DP-100) usando **Terraform**, **Nix** e **Docker**.

## Estrutura do Projeto

- `/terraform`: Configuração de infraestrutura (Workspace, Compute, Storage).
- `/src`: Scripts Python (`train.py`) e submissão (`submit_job.py`).
- `/data`: Pasta com o dataset `milho_brasil.csv`.
- `docker.nix`: Expressão Nix para criar imagem Docker minimalista.
- `shell.nix`: Ambiente local de desenvolvimento.

## Requisitos Próximos Passos (Assim que tiver a conta)

1. **Ativar o Ambiente Nix**:
   ```bash
   nix-shell
   ```

2. **Gerar a Imagem Docker Minimalista**:
   ```bash
   nix-build docker.nix
   # Isso gera um link 'result' que é a imagem tarada.
   docker load < result
   ```

3. **Login no Azure**:
   ```bash
   az login
   ```

4. **Deploy da Infraestrutura**:
   ```bash
   cd terraform
   terraform init
   terraform apply -var="tenant_id=<SEU_TENANT_ID>"
   ```

5. **Treinar o Modelo no Azure**:
   ```bash
   cd ../src
   python submit_job.py
   ```

## Notas
- O script `train.py` está configurado para gerar dados fictícios caso nenhum dataset seja fornecido, para que você possa testar a automação imediatamente.
- O cluster de computação (`cpu-cluster`) está configurado como **LowPriority** para economizar créditos da sua conta.
