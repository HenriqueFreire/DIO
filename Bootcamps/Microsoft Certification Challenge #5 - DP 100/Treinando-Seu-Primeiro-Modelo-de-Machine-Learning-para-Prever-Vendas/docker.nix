{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/63dde259203998378d3f6655c65f299166f21226.tar.gz") {} }:

let
  # Custom python with only necessary packages
  pythonEnv = pkgs.python312.withPackages (ps: with ps; [
    pandas
    scikit-learn
    matplotlib
    numpy
  ]);

in
pkgs.dockerTools.buildLayeredImage {
  name = "corn-prediction-nix";
  tag = "latest";
  
  contents = [
    pkgs.pkgsStatic.busybox # For basic shell utilities
    pythonEnv
  ];

  config = {
    Cmd = [ "${pythonEnv}/bin/python" "/var/azureml-app/src/train.py" ];
    WorkingDir = "/var/azureml-app";
    Env = [
      "PYTHONUNBUFFERED=1"
    ];
  };
}
