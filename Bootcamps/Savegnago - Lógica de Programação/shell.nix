{ pkgs ? import (fetchTarball {
  # Commit fixo do Nixpkgs que contém o Node.js 18.17.1
  url = "https://github.com/NixOS/nixpkgs/archive/4415dfb27cfecbe40a127eb3e619fd6615731004.tar.gz";
}) {} }:

pkgs.mkShell {
  # Dependências do ambiente
  buildInputs = [
    pkgs.nodejs-18_x
  ];

  # Hook opcional ao entrar no shell
  shellHook = ''
    echo "Bem-vindo ao ambiente Node.js versão $(node --version)!"
  '';
}