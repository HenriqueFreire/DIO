{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.nodejs_20
    pkgs.nodePackages.npm
  ];

  shellHook = ''
    echo "Ambiente Mahou Technologies carregado com Node.js $(node -v)"
  '';
}
