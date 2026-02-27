{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    azure-functions-core-tools
    nodejs
  ];
}
