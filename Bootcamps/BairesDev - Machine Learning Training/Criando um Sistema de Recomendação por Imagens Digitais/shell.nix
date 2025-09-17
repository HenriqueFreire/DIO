let
  # Pinar o nixpkgs para um commit específico do ramo unstable (24.11)
  nixpkgs-commit = "d27c0d08ef25912c134b755d40a1bd1d843bfb7c";
  pkgs = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/${nixpkgs-commit}.tar.gz") {
    # Permite a instalação de pacotes como o TensorFlow
    config.allowUnfree = true;
  };

  python-with-overrides = pkgs.python311.override {
    packageOverrides = self: super: {
      fsspec = super.fsspec.overridePythonAttrs (oldAttrs: {
        doCheck = false;
      });
    };
  };
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    (python-with-overrides.withPackages (ps: [
      ps.numpy
      ps.pillow
      ps.tensorflow
      ps.scikitlearn
      ps.keras
    ]))
    zlib
    stdenv.cc
  ];
}
