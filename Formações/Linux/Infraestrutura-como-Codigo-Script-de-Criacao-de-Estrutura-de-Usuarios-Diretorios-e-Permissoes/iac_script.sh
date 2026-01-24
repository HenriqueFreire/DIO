#!/bin/bash

# Título: Script de Criação de Estrutura de Usuários, Diretórios e Permissões
# Descrição: Este script cria grupos, diretórios e usuários, definindo as permissões
#            adequadas para uma estrutura básica de T.I.
# Autor: Henrique
# Data: 24/01/2026
# Versão: 1.0

echo "Iniciando a execução do script de Infraestrutura como Código..."

# --- 1. CRIAÇÃO DOS GRUPOS ---
echo "Criando os grupos de usuários..."
grupos=("GRP_ADM" "GRP_VEN" "GRP_SEC")

for grupo in "${grupos[@]}"; do
    if getent group "$grupo" > /dev/null; then
        echo "O grupo $grupo já existe. Pulando."
    else
        groupadd "$grupo"
        echo "Grupo $grupo criado com sucesso."
    fi
done

# --- 2. CRIAÇÃO DOS DIRETÓRIOS ---
echo "Criando os diretórios..."
diretorios=("/publico" "/adm" "/ven" "/sec")

for dir in "${diretorios[@]}"; do
    if [ -d "$dir" ]; then
        echo "O diretório $dir já existe. Pulando."
    else
        mkdir "$dir"
        echo "Diretório $dir criado com sucesso."
    fi
done

# --- 3. DEFINIÇÃO DAS PERMISSÕES DOS DIRETÓRIOS ---
echo "Configurando as permissões dos diretórios..."

# Dono do diretório /adm será root e o grupo será GRP_ADM
chown root:GRP_ADM /adm
# Dono do diretório /ven será root e o grupo será GRP_VEN
chown root:GRP_VEN /ven
# Dono do diretório /sec será root e o grupo será GRP_SEC
chown root:GRP_SEC /sec

# Permissões: Dono (root) e grupo têm acesso total (rwx), outros não têm acesso (---)
chmod 770 /adm
chmod 770 /ven
chmod 770 /sec

# Permissão total para todos no diretório /publico
chmod 777 /publico

echo "Permissões configuradas."

# --- 4. CRIAÇÃO DOS USUÁRIOS ---
echo "Criando os usuários e associando-os aos grupos..."

# ATENÇÃO: A senha 'Senha123' é para fins de demonstração.
# Em um ambiente real, use um método mais seguro e force a troca no primeiro login.
senha_padrao=$(openssl passwd -1 "Senha123")

# Usuários do grupo ADM
useradd carlos -m -s /bin/bash -p "$senha_padrao" -g GRP_ADM
useradd maria -m -s /bin/bash -p "$senha_padrao" -g GRP_ADM
useradd joao -m -s /bin/bash -p "$senha_padrao" -g GRP_ADM

# Usuários do grupo VEN
useradd debora -m -s /bin/bash -p "$senha_padrao" -g GRP_VEN
useradd sebastiana -m -s /bin/bash -p "$senha_padrao" -g GRP_VEN
useradd roberto -m -s /bin/bash -p "$senha_padrao" -g GRP_VEN

# Usuários do grupo SEC
useradd josefina -m -s /bin/bash -p "$senha_padrao" -g GRP_SEC
useradd amanda -m -s /bin/bash -p "$senha_padrao" -g GRP_SEC
useradd rogerio -m -s /bin/bash -p "$senha_padrao" -g GRP_SEC

echo "Usuários criados com sucesso."

echo "Script finalizado. Estrutura criada com sucesso!"
