{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  # Pacotes disponíveis neste ambiente
  buildInputs = [
    pkgs.pandoc
    pkgs.texlive.combined.scheme-small # Adicionado para ter o pdflatex
  ];
}
