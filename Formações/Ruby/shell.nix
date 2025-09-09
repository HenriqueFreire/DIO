{ pkgs ? import (fetchTarball {
  # Este arquivo define um ambiente de desenvolvimento com base na versão 25.05 do NixOS.

  url = "https://github.com/NixOS/nixpkgs/archive/nixos-25.05.tar.gz";
}) {} }:

pkgs.mkShell {
  # Dependências do ambiente
  buildInputs = with pkgs; [
    ruby
  ];

  # Hook opcional ao entrar no shell
  shellHook = ''
    echo "Bem-vindo ao ambiente Ruby versão $(ruby --version)!"
  '';
}