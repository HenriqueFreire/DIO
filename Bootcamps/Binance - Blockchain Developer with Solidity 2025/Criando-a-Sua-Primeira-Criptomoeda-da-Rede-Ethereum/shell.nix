{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    nodejs_20
    curl
    git
  ];

  shellHook = ''
    echo "Ambiente de desenvolvimento (nix-shell) configurado!"
    echo "Node.js versão: $(node --version)"
    echo "NPM versão: $(npm --version)"
  '';
}
