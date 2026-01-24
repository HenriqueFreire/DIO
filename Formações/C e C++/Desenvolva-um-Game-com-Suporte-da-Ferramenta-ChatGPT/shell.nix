let
  pkgs = import <nixpkgs> {};
in
  pkgs.mkShell {
    buildInputs = with pkgs; [
      gcc
      gnumake
      pkg-config
      curl
      nlohmann_json
    ];
  }
