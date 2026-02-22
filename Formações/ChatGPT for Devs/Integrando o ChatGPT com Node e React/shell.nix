{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.nodejs_20
  ];

  shellHook = ''
    echo "Entering Nix-powered Node.js development environment."
    echo "Node.js version: $(node -v)"
    echo "npm version: $(npm -v)"
  '';
}
