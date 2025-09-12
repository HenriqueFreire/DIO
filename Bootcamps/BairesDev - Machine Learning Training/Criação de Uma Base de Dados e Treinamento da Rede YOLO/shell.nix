{ pkgs ? import (fetchTarball {
  # Este arquivo define um ambiente de desenvolvimento com base na versão 25.05 do NixOS.

  url = "https://github.com/NixOS/nixpkgs/archive/nixos-25.05.tar.gz";
}) {} }:

pkgs.mkShell {
  # Dependências do ambiente
  buildInputs = with pkgs; [
    python313
    python313Packages.pip
    python313Packages.virtualenv
    zlib
    stdenv.cc # Pacote que provê o compilador C/C++ e as bibliotecas padrão
    libGL
    glib

    # Adicionando OpenCV e Numpy diretamente do Nix para garantir a linkagem correta
    python313Packages.opencv4
    python313Packages.numpy
  ];

  # Hook opcional ao entrar no shell
  shellHook = ''
    echo "Ambiente Nix pronto."

    # Exporta LD_LIBRARY_PATH para que as bibliotecas do Nix sejam encontradas
    export LD_LIBRARY_PATH="${pkgs.zlib}/lib:${pkgs.stdenv.cc.cc.lib}/lib:${pkgs.libGL}/lib:${pkgs.glib}/lib:$LD_LIBRARY_PATH"

    echo "Para criar e ativar um ambiente virtual Python (se ainda não o fez):"
    echo "  1. python -m venv .dev"
    echo "  2. source .dev/bin/activate"
    echo "  3. pip install -r requirements.txt"
    echo "Para executar o script, use o comando: python3 src/main.py"
  '';
}