{ pkgs ? import (builtins.fetchTarball {
  url = "https://github.com/NixOS/nixpkgs/archive/1c1c9b3f5ec0421eaa0f22746295466ee6a8d48f.tar.gz";
}) {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    jdk
    gradle
  ];

  shellHook = ''
    echo "Ambiente Java com Maven configurado!"
    echo "Você pode compilar e executar seus arquivos Java aqui."
  '';
}