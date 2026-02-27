{ pkgs ? import <nixpkgs> {} }:

let
  # Define the Node.js package for our API
  myTsApiPackage = pkgs.buildNpmPackage {
    pname = "my-ts-api";
    version = "1.0.0";
    src = pkgs.lib.cleanSource ./.;

    # This hash needs to be updated.
    npmDepsHash = "";

    buildPhase = ''
      echo "Running npm run build"
      npm run build
    '';

    installPhase = ''
      echo "Running installPhase"
      cp -r dist $out/dist
      cp -r package.json $out/package.json
      cp -r node_modules $out/node_modules
    '';
  };

in
pkgs.dockerTools.buildImage {
  name = "my-ts-api";
  tag = "latest";

  fromImage = pkgs.dockerTools.pullImage {
    imageName = "node";
    imageTag = "20-alpine";
    sha256 = ""; # Will be fetched later
  };

  contents = [
    myTsApiPackage
  ];

  config = {
    Cmd = [ "${pkgs.nodejs}/bin/node" "/dist/index.js" ]; # Node.js path from nixpkgs, and compiled app path
    ExposedPorts = { "3000/tcp" = {}; };
    WorkingDir = "/"; # Working directory in the container
  };
}
