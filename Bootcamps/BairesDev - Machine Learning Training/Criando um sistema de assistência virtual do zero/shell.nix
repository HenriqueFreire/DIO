{ pkgs ? import (builtins.fetchTarball {
  url = "https://github.com/NixOS/nixpkgs/archive/1c1c9b3f5ec0421eaa0f22746295466ee6a8d48f.tar.gz";
}) {} }:

let
  # Define um ambiente Python com pacotes específicos do Nix
  pythonEnv = pkgs.python312.withPackages (ps: with ps; [
    geopy
    gtts
    pip
    pyaudio
    pygame
    pygobject3
    speechrecognition
    wikipedia
    # Adicione outros pacotes python aqui
  ]);
in

pkgs.mkShell {
  buildInputs = with pkgs; [
    # O ambiente Python com tudo já instalado
    pythonEnv

    # Dependências de sistema para os pacotes Python
    #pkg-config
    #portaudio
    #alsa-lib
  ];

  shellHook = ''
    unset SOURCE_DATE_EPOCH
    echo "Ambiente Nix (puro) carregado."
    echo "As bibliotecas Python já estão disponíveis."
  '';
}
