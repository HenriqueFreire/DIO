{ pkgs ? import (fetchTarball {
  # Commit fixo do Nixpkgs que contém o Node.js 18.17.1
  url = "https://github.com/NixOS/nixpkgs/archive/1c1c9b3f5ec0421eaa0f22746295466ee6a8d48f.tar.gz";
}) {} }:

pkgs.mkShell {
  # Dependências do ambiente
  buildInputs = [
    pkgs.mysql-workbench
    pkgs.mariadb
    pkgs.dbeaver-bin
  ];

  # Hook opcional ao entrar no shell
  shellHook = ''
    echo "Bem-vindo ao ambiente de desenvolvimento com MySQL!"
  '';
}