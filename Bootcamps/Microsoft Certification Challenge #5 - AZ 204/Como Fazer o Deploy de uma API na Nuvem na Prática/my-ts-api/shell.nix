{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    nodejs_20
    azure-cli
  ];
  shellHook = ''
    echo "Entering Nix-shell for TypeScript API development."
    echo "Node.js version: $(node -v)"
    echo "npm version: $(npm -v)"
  '';
}
