{ pkgs ? import <nixpkgs> {} }:

let
  nodejs = pkgs.nodejs_20; # Using Node.js 20.x
in
pkgs.mkShell {
  buildInputs = [
    nodejs
    nodejs.pkgs.npm
    pkgs.solc
    pkgs.http-server
    pkgs.kubo
  ];

  # Set environment variables if needed
  shellHook = ''
    echo "Welcome to the NFT Pokemon Battle development environment!"
    echo "Node.js version: $(node -v)"
    echo "npm version: $(npm -v)"
    export PATH=${pkgs.kubo}/bin:$PATH
  '';
}