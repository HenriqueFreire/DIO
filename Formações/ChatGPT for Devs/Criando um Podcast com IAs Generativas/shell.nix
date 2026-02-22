{ pkgs ? import (fetchTarball {
  # Commit fixo do Nixpkgs para garantir reprodutibilidade
  url = "https://github.com/NixOS/nixpkgs/archive/4415dfb27cfecbe40a127eb3e619fd6615731004.tar.gz";
}) {} }:

pkgs.mkShell {
  # Dependências do ambiente Python para o projeto
  buildInputs = with pkgs; [
    # Interpretador Python
    python3

    # Pacotes Python
    (python3.withPackages (ps: with ps; [
      pip
    ]))

    # Dependências de sistema (se necessário para compilação de pacotes C/C++ dos pacotes Python)
    pkg-config
  ];

  # Hook executado ao entrar no shell
  shellHook = ''
    echo "Bem-vindo ao ambiente de desenvolvimento Nix-shell!"
    echo "Verificando/configurando ambiente virtual Python..."

    # Verifica se o ambiente virtual já existe
    if [ ! -d ".venv" ]; then
      echo "Criando ambiente virtual Python..."
      python -m venv .venv
    fi

    # Ativa o ambiente virtual
    source .venv/bin/activate
    echo "Ambiente virtual Python ativado: ./.venv"

    # Instala/atualiza as dependências do requirements.txt se houver alterações
    if [ -f "requirements.txt" ]; then
      # Verifica se o requirements.txt mudou desde a última instalação
      if ! cmp -s "requirements.txt" ".venv/requirements_checksum.txt"; then
        echo "Instalando/atualizando pacotes do requirements.txt..."
        pip install -r requirements.txt
        cp "requirements.txt" ".venv/requirements_checksum.txt" # Guarda um checksum
      else
        echo "Pacotes do requirements.txt já estão instalados e atualizados."
      fi
    fi

    echo "Python versão no .venv: $(python --version)"
    echo "---------------------------------------------------------"
    echo "Para sair do ambiente virtual, use 'deactivate'."
    echo "Para sair do nix-shell, use 'exit'."
  '';
}