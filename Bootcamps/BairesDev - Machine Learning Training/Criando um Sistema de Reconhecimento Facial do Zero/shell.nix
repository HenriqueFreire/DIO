{ pkgs ? import <nixpkgs> { } }:

let
  # Cria um interpretador Python customizado onde o pacote 'opencv4' é
  # substituído pela versão com suporte a GTK2.
  # Esta é a abordagem robusta que você encontrou.
  python-with-overrides = pkgs.python3.override {
    packageOverrides = self: super: {
      opencv4 = super.opencv4.override {
        enableGtk2 = true;
      };
    };
  };
in
pkgs.mkShell {
  # O caminho para os classificadores Haar vem do nosso pacote customizado.
  OPENCV_CASCADES_PATH = "${python-with-overrides.pkgs.opencv4}/share/opencv4/haarcascades";

  buildInputs = with pkgs; [
    # Disponibiliza o Python customizado com os pacotes necessários.
    (python-with-overrides.withPackages (ps: [
      ps.numpy
      ps.opencv4  # Agora 'opencv4' refere-se à versão com GTK.
      ps.pillow
    ]))

    # Dependências de sistema.
    gtk2
    imagemagick
  ];
}