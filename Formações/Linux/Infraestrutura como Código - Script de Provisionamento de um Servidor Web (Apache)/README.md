# Projeto 2: Script de Provisionamento de Servidor Web (Apache)

## Descrição

Este projeto utiliza um script de shell (`iac_apache_provision.sh`) para automatizar completamente o processo de provisionamento de um servidor web Apache em um sistema Linux. Além de instalar o servidor, o script também implanta um site de exemplo para garantir que o servidor esteja funcional.

## Pré-requisitos

*   **Sistema Operacional:** Debian ou Ubuntu (ou outra distribuição baseada em Debian que utilize o gerenciador de pacotes `apt`).
*   **Permissões:** Acesso como superusuário (root) ou um usuário com permissões `sudo`.
*   **Conexão com a Internet:** Necessária para baixar os pacotes e o site de exemplo.

## Como Usar

1.  **Dar permissão de execução ao script:**
    ```bash
    chmod +x iac_apache_provision.sh
    ```

2.  **Executar o script com privilégios de superusuário:**
    ```bash
    sudo ./iac_apache_provision.sh
    ```

## O Que o Script Faz

O script executa as seguintes ações em sequência:

1.  **Atualização do Sistema:**
    *   Executa `apt-get update` e `apt-get upgrade -y` para garantir que a lista de pacotes e os próprios pacotes estejam atualizados.

2.  **Instalação de Pacotes:**
    *   Instala o servidor web `apache2`.
    *   Instala a ferramenta `unzip`, necessária para descompactar o site.

3.  **Download e Implantação do Site:**
    *   Navega para o diretório `/tmp`.
    *   Baixa um template de site em HTML5 do repositório `https://github.com/denilsonbonatti/html5-boilerplate`.
    *   Descompacta o arquivo baixado.
    *   Copia o conteúdo do site para o diretório raiz do Apache (`/var/www/html/`), substituindo a página padrão.

## Verificação

Após a execução bem-sucedida do script, você pode verificar se o servidor está funcionando:

1.  Abra um navegador web.
2.  Navegue até o endereço IP do seu servidor Linux.
3.  Você deverá ver o site de exemplo que foi implantado, em vez da página padrão do Apache.
