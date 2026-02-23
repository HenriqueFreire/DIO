# shell.nix
{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    azure-cli
    # jq # Descomente se precisar processar JSON na linha de comando
  ];
}