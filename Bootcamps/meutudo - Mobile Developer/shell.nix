{ pkgs ? import (fetchTarball {
  # Commit fixo do Nixpkgs que contém o Node.js 20.10.0
  url = "https://github.com/NixOS/nixpkgs/archive/4f8f3ddb2ae8a978244a211780610471a7931b4e.tar.gz";
}) {} }:

pkgs.mkShell {
  # Dependências do ambiente
  buildInputs = [
    pkgs.nodejs
  ];

  # Hook opcional ao entrar no shell
  shellHook = ''
    echo "Bem-vindo ao ambiente Node.js versão $(node --version)!"
  '';
}