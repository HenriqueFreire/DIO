{ pkgs ? import (fetchTarball {
  # Commit fixo do Nixpkgs para garantir reprodutibilidade
  url = "https://github.com/NixOS/nixpkgs/archive/1c1c9b3f5ec0421eaa0f22746295466ee6a8d48f.tar.gz";
}) { config = {
       allowUnfree = true;
      };
    }
  }:

pkgs.mkShell {
  # Dependências do ambiente
  buildInputs = with pkgs; [
    jdk17
    kotlin
  ];

  # Hook opcional ao entrar no shell
  shellHook = ''
    echo "Bem-vindo ao ambiente Kotlin!"
  '';
}