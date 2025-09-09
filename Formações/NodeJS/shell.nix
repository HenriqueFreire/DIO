{ pkgs ? import (fetchTarball {
  # Este arquivo define um ambiente de desenvolvimento com base na versão 25.05 do NixOS.

  url = "https://github.com/NixOS/nixpkgs/archive/nixos-25.05.tar.gz";
}) {} }:

pkgs.mkShell {
  # Dependências do ambiente
  buildInputs = with pkgs; [
    nodejs_20
    prisma-engines 
    
    # Adicionados para compilação do Prisma
    pkgs.libiconv
    pkgs.openssl
  ];

  # Hook opcional ao entrar no shell
  shellHook = ''
    # Para garantir que o Prisma CLI esteja disponível após a instalação local
    if [ -f "node_modules/.bin/prisma" ]; then
      export PATH=$(pwd)/node_modules/.bin:$PATH
    fi

    

    echo "Bem-vindo ao ambiente Node.js versão $(node --version)!"
  '';
}