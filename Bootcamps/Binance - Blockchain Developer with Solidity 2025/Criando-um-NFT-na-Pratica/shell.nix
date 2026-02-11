{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.nodejs_20
    pkgs.nodePackages.npm
  ];

  shellHook = ''
    echo "Ambiente Nix com Node.js 20 ativado!"
    node -v
    npm -v
  '';
}
