{
  description = "A flake for a multi-project Java application";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    storeFront = {
      url = "path:./StoreFront";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wareHouse = {
      url = "path:./WareHouse";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, storeFront, wareHouse }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [
          storeFront.devShells.${system}.default
          wareHouse.devShells.${system}.default
        ];
      };
    };
}
