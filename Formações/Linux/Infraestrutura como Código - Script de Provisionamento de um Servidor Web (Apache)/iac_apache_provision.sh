#!/bin/bash

# Título: Script de Provisionamento de Servidor Web Apache
# Descrição: Este script instala e configura o Apache2 e implanta um site
#            simples a partir de um template da web.
# Autor: Henrique
# Data: 24/01/2026
# Versão: 1.0
#
# Nota: Este script é destinado a sistemas baseados em Debian/Ubuntu.

echo "Iniciando o provisionamento do servidor web Apache..."

# --- 1. ATUALIZAÇÃO DO SERVIDOR ---
echo "Atualizando os pacotes do sistema..."
apt-get update
apt-get upgrade -y
echo "Atualização concluída."

# --- 2. INSTALAÇÃO DO APACHE E OUTRAS FERRAMENTAS ---
echo "Instalando o Apache2 e o Unzip..."
apt-get install apache2 -y
apt-get install unzip -y
echo "Instalação concluída."

# --- 3. DOWNLOAD E IMPLANTAÇÃO DA APLICAÇÃO WEB ---
echo "Baixando e configurando a aplicação web..."

# Navega para o diretório temporário
cd /tmp

# Baixa o template do site
# Fonte: https://github.com/denilsonbonatti/html5-boilerplate
wget https://github.com/denilsonbonatti/html5-boilerplate/archive/refs/heads/main.zip

# Descompacta o arquivo
unzip main.zip

# Navega para o diretório do conteúdo do site
cd html5-boilerplate-main

# Copia todos os arquivos para o diretório padrão do Apache
cp -R * /var/www/html/

echo "Aplicação web implantada com sucesso."

# --- 4. FINALIZAÇÃO ---
echo "-----------------------------------------------------"
echo "Provisionamento do servidor web concluído com sucesso!"
echo "Acesse o endereço IP do seu servidor em um navegador para ver o site."
echo "-----------------------------------------------------"
